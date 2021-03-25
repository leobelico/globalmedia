import {Injectable} from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {ArticleType} from "../../types/graphql/article-type";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {Observable} from "rxjs";

@Injectable()
export class ArticleGraphqlService extends BaseGraphqlService {
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
        updatedAt
        createdAt
        updatedRecommendationOn
        userId
        videoUrl
        _extraProps
        analytics {
          totalViews
        }
      }
    }
  `;
  queryMostViewedArticlesBySection = gql`
    query mostViewedArticlesBySection($sectionId: Int!, $from: String!, $to: String!, $limit: Int = 10) {
      mostViewedArticlesBySection(sectionId: $sectionId, from: $from, to: $to, limit: $limit) {
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
        updatedAt
        createdAt
        updatedRecommendationOn
        userId
        videoUrl
        _extraProps
        analytics {
          totalViews
        }
      }
    }
  `;

  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }

  public mostViewedArticles(from: string, to: string, limit: number = 10): Observable<ArticleType[]> {
    return this.apollo.query<{ mostViewedArticles: any[] }, { from: string, to: string, limit?: number }>({
      query: this.queryMostViewedArticles,
      variables: {
        from,
        to,
        limit
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.articles(value.data.mostViewedArticles)));

  }

  public mostViewedArticlesBySection(sectionId: number, from: string, to: string, limit: number = 10): Observable<ArticleType[]> {
    return this.apollo.query<{ mostViewedArticlesBySection: any[] }, { sectionId: number, from: string, to: string, limit?: number }>({
      query: this.queryMostViewedArticlesBySection,
      variables: {
        sectionId,
        from,
        to,
        limit
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.articles(value.data.mostViewedArticlesBySection)));

  }

}
