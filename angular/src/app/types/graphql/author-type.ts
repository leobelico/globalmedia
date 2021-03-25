import * as moment from "moment-timezone";
import {AuthorAnalyticsType} from "./author-analytics-type";

export interface AuthorType {
  id: number;
  logo: string | null;
  name: string | null;
  createdAt: moment.Moment;
  updatedAt: moment.Moment;

  // Custom Fields
  analytics: AuthorAnalyticsType | null;
}
