import {Injectable} from '@angular/core';
import * as moment from 'moment-timezone';

@Injectable()
export class ConfigurationService {

  public timeZone = 'America/Mexico_City';
  public locale = 'es';
  public appName = 'GlobalMedia';

  constructor() {
    this.setLocale(this.locale);
  }

  public setTimeZone(timezone: string): void {
    this.timeZone = timezone;
  }

  public dateToMoment(date: Date): moment.Moment {
    return moment(date).tz(this.timeZone);
  }

  public setLocale(locale: string): void {
    this.locale = locale;
    moment.locale(this.locale);
  }

  public tzToTimeZoneFormat(timezone: string | moment.Moment | null, format: string): string {
    if (!timezone) {
      return '';
    }
    const momentDate = (typeof timezone === 'string') ? moment(timezone) : timezone;
    momentDate.locale(this.locale);
    return momentDate.tz(this.timeZone).format(format);
  }
}
