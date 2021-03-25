import {Injectable} from '@angular/core';
import {BaseGraphqlService} from "./base-graphql.service";
import {Apollo, gql} from "apollo-angular";
import {AuthService} from "../auth.service";
import {Observable} from "rxjs";
import {catchError, mergeMap} from "rxjs/operators";
import {TypeBuilder} from "../../util/type-builder";
import {HighlightType} from "../../types/graphql/highlight-type";
import {UpsertHighlightInput} from "../../types/graphql/inputs/upsert-highlight-input";

@Injectable()
export class HighlightGraphqlService extends BaseGraphqlService {
  queryCurrentHighlightsByLocation = gql`
    query currentHighlights($locationId: Int!) {
      currentHighlightsByLocation(locationId: $locationId) {
        id
        articleId
        order
        published
        scheduledTime
        locationId
        createdAt
        updatedAt
        article {
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
        }
      }
    }
  `;

  mutationCreateHighlight = gql`
    mutation create($input: UpsertHighlightInput!) {
      createHighlight(input: $input) {
        id
        articleId
        order
        published
        scheduledTime
        locationId
        createdAt
        updatedAt
      }
    }
  `;

  mutationUpdateHighlight = gql`
    mutation update($id: Int!, $input: UpsertHighlightInput!) {
      updateHighlight(id: $id, input: $input) {
        id
        articleId
        order
        published
        scheduledTime
        locationId
        createdAt
        updatedAt
      }
    }
  `;

  mutationDeleteHighlight = gql`
    mutation delete($id: Int!) {
      deleteHighlight(id: $id) {
        id
        articleId
        order
        published
        scheduledTime
        locationId
        createdAt
        updatedAt
      }
    }
  `;

  constructor(authService: AuthService, apollo: Apollo) {
    super(authService, apollo);
  }

  public currentByLocation(locationId: number): Observable<HighlightType[]> {
    return this.apollo.query<{ currentHighlightsByLocation: any[] }, { locationId: number }>({
      query: this.queryCurrentHighlightsByLocation,
      variables: {
        locationId
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.highlights(value.data.currentHighlightsByLocation)));

  }

  public create(input: UpsertHighlightInput): Observable<HighlightType | null> {
    return this.apollo.query<{ createHighlight: any }, { input: UpsertHighlightInput }>({
      query: this.mutationCreateHighlight,
      variables: {
        input
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.highlight(value.data.createHighlight)));
  }

  public update(id: number, input: UpsertHighlightInput): Observable<HighlightType | null> {
    return this.apollo.query<{ updateHighlight: any }, { id: number, input: UpsertHighlightInput }>({
      query: this.mutationUpdateHighlight,
      variables: {
        id,
        input
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.highlight(value.data.updateHighlight)));
  }

  public delete(id: number): Observable<HighlightType | null> {
    return this.apollo.query<{ deleteHighlight: any }, { id: number }>({
      query: this.mutationDeleteHighlight,
      variables: {
        id
      }
    }).pipe(catchError(err => this.handleError(err)),
      mergeMap(value => TypeBuilder.highlight(value.data.deleteHighlight)));
  }
}
