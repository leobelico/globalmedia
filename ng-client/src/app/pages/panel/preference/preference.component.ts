import { Component, OnInit } from '@angular/core';
import {Preference} from "../../../models/Preference";
import {PreferenceService} from "../../../services/preference.service";

@Component({
  selector: 'app-preference',
  templateUrl: './preference.component.html',
  styleUrls: ['./preference.component.scss']
})
export class PreferenceComponent implements OnInit {

  preferences: Preference[] = []
  constructor(private preferenceService: PreferenceService) { }

  ngOnInit(): void {
    this.preferenceService.all().subscribe(value => {
      this.preferences = value;
    })
  }
  delete(id: number) {
    if (confirm('Eliminar preferencia?')) {
      this.preferenceService.delete(id).subscribe(() => {
        this.preferenceService.all().subscribe(value => {
          this.preferences = value;
        });
      })
    }
  }
}
