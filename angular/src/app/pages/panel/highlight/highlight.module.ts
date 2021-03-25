import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {HighlightComponent} from "./highlight.component";
import {ReactiveFormsModule} from "@angular/forms";
import {TzModule} from "../../../pipes/tz/tz.module";
import {NgbDatepickerModule, NgbTimepickerModule, NgbTooltipModule} from "@ng-bootstrap/ng-bootstrap";



@NgModule({
  declarations: [
    HighlightComponent
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    TzModule,
    NgbTooltipModule,
    NgbDatepickerModule,
    NgbTimepickerModule
  ]
})
export class HighlightModule { }
