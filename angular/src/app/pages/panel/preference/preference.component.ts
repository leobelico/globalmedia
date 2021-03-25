import {Component, OnInit, ViewChild} from '@angular/core';
import {PreferenceGraphqlService} from "../../../services/graphql/preference-graphql.service";
import {PreferenceType} from "../../../types/graphql/preference-type";
import {NgbModal} from "@ng-bootstrap/ng-bootstrap";
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {UpsertPreferenceInput} from "../../../types/graphql/inputs/upsert-preference-input";

@Component({
  selector: 'app-preference',
  templateUrl: './preference.component.html',
  styleUrls: ['./preference.component.scss']
})
export class PreferenceComponent implements OnInit {

  preferences: PreferenceType[] = []
  formGroupUpsert: FormGroup | null = null;
  isLoadingData = true;
  @ViewChild('upsertModal') upsertModal: ViewChild | null = null;

  constructor(private preferenceGraphqlService: PreferenceGraphqlService,
              private ngbModal: NgbModal) {
  }

  ngOnInit(): void {
    this.formGroupUpsert = new FormGroup({
      id: new FormControl(null),
      key: new FormControl(null, [Validators.required]),
      value: new FormControl(null),
    });
    this.loadData();
  }

  loadData(): void {
    this.isLoadingData = true;
    this.preferenceGraphqlService.all().subscribe(preferences => {
      this.isLoadingData = false;
      this.preferences = preferences;
    })
  }

  delete(id: number) {
    if (confirm('Eliminar preferencia?')) {
      this.preferenceGraphqlService.delete(id).subscribe(preference => {
        this.loadData();
      })
    }
  }

  openUpsertModal(param?: PreferenceType): void {
    if (this.formGroupUpsert) {
      if (param) {
        this.formGroupUpsert.controls.id.setValue(param.id);
        this.formGroupUpsert.controls.key.setValue(param.key);
        this.formGroupUpsert.controls.value.setValue(param.value);
      } else {
        this.formGroupUpsert.controls.id.setValue(null);
        this.formGroupUpsert.controls.key.setValue('');
        this.formGroupUpsert.controls.value.setValue('');
      }
    }
    this.ngbModal.open(this.upsertModal).closed.subscribe(value => {
      this.saveUpsert();
    });
  }

  saveUpsert(): void {
    if (!this.formGroupUpsert) {
      return;
    }
    if (this.formGroupUpsert.invalid) {
      return;
    }
    const id: number | null = this.formGroupUpsert.controls.id.value;
    const data: UpsertPreferenceInput = {
      key: this.formGroupUpsert.controls.key.value,
      value: this.formGroupUpsert.controls.value.value,
    };
    if (id) {
      this.preferenceGraphqlService.update(id, data).subscribe(preference => {
        this.loadData();
      });
    } else {
      this.preferenceGraphqlService.create(data).subscribe(preference => {
        this.loadData();
      });
    }
  }
}
