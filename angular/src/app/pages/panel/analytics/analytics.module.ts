import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {AnalyticsComponent} from "./analytics.component";
import {ChartsModule} from "ng2-charts";
import {NgbDatepickerModule} from "@ng-bootstrap/ng-bootstrap";
import {RangeDatepickerModule} from "../../../components/range-datepicker/range-datepicker.module";



@NgModule({
  declarations: [
    AnalyticsComponent
  ],
  imports: [
    CommonModule,
    ChartsModule,
    NgbDatepickerModule,
    RangeDatepickerModule
  ]
})
export class AnalyticsModule { }
