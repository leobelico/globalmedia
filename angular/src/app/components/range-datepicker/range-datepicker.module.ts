import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {RangeDatepickerComponent} from "./range-datepicker.component";
import {NgbDatepickerModule} from "@ng-bootstrap/ng-bootstrap";



@NgModule({
  declarations: [
    RangeDatepickerComponent
  ],
  imports: [
    CommonModule,
    NgbDatepickerModule
  ],
  exports: [
    RangeDatepickerComponent
  ]
})
export class RangeDatepickerModule { }
