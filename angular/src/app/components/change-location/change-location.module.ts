import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {ChangeLocationComponent} from "./change-location.component";
import {ReactiveFormsModule} from "@angular/forms";



@NgModule({
  declarations: [
    ChangeLocationComponent
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule
  ]
})
export class ChangeLocationModule { }
