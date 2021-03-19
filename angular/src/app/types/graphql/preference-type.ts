import * as moment from "moment-timezone";

export interface PreferenceType {
  id: number;
  key: string;
  value: string;
  createdAt: moment.Moment;
  updatedAt: moment.Moment;
}
