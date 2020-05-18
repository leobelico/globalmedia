import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { NewBannerRoutingModule } from './new-banner-routing.module';
import {NewBannerComponent} from "./new-banner.component";
import {BannerService} from "../../../services/banner.service";
import { UpsertComponent } from './upsert/upsert.component';
import {NgbDatepickerModule, NgbNavModule} from "@ng-bootstrap/ng-bootstrap";
import {ReactiveFormsModule} from "@angular/forms";
import {QuillModule} from "ngx-quill";


@NgModule({
  declarations: [NewBannerComponent, UpsertComponent],
  imports: [
    CommonModule,
    NewBannerRoutingModule,
    NgbDatepickerModule,
    ReactiveFormsModule,
    QuillModule.forRoot({
      modules: {
        toolbar: [
          // ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
          [ /*'blockquote',*/ 'code-block'],

          // [{ 'header': 1 }, { 'header': 2 }],               // custom button values
          // [{ 'list': 'ordered'}, { 'list': 'bullet' }],
          // [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
          // [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
          // [{ 'direction': 'rtl' }],                         // text direction

          // [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
          // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

          // [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
          // [{ 'font': [] }],
          [{ 'align': [] }],

          // ['clean'],                                         // remove formatting button

          ['link', 'image']
        ]
      }
    })
  ],
  exports: [NewBannerComponent],
  providers: [BannerService]
})
export class NewBannerModule { }
