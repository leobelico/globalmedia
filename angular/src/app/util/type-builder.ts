import {ArticleType} from "../types/graphql/article-type";
import {isIterable} from "rxjs/internal-compatibility";
import {PreferenceType} from "../types/graphql/preference-type";
import * as moment from "moment";

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
        locationId: data.locationId,
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
        totalViews: data.totalViews,
        updatedAt: data.updatedAt,
        createdAt: data.createdAt,
        updatedRecommendationOn: data.updatedRecommendationOn,
        userId: data.userId,
        videoUrl: data.videoUrl,
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
}
