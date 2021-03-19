import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {PreferenceComponent} from "./preference.component";
import {ReactiveFormsModule} from "@angular/forms";


@NgModule({
  declarations: [
    PreferenceComponent,
  ],
  imports: [
      CommonModule,
      ReactiveFormsModule
  ],
})
export class PreferenceModule { }
