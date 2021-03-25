import {ArticleType} from "../types/graphql/article-type";
import {isIterable} from "rxjs/internal-compatibility";
import {PreferenceType} from "../types/graphql/preference-type";
import * as moment from "moment";
import {AuthorType} from "../types/graphql/author-type";
import {LocationType} from "../types/graphql/location-type";
import {HighlightType} from "../types/graphql/highlight-type";
import {ArticleAnalyticsType} from "../types/graphql/article-analytics-type";
import {AuthorAnalyticsType} from "../types/graphql/author-analytics-type";
import {SectionType} from "../types/graphql/section-type";

export class TypeBuilder {
  public static async article(data: any): Promise<ArticleType | null> {
    if (data) {
      return {
        id: data.id,
        _extraProps: data._extraProps,
        articableId: data.articableId,
        articableType: data.articableType,
        authorId: data.authorId,
        breakingNews: data.breakingNews,
        draft: data.draft,
        exclusive: data.exclusive,
        globalRecommendation: data.globalRecommendation,
        highlight: data.highlight,
        image: data.image,
        imageThumbnail: data.imageThumbnail,
        keywordId: data.keywordId,
        metaTags: data.metaTags,
        name: data.name,
        note: data.note,
        noteOld: data.noteOld,
        plainText: data.plainText,
        published: data.published,
        publishedAt: data.publishedAt,
        scheduledTime: data.scheduledTime,
        shortDescription: data.shortDescription,
        slug: data.slug,
        updatedAt: data.updatedAt,
        createdAt: data.createdAt,
        updatedRecommendationOn: data.updatedRecommendationOn,
        userId: data.userId,
        videoUrl: data.videoUrl,

        // Custom Fields
        analytics: data.analytics ? await this.articleAnalytics(data.analytics) : null
      };
    }
    return null;
  }
  public static async articles(data: any[]): Promise<ArticleType[]> {
    const result: ArticleType[] = [];
    if (!data || !isIterable(data)) {
      return [];
    }
    for (const item of data) {
      const objectType = await TypeBuilder.article(item);
      if (objectType != null) {
        result.push(objectType);
      }
    }
    return result;
  }
  public static async preference(data: any): Promise<PreferenceType | null> {
    if (data) {
      return {
        id: data.id,
        key: data.key,
        value: data.value,
        createdAt: moment(data.createdAt),
        updatedAt: moment(data.updatedAt),
      };
    }
    return null;
  }
  public static async preferences(data: any[]): Promise<PreferenceType[]> {
    const result: PreferenceType[] = [];
    if (!data || !isIterable(data)) {
      return [];
    }
    for (const item of data) {
      const objectType = await TypeBuilder.preference(item);
      if (objectType != null) {
        result.push(objectType);
      }
    }
    return result;
  }
  public static async section(data: any): Promise<SectionType | null> {
    if (data) {
      return {
        id: data.id,
        color: data.color,
        description: data.description,
        facebook: data.facebook,
        name: data.name,
        order: data.order,
        slug: data.slug,
        twitter: data.twitter,
        createdAt: moment(data.createdAt),
        updatedAt: moment(data.updatedAt),
        visible: data.visible,
        _extraProps: data._extraProps,

        articles: data.articles ? await this.articles(data.articles) : null
      };
    }
    return null;
  }
  public static async sections(data: any[]): Promise<SectionType[]> {
    const result: SectionType[] = [];
    if (!data || !isIterable(data)) {
      return [];
    }
    for (const item of data) {
      const objectType = await TypeBuilder.section(item);
      if (objectType != null) {
        result.push(objectType);
      }
    }
    return result;
  }
  public static async author(data: any): Promise<AuthorType | null> {
    if (data) {
      return {
        id: data.id ?? -1,
        logo: data.logo ?? null,
        name: data.name ?? null,
        createdAt: moment(data.createdAt),
        updatedAt: moment(data.updatedAt),

        // Custom Fields
        analytics: data.analytics ? await this.authorAnalytics(data.analytics) : null
      };
    }
    return null;
  }
  public static async authors(data: any[]): Promise<AuthorType[]> {
    const result: AuthorType[] = [];
    if (!data || !isIterable(data)) {
      return [];
    }
    for (const item of data) {
      const objectType = await TypeBuilder.author(item);
      if (objectType != null) {
        result.push(objectType);
      }
    }
    return result;
  }
  public static async location(data: any): Promise<LocationType | null> {
    if (data) {
      return {
        id: data.id,
        key: data.key,
        name: data.name,
        description: data.description,
        latitude: data.latitude,
        longitude: data.longitude,
        createdAt: moment(data.createdAt),
        updatedAt: moment(data.updatedAt)
      };
    }
    return null;
  }
  public static async locations(data: any[]): Promise<LocationType[]> {
    const result: LocationType[] = [];
    if (!data || !isIterable(data)) {
      return [];
    }
    for (const item of data) {
      const objectType = await TypeBuilder.location(item);
      if (objectType != null) {
        result.push(objectType);
      }
    }
    return result;
  }
  public static async highlight(data: any): Promise<HighlightType | null> {
    if (data) {
      return {
        id: data.id,
        articleId: data.articleId,
        order: data.order ?? 0,
        scheduledTime: moment(data.scheduledTime),
        published: data.published ?? false,
        locationId: data.locationId,
        createdAt: moment(data.createdAt),
        updatedAt: moment(data.updatedAt),

        // Custom Fields
        article: data.article ? await this.article(data.article) : null
      };
    }
    return null;
  }
  public static async highlights(data: any[]): Promise<HighlightType[]> {
    const result: HighlightType[] = [];
    if (!data || !isIterable(data)) {
      return [];
    }
    for (const item of data) {
      const objectType = await TypeBuilder.highlight(item);
      if (objectType != null) {
        result.push(objectType);
      }
    }
    return result;
  }
  public static async articleAnalytics(data: any): Promise<ArticleAnalyticsType | null> {
    if (data) {
      return {
        totalViews: data.totalViews
      };
    }
    return null;
  }
  public static async authorAnalytics(data: any): Promise<AuthorAnalyticsType | null> {
    if (data) {
      return {
        totalViews: data.totalViews
      };
    }
    return null;
  }
}
