import * as moment from "moment-timezone";
import {ArticleType} from "./article-type";

export interface SectionType {
  id: number;
  color: string | null;
  description: string | null;
  facebook: string | null;
  name: string;
  order: number | null;
  slug: string | null;
  twitter: string | null;
  createdAt: moment.Moment;
  updatedAt: moment.Moment;
  visible: boolean;
  _extraProps: string | null;

  // Custom Fields
  articles: ArticleType[] | null;
}
