import {ApplicationRef, Component, OnInit, ViewChild} from '@angular/core';
import {LocationGraphqlService} from "../../../services/graphql/location-graphql.service";
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {HighlightGraphqlService} from "../../../services/graphql/highlight-graphql.service";
import {HighlightType} from "../../../types/graphql/highlight-type";
import {ArticleType} from "../../../types/graphql/article-type";
import {NavigationService} from "../../../services/navigation.service";
import {NgbDate, NgbModal} from "@ng-bootstrap/ng-bootstrap";
import * as moment from "moment-timezone";
import {NgbTime} from "@ng-bootstrap/ng-bootstrap/timepicker/ngb-time";
import {UpsertHighlightInput} from "../../../types/graphql/inputs/upsert-highlight-input";
import {ConfigurationService} from "../../../services/configuration.service";
import {LocationType} from "../../../types/graphql/location-type";

@Component({
  selector: 'app-highlight',
  templateUrl: './highlight.component.html',
  styleUrls: ['./highlight.component.scss']
})
export class HighlightComponent implements OnInit {

  activeHighlights: HighlightType[] = [];
  inactiveHighlights: HighlightType[] = [];
  isLoadingActiveHighlights = false;
  isLoadingInactiveHighlights = false;

  formGroupUpsert: FormGroup | null = null;
  @ViewChild('upsertModal') upsertModal: ViewChild | null = null;
  location: LocationType | null = null;

  constructor(private locationGraphqlService: LocationGraphqlService,
              private highlightGraphqlService: HighlightGraphqlService,
              private navigationService: NavigationService,
              private configurationService: ConfigurationService,
              private ngbModal: NgbModal) {
  }

  ngOnInit(): void {
    this.configurationService.location.subscribe(location => {
      this.location = location;
      this.loadHighlightsByLocationId(Number(this.location.id));
    });
    this.formGroupUpsert = new FormGroup({
      id: new FormControl(null),
      order: new FormControl(0, [Validators.required, Validators.min(1), Validators.max(6)]),
      articleId: new FormControl(null, [Validators.required, Validators.min(1)]),
      published: new FormControl(false),
      scheduledDate: new FormControl(null, [Validators.required]),
      scheduledTime: new FormControl(null, [Validators.required]),
    });
  }

  loadHighlightsByLocationId(locationId: number): void {
    this.isLoadingActiveHighlights = true;
    this.isLoadingInactiveHighlights = true;
    this.highlightGraphqlService.currentPublishedByLocation(locationId).subscribe(highlights => {
      this.activeHighlights = highlights;
      this.isLoadingActiveHighlights = false;
    });
    this.highlightGraphqlService.currentUnpublishedByLocation(locationId).subscribe(highlights => {
      this.inactiveHighlights = highlights;
      this.isLoadingInactiveHighlights = false;
    });
  }

  openArticle(article: ArticleType) {
    this.navigationService.openTabArticleBySlug(article.slug ?? '');

  }

  openUpsertModal(param?: HighlightType): void {
    let now: moment.Moment = moment();
    let dateNow: NgbDate = new NgbDate(now.get('year'), now.get('month') + 1, now.get('date'));
    let timeNow = {
      hour: now.get('hour'),
      minute: now.get('minute'),
      second: now.get('second'),
    };
    if (this.formGroupUpsert) {
      if (param) {
        now = param.scheduledTime;
        dateNow = new NgbDate(now.get('year'), now.get('month') + 1, now.get('date'));
        timeNow = {
          hour: now.get('hour'),
          minute: now.get('minute'),
          second: now.get('second'),
        };
        this.formGroupUpsert.controls.id.setValue(param.id);
        this.formGroupUpsert.controls.order.setValue(param.order);
        this.formGroupUpsert.controls.articleId.setValue(param.articleId);
        this.formGroupUpsert.controls.published.setValue(param.published);
        this.formGroupUpsert.controls.scheduledDate.setValue(dateNow);
        this.formGroupUpsert.controls.scheduledTime.setValue(timeNow);
      } else {
        this.formGroupUpsert.controls.id.setValue(null);
        this.formGroupUpsert.controls.order.setValue(0);
        this.formGroupUpsert.controls.articleId.setValue(null);
        this.formGroupUpsert.controls.published.setValue(false);
        this.formGroupUpsert.controls.scheduledDate.setValue(dateNow);
        this.formGroupUpsert.controls.scheduledTime.setValue(timeNow);
      }
    }
    this.ngbModal.open(this.upsertModal).closed.subscribe(value => {
      this.saveUpsert();
    });
  }

  getMomentFromDateAndTime(date: NgbDate, time: NgbTime): moment.Moment {
    const now: moment.Moment = moment();
    now.set('year', date.year);
    now.set('month', date.month - 1);
    now.set('date', date.day);
    now.set('hour', time.hour);
    now.set('minute', time.minute);
    now.set('second', time.second);
    return now;
  }

  saveUpsert(): void {
    if (!this.formGroupUpsert || !this.location) {
      return;
    }
    if (this.formGroupUpsert.invalid) {
      return;
    }
    const id: number | null = this.formGroupUpsert.controls.id.value;
    const data: UpsertHighlightInput = {
      order: Number(this.formGroupUpsert.controls.order.value),
      articleId: Number(this.formGroupUpsert.controls.articleId.value),
      locationId: Number(this.location.id),
      published: this.formGroupUpsert.controls.published.value ?? false,
      scheduledTime: this.getMomentFromDateAndTime(this.formGroupUpsert.controls.scheduledDate.value, this.formGroupUpsert.controls.scheduledTime.value).toISOString()
    };
    if (id) {
      this.highlightGraphqlService.update(id, data).subscribe(highlight => {
        this.loadHighlightsByLocationId(Number(this.location?.id));
      });
    } else {
      this.highlightGraphqlService.create(data).subscribe(highlight => {
        this.loadHighlightsByLocationId(Number(this.location?.id));
      });
    }
  }

  delete(id: number) {
    if (confirm('Eliminar nota destacada?')) {
      this.highlightGraphqlService.delete(id).subscribe(highlight => {
        this.loadHighlightsByLocationId(Number(this.location?.id));
      })
    }
  }
}
