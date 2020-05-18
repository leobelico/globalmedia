import { Component, OnInit } from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {NewBanner} from "../../../../models/NewBanner";
import {BannerService} from "../../../../services/banner.service";
import {ActivatedRoute, Router} from "@angular/router";

@Component({
  selector: 'app-upsert',
  templateUrl: './upsert.component.html',
  styleUrls: ['./upsert.component.scss']
})
export class UpsertComponent implements OnInit {

  formGroupUpsert: FormGroup;

  private updateId: number | null = null;
  constructor(private bannerService: BannerService,
              private router: Router,
              private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {
    const updateId = this.activatedRoute.snapshot.params['id'];
    if (updateId) {
      this.updateId = updateId;
      this.bannerService.getBannerById(updateId).subscribe(value => {
        const dateShowAt = new Date(value.show_at);
        const dateExpiryAt = new Date(value.expiry_at);
        console.log(dateShowAt);
        console.log(dateExpiryAt);
        const showAt = {
          year: dateShowAt.getFullYear(),
          month: dateShowAt.getMonth() + 1,
          day: dateShowAt.getDate(),
        };
        const expiryAt = {
          year: dateExpiryAt.getFullYear(),
          month: dateExpiryAt.getMonth() + 1,
          day: dateExpiryAt.getDate(),
        };
        this.formGroupUpsert = new FormGroup({
          name: new FormControl(value.name, [Validators.required]),
          description: new FormControl(value.description),
          type: new FormControl(value.banner_type, [Validators.required]),
          content: new FormControl(value.content, [Validators.required]),
          isActive: new FormControl(value.is_active, [Validators.required]),
          showAt: new FormControl(showAt, [Validators.required]),
          expiryAt: new FormControl(expiryAt, [Validators.required]),
        });
      });
    } else {
      this.formGroupUpsert = new FormGroup({
        name: new FormControl('', [Validators.required]),
        description: new FormControl(''),
        type: new FormControl('interstitial', [Validators.required]),
        content: new FormControl('', [Validators.required]),
        isActive: new FormControl(false, [Validators.required]),
        showAt: new FormControl(false, [Validators.required]),
        expiryAt: new FormControl(false, [Validators.required]),
      });
    }
  }

  onSubmit() {
    for (const i in this.formGroupUpsert.controls) {
      this.formGroupUpsert.controls[i].markAsDirty();
      this.formGroupUpsert.controls[i].updateValueAndValidity();
      console.log(this.formGroupUpsert.controls[i].value);
    }
    if (this.formGroupUpsert.invalid) {
      return;
    }
    const newBanner: NewBanner = new NewBanner();
    newBanner.name = this.formGroupUpsert.controls['name'].value;
    newBanner.description = this.formGroupUpsert.controls['description'].value;
    newBanner.banner_type = this.formGroupUpsert.controls['type'].value;
    newBanner.content = this.formGroupUpsert.controls['content'].value;
    newBanner.is_active = this.formGroupUpsert.controls['isActive'].value;
    const show = this.formGroupUpsert.controls['showAt'].value;
    const expiry = this.formGroupUpsert.controls['expiryAt'].value;

    const dateShow = new Date(show.year, show.month - 1, show.day, 0, 0, 0);
    const dateExpiry = new Date(expiry.year, expiry.month - 1, expiry.day, 23, 59, 59);
    newBanner.show_at = dateShow.toLocaleString();
    newBanner.expiry_at = dateExpiry.toLocaleString();

    if (this.updateId) {
      this.bannerService.updateBanner(this.updateId, newBanner).subscribe(value => {
        this.router.navigate(['/panel/new-banner']);
      });
    } else {
      this.bannerService.createBanner(newBanner).subscribe(value => {
        this.router.navigate(['/panel/new-banner']);
      });
    }
  }
}
