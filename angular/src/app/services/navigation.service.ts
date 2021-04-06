import {Injectable} from '@angular/core';
import {environment} from "../../environments/environment";
import {ConfigurationService} from "./configuration.service";

@Injectable()
export class NavigationService {

  protected baseUrl = environment.baseUrl;
  constructor() {
  }

  openTabAnalyticsExport(from: string, to: string): void {
    open(`${this.baseUrl}/panel/analytics/export/${from}/${to}`);
  }
  openTabArticleBySlug(slug: string): void {
    open(`${this.baseUrl}/articles/${slug}`);
  }

  changeLocationHost(subdomainKey: string): void {
    if (subdomainKey === ConfigurationService.defaultSubdomainKey) {
      subdomainKey = 'www'
    }
    const href = window.location.href;
    const hostname = window.location.hostname;
    const hostnameSplit = hostname.split('.');
    if (subdomainKey !== hostnameSplit[0]) {
      const matches = href.match('(^http[s]?:\\/\\/)([a-zA-Z\\-]+)(.+)');
      if (matches) {
        const finalLocation = matches[1] + subdomainKey + matches[3];
        window.location.replace(finalLocation);
      }
    }
  }
}
