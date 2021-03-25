import {Injectable} from '@angular/core';
import {environment} from "../../environments/environment";

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
}
