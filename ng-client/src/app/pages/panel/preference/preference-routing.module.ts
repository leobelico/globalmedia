import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {UpsertComponent} from "./upsert/upsert.component";
import {PreferenceComponent} from "./preference.component";


const routes: Routes = [
  {
    path: '',
    component: PreferenceComponent
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
export class PreferenceRoutingModule { }
