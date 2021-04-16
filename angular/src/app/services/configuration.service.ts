import {Injectable} from '@angular/core';
import * as moment from 'moment-timezone';
import {BehaviorSubject, Observable, ReplaySubject} from "rxjs";
import {LocationGraphqlService} from "./graphql/location-graphql.service";
import {LocationType} from "../types/graphql/location-type";

@Injectable()
export class ConfigurationService {

  public timeZone = 'America/Mexico_City';
  public locale = 'es';
  public appName = 'GlobalMedia';
  public static defaultSubdomainKey = 'san-luis';

  private _subdomainKey: string = 'san-luis';
  private _location: LocationType | null = null;

  private $subdomainKey: ReplaySubject<string> = new ReplaySubject<string>(1);
  private $location: ReplaySubject<LocationType> = new ReplaySubject<LocationType>(1);

  constructor(private locationGraphqlService: LocationGraphqlService) {
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
    this.locationGraphqlService.all().subscribe(locations => {
      for (const locationX of locations) {
        if (locationX.key === subdomainKey) {
          this.setLocation(locationX);
          break;
        }
      }
    });
  }
  public get subdomainKey(): Observable<string> {
    return this.$subdomainKey.asObservable();
  }

  public setSubdomainKey(key: string): void {
    this._subdomainKey = key;
    this.$subdomainKey.next(this._subdomainKey);
  }

  public get location(): Observable<LocationType> {
    return this.$location.asObservable();
  }

  public setLocation(location: LocationType): void {
    this._location = location;
    this.$location.next(this._location);
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
