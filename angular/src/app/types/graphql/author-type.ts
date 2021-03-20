import * as moment from "moment-timezone";

export interface AuthorType {
  id: number;
  logo: string | null;
  name: string | null;
  totalViews: number;
  createdAt: moment.Moment;
  updatedAt: moment.Moment;
}
