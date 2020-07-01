import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  {
    path: 'new-banner',
    loadChildren: () => import('./new-banner/new-banner.module').then(m => m.NewBannerModule)
  },
  {
    path: 'preference',
    loadChildren: () => import('./preference/preference.module').then(m => m.PreferenceModule)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PanelRoutingModule { }
