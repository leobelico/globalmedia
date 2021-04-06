import {Injectable} from '@angular/core';
import * as moment from 'moment-timezone';
import {BehaviorSubject, Observable, ReplaySubject} from "rxjs";

@Injectable()
export class ConfigurationService {

  public timeZone = 'America/Mexico_City';
  public locale = 'es';
  public appName = 'GlobalMedia';
  public static defaultSubdomainKey = 'san-luis';

  private _subdomainKey: string = 'san-luis';

  private $subdomainKey: ReplaySubject<string> = new ReplaySubject<string>(1);

  constructor() {
    this.setLocale(this.locale);
    this.loadSubdomainKey();
  }
  private loadSubdomainKey(): void {
    const hostname = window.location.hostname;
    const hostnameSplit = hostname.split('.');
    let subdomainKey = hostnameSplit[0];
    if (!subdomainKey || subdomainKey === 'www') {
      subdomainKey = ConfigurationService.defaultSubdomainKey;
    }
    this.setSubdomainKey(subdomainKey);
  }
  public get subdomainKey(): Observable<string> {
    return this.$subdomainKey.asObservable();
  }

  public setSubdomainKey(key: string): void {
    this._subdomainKey = key;
    this.$subdomainKey.next(this._subdomainKey);
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
