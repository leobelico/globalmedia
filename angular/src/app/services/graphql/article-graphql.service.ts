import { Injectable } from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {ArticleType} from "../../types/graphql/article-type";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {Observable} from "rxjs";

@Injectable()
export class ArticleGraphqlService extends BaseGraphqlService{
  queryMostViewedArticles = gql`
    query mostViewedArticles($from: String!, $to: String!, $limit: Int = 10) {
      mostViewedArticles(from: $from, to: $to, limit: $limit) {
        id
        articableId
        articableType
        authorId
        breakingNews
        draft
        exclusive
        globalRecommendation
        highlight
        image
        imageThumbnail
        keywordId
        locationId
        metaTags
        name
        note
        noteOld
        plainText
        published
        publishedAt
        scheduledTime
        shortDescription
        slug
        totalViews
        updatedAt
        createdAt
        updatedRecommendationOn
        userId
        videoUrl
        _extraProps
      }
    }
  `;

  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }

  public mostViewedArticles(from: string, to: string, limit: number = 10): Observable<ArticleType[]> {
    return this.apollo.query<{mostViewedArticles: any[]}, {from: string, to: string, limit?: number}>({
      query: this.queryMostViewedArticles,
      variables: {
        from,
        to,
        limit
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.articles(value.data.mostViewedArticles)));

  }

}
