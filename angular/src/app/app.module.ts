import {ApplicationRef, Injector, NgModule} from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import {PanelModule} from "./pages/panel/panel.module";
import {createCustomElement} from "@angular/elements";
import {AnalyticsComponent} from "./pages/panel/analytics/analytics.component";
import { GraphQLModule } from './graphql.module';
import { HttpClientModule } from '@angular/common/http';
import {LocalStorageService} from "./services/local-storage.service";
import {AuthService} from "./services/auth.service";
import {ConfigurationService} from "./services/configuration.service";
import {NavigationService} from "./services/navigation.service";
import {ArticleGraphqlService} from "./services/graphql/article-graphql.service";
import {PreferenceGraphqlService} from "./services/graphql/preference-graphql.service";
import {PreferenceComponent} from "./pages/panel/preference/preference.component";
import {AuthorGraphqlService} from "./services/graphql/author-graphql.service";

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    PanelModule,
    GraphQLModule,
    HttpClientModule
  ],
  providers: [
    LocalStorageService,
    AuthService,
    ConfigurationService,
    NavigationService,
    //Graphql Services
    ArticleGraphqlService,
    AuthorGraphqlService,
    PreferenceGraphqlService
  ],
  // bootstrap: [AppComponent] // Commented for angular elements
})
export class AppModule {
  constructor(private injector: Injector) {
  }
  ngDoBootstrap(appRef: ApplicationRef): void {
    if (document.querySelector('app-root')) {
      appRef.bootstrap(AppComponent);
    }

    const panelAnalytics = createCustomElement(AnalyticsComponent, {injector: this.injector});
    const panelPreference = createCustomElement(PreferenceComponent, {injector: this.injector});


    customElements.get('panel-analytics') || customElements.define("panel-analytics", panelAnalytics);
    customElements.get('panel-preference') || customElements.define("panel-preference", panelPreference);

  }
}
