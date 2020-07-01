import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PreferenceRoutingModule } from './preference-routing.module';
import {PreferenceComponent} from "./preference.component";
import { UpsertComponent } from './upsert/upsert.component';
import {PreferenceService} from "../../../services/preference.service";
import {ReactiveFormsModule} from "@angular/forms";


@NgModule({
  declarations: [PreferenceComponent, UpsertComponent],
    imports: [
        CommonModule,
        PreferenceRoutingModule,
        ReactiveFormsModule
    ],
  exports: [PreferenceComponent, UpsertComponent],
  providers: [PreferenceService]
})
export class PreferenceModule { }
