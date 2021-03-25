import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {ArticleModule} from "./article/article.module";
import {NgbModule} from "@ng-bootstrap/ng-bootstrap";
import {AnalyticsModule} from "./analytics/analytics.module";
import {PreferenceModule} from "./preference/preference.module";
import {HighlightModule} from "./highlight/highlight.module";



@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    NgbModule,
    AnalyticsModule,
    ArticleModule,
    HighlightModule,
    PreferenceModule
  ]
})
export class PanelModule { }
