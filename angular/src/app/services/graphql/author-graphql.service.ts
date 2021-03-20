import { Injectable } from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {Observable} from "rxjs";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {AuthorType} from "../../types/graphql/author-type";

@Injectable()
export class AuthorGraphqlService extends BaseGraphqlService {

  queryMostViewedAuthors = gql`
    query mostViewedAuthors($from: String!, $to: String!, $limit: Int = 10) {
      mostViewedAuthors(from: $from, to: $to, limit: $limit) {
        id
        name
        logo
        totalViews(from: $from, to: $to)
        createdAt
        updatedAt
      }
    }
  `;

  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }

  public mostViewedAuthors(from: string, to: string, limit: number = 10): Observable<AuthorType[]> {
    console.log(from, to);
    return this.apollo.query<{mostViewedAuthors: any[]}, {from: string, to: string, limit?: number}>({
      query: this.queryMostViewedAuthors,
      variables: {
        from,
        to,
        limit
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.authors(value.data.mostViewedAuthors)));

  }
}
