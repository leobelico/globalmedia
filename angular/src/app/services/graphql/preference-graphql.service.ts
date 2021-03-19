import {Injectable} from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {Observable} from "rxjs";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {PreferenceType} from "../../types/graphql/preference-type";
import {UpsertPreferenceInput} from "../../types/graphql/inputs/upsert-preference-input";

@Injectable()
export class PreferenceGraphqlService extends BaseGraphqlService {

  queryPreferences = gql`
    query {
      preferences {
        id
        key
        value
        createdAt
        updatedAt
      }
    }
  `;

  mutationCreatePreference = gql`
    mutation create($input: UpsertPreferenceInput!) {
      createPreference(input: $input) {
        id
        key
        value
        createdAt
        updatedAt
      }
    }
  `;

  mutationUpdatePreference = gql`
    mutation update($id: Int!, $input: UpsertPreferenceInput!) {
      updatePreference(id: $id, input: $input) {
        id
        key
        value
        createdAt
        updatedAt
      }
    }
  `;

  mutationDeletePreference = gql`
    mutation delete($id: Int!) {
      deletePreference(id: $id) {
        id
        key
        value
        createdAt
        updatedAt
      }
    }
  `;

  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }


  public all(): Observable<PreferenceType[]> {
    return this.apollo.query<{ preferences: any[] }, {}>({
      query: this.queryPreferences
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.preferences(value.data.preferences)));
  }

  public create(input: UpsertPreferenceInput): Observable<PreferenceType | null> {
    return this.apollo.query<{ createPreference: any }, { input: UpsertPreferenceInput }>({
      query: this.mutationCreatePreference,
      variables: {
        input
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.preference(value.data.createPreference)));
  }

  public update(id: number, input: UpsertPreferenceInput): Observable<PreferenceType | null> {
    return this.apollo.query<{ updatePreference: any }, { id: number, input: UpsertPreferenceInput }>({
      query: this.mutationUpdatePreference,
      variables: {
        id,
        input
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.preference(value.data.updatePreference)));
  }

  public delete(id: number): Observable<PreferenceType | null> {
    return this.apollo.query<{ deletePreference: any }, { id: number }>({
      query: this.mutationDeletePreference,
      variables: {
        id
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.preference(value.data.deletePreference)));
  }

}

