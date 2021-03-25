import { Injectable } from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {Observable} from "rxjs";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {SectionType} from "../../types/graphql/section-type";

@Injectable()
export class SectionGraphqlService extends BaseGraphqlService {

  querySections = gql`
    query {
      sections {
        id
        name
        description
        color
        slug
        facebook
        order
        twitter
        visible
        updatedAt
        createdAt
        _extraProps
      }
    }
  `;
  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }


  public all(): Observable<SectionType[]> {
    return this.apollo.query<{ sections: any[] }, {}>({
      query: this.querySections
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.sections(value.data.sections)));
  }
}
