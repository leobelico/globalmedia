import {Component, OnInit, ViewChild} from '@angular/core';
import {NgbDate, NgbModal} from "@ng-bootstrap/ng-bootstrap";
import {Label} from "ng2-charts";
import {ChartDataSets, ChartType} from "chart.js";
import {ArticleGraphqlService} from "../../../services/graphql/article-graphql.service";
import * as moment from "moment-timezone";
import {ArticleType} from "../../../types/graphql/article-type";
import {RangeDates} from "../../../types/range-dates";
import {NavigationService} from "../../../services/navigation.service";

@Component({
  selector: 'app-analytics',
  templateUrl: './analytics.component.html',
  styleUrls: ['./analytics.component.scss']
})
export class AnalyticsComponent implements OnInit {

  barChartLabelsToday: Label[] = [];
  barChartLabelsWeek: Label[] = [];
  barChartLabelsMonth: Label[] = [];
  barChartDataToday: ChartDataSets[] = [
    {
      data: [],
      label: 'Articulos',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];
  barChartDataWeek: ChartDataSets[] = [
    {
      data: [],
      label: 'Articulos',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];
  barChartDataMonth: ChartDataSets[] = [
    {
      data: [],
      label: 'Articulos',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];

  mostViewedArticlesToday: ArticleType[] = [];
  mostViewedArticlesWeek: ArticleType[] = [];
  mostViewedArticlesMonth: ArticleType[] = [];

  mostViewedArticlesTodayLoading = true;
  mostViewedArticlesWeekLoading = true;
  mostViewedArticlesMonthLoading = true;

  exportRangeDates: RangeDates | null = null;
  @ViewChild('modalExport') modalExport: ViewChild | null = null;
  constructor(private articleGraphqlService: ArticleGraphqlService,
              private ngbModal: NgbModal,
              private navigationService: NavigationService) {
  }

  ngOnInit(): void {
    const momentToday: moment.Moment = moment();
    this.articleGraphqlService.mostViewedArticles(momentToday.startOf('day').toISOString(), momentToday.endOf('day').toISOString(), 30).subscribe(articles => {
      this.mostViewedArticlesTodayLoading = false;
      this.mostViewedArticlesToday = articles;
      this.barChartLabelsToday = this.getLabels(articles);
      this.barChartDataToday[0].data = this.getViews(articles);
    });
    this.articleGraphqlService.mostViewedArticles(momentToday.startOf('week').toISOString(), momentToday.endOf('week').toISOString()).subscribe(articles => {
      this.mostViewedArticlesWeekLoading = false;
      this.mostViewedArticlesWeek = articles;
      this.barChartLabelsWeek = this.getLabels(articles);
      this.barChartDataWeek[0].data = this.getViews(articles);
    });
    this.articleGraphqlService.mostViewedArticles(momentToday.startOf('month').toISOString(), momentToday.endOf('month').toISOString()).subscribe(articles => {
      this.mostViewedArticlesMonthLoading = false;
      this.mostViewedArticlesMonth = articles;
      this.barChartLabelsMonth = this.getLabels(articles);
      this.barChartDataMonth[0].data = this.getViews(articles);
    });
  }

  getLabels(articles: ArticleType[]): string[] {
    return articles.map(value => (value.name ? value.name.substr(0, 10) : '') + '...');
  }
  getViews(articles: ArticleType[]): number[] {
    return articles.map(value => value.totalViews);
  }
  openModalExportExcel(): void {
    this.ngbModal.open(this.modalExport).closed.subscribe(value => {
      if (this.exportRangeDates && this.exportRangeDates.to) {
        const from = this.exportRangeDates.from;
        const to = this.exportRangeDates.to;

        const fromMoment = moment().set({
          year: from.year,
          month: from.month - 1,
          date: from.day,
        }).startOf('day').format('YYYY-MM-DDTHH:mm:ss');
        const toMoment = moment().set({
          year: to.year,
          month: to.month - 1,
          date: to.day,
        }).endOf('day').format('YYYY-MM-DDTHH:mm:ss');
        this.navigationService.openTabAnalyticsExport(fromMoment, toMoment);
      }
    });
  }
  setExportRangeDates(value: RangeDates) {
    this.exportRangeDates = value;
  }
}
