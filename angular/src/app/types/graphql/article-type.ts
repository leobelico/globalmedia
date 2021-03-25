import * as moment from "moment-timezone";
import {ArticleAnalyticsType} from "./article-analytics-type";

export interface ArticleType {
  id: number;
  _extraProps: string | null;
  articableId: number | null;
  articableType: string | null;
  authorId: number | null;
  breakingNews: boolean
  draft: number | null;
  exclusive: boolean;
  globalRecommendation: boolean;
  highlight: boolean;
  image: string | null;
  imageThumbnail: string | null;
  keywordId: number | null;
  metaTags: string | null;
  name: string | null;
  note: string | null;
  noteOld: string | null;
  plainText: string | null;
  published: boolean
  publishedAt: moment.Moment | null;
  scheduledTime: moment.Moment | null;
  shortDescription: string | null;
  slug: string | null;
  updatedAt: moment.Moment
  createdAt: moment.Moment;
  updatedRecommendationOn: moment.Moment | null;
  userId: number | null;
  videoUrl: string | null;

  // Custom Fields
  analytics: ArticleAnalyticsType | null;
  // section: Section!
  // author: Author
}
