import { Injectable } from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {Observable} from "rxjs";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {LocationType} from "../../types/graphql/location-type";

@Injectable()
export class LocationGraphqlService extends BaseGraphqlService {
  queryLocations = gql`
    query {
      locations {
        id
        key
        name
        description
        latitude
        longitude
        createdAt
        updatedAt
      }
    }
  `;

  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }

  public all(): Observable<LocationType[]> {
    return this.apollo.query<{locations: any[]}, {}>({
      query: this.queryLocations
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.locations(value.data.locations)));

  }
}

