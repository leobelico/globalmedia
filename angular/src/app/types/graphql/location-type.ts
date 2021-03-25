import * as moment from "moment-timezone";

export interface LocationType {
  id: number;
  key: string;
  name: string;
  description: string | null;
  latitude: number;
  longitude: number;
  createdAt: moment.Moment;
  updatedAt: moment.Moment;
}
