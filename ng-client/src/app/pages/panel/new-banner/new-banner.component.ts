import { Component, OnInit } from '@angular/core';
import {BannerService} from "../../../services/banner.service";
import {NewBanner} from "../../../models/NewBanner";

@Component({
  selector: 'app-new-banner',
  templateUrl: './new-banner.component.html',
  styleUrls: ['./new-banner.component.scss']
})
export class NewBannerComponent implements OnInit {

  newBanners: NewBanner[] = [];
  constructor(private bannerService: BannerService) { }

  ngOnInit(): void {
    this.bannerService.getAllBanners().subscribe(value => {
      this.newBanners = value;
    });
  }
  deleteBanner(id: number) {
    if (confirm('Eliminar el banner?')) {
      this.bannerService.deleteBanner(id).subscribe(() => {
        this.bannerService.getAllBanners().subscribe(value => {
          this.newBanners = value;
        });
      })
    }
  }
  isBetweenDates(date1: Date, date2: Date): boolean {
    const dateNow = new Date();
    return (dateNow > date1 && dateNow < date2)
  }
}
