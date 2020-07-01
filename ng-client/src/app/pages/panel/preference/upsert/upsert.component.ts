import { Component, OnInit } from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {BannerService} from "../../../../services/banner.service";
import {ActivatedRoute, Router} from "@angular/router";
import {NewBanner} from "../../../../models/NewBanner";
import {PreferenceService} from "../../../../services/preference.service";
import {Preference} from "../../../../models/Preference";

@Component({
  selector: 'app-upsert',
  templateUrl: './upsert.component.html',
  styleUrls: ['./upsert.component.scss']
})
export class UpsertComponent implements OnInit {

  formGroupUpsert: FormGroup;

  private updateId: number | null = null;
  constructor(private preferenceService: PreferenceService,
              private router: Router,
              private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {
    const updateId = this.activatedRoute.snapshot.params['id'];
    if (updateId) {
      this.updateId = updateId;
      this.preferenceService.find(updateId).subscribe(value => {

        this.formGroupUpsert = new FormGroup({
          key: new FormControl(value.key, [Validators.required]),
          value: new FormControl(value.value),
        });
      });
    } else {
      this.formGroupUpsert = new FormGroup({
        key: new FormControl(null, [Validators.required]),
        value: new FormControl(null),
      });
    }
  }

  onSubmit() {
    for (const i in this.formGroupUpsert.controls) {
      this.formGroupUpsert.controls[i].markAsDirty();
      this.formGroupUpsert.controls[i].updateValueAndValidity();
    }
    if (this.formGroupUpsert.invalid) {
      return;
    }
    const newBanner: Preference = new Preference();
    newBanner.key = this.formGroupUpsert.controls['key'].value;
    newBanner.value = this.formGroupUpsert.controls['value'].value;

    if (this.updateId) {
      this.preferenceService.update(this.updateId, newBanner).subscribe(value => {
        this.router.navigate(['/panel/preference']);
      });
    } else {
      this.preferenceService.create(newBanner).subscribe(value => {
        this.router.navigate(['/panel/preference']);
      });
    }
  }

}
