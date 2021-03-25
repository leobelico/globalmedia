import * as moment from "moment-timezone";
import {ArticleType} from "./article-type";

export interface HighlightType {
  id: number;
  articleId: number;
  order: number;
  scheduledTime: moment.Moment;
  published: boolean;
  locationId: number;
  createdAt: moment.Moment;
  updatedAt: moment.Moment;

  // Custom Fields
  article: ArticleType | null;
}
