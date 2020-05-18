import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {NewBannerComponent} from "./new-banner.component";
import {HashLocationStrategy} from "@angular/common";
import {UpsertComponent} from "./upsert/upsert.component";


const routes: Routes = [
  {
    path: '',
    component: NewBannerComponent
  },
  {
    path: 'create',
    component: UpsertComponent
  },
  {
    path: 'edit/:id',
    component: UpsertComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class NewBannerRoutingModule { }
