import {Component, OnInit, ViewChild} from '@angular/core';
import {NgbModal} from "@ng-bootstrap/ng-bootstrap";
import {Label} from "ng2-charts";
import {ChartDataSets, ChartOptions} from "chart.js";
import {ArticleGraphqlService} from "../../../services/graphql/article-graphql.service";
import * as moment from "moment-timezone";
import {ArticleType} from "../../../types/graphql/article-type";
import {RangeDates} from "../../../types/range-dates";
import {NavigationService} from "../../../services/navigation.service";
import {AuthorGraphqlService} from "../../../services/graphql/author-graphql.service";
import {AuthorType} from "../../../types/graphql/author-type";
import {FormControl} from "@angular/forms";
import {SectionGraphqlService} from "../../../services/graphql/section-graphql.service";
import {SectionType} from "../../../types/graphql/section-type";

@Component({
  selector: 'app-analytics',
  templateUrl: './analytics.component.html',
  styleUrls: ['./analytics.component.scss']
})
export class AnalyticsComponent implements OnInit {

  optionsArticlesChart: ChartOptions = {
    scales: {
      xAxes: [{
        ticks: {
          callback: function (value: string) {
            return value.substr(0, 10);//truncate
          },
        }
      }],
      yAxes: [{}]
    }
  };
  optionsAuthorsChart: ChartOptions = {
    scales: {
      xAxes: [{
        ticks: {
          callback: function (value: string) {
            return value.substr(0, 10);//truncate
          },
        }
      }],
      yAxes: [{}]
    }
  };

  barChartArticlesLabelsToday: Label[] = [];
  barChartArticlesLabelsWeek: Label[] = [];
  barChartArticlesLabelsMonth: Label[] = [];

  barChartAuthorsLabelsToday: Label[] = [];
  barChartAuthorsLabelsWeek: Label[] = [];
  barChartAuthorsLabelsMonth: Label[] = [];

  barChartArticlesDataToday: ChartDataSets[] = [
    {
      data: [],
      label: 'Vistas',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];
  barChartArticlesDataWeek: ChartDataSets[] = [
    {
      data: [],
      label: 'Vistas',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];
  barChartArticlesDataMonth: ChartDataSets[] = [
    {
      data: [],
      label: 'Vistas',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];

  barChartAuthorsDataToday: ChartDataSets[] = [
    {
      data: [],
      label: 'Vistas',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];
  barChartAuthorsDataWeek: ChartDataSets[] = [
    {
      data: [],
      label: 'Vistas',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];
  barChartAuthorsDataMonth: ChartDataSets[] = [
    {
      data: [],
      label: 'Vistas',
      backgroundColor: 'rgb(24,108,172,0.7)',
      borderColor: 'rgb(24,108,172)',
      hoverBackgroundColor: 'rgb(1,55,131, 0.7)',
      hoverBorderColor: 'rgb(1,55,131)',
    }
  ];

  mostViewedArticlesToday: ArticleType[] = [];
  mostViewedArticlesWeek: ArticleType[] = [];
  mostViewedArticlesMonth: ArticleType[] = [];

  mostViewedAuthorsToday: AuthorType[] = [];
  mostViewedAuthorsWeek: AuthorType[] = [];
  mostViewedAuthorsMonth: AuthorType[] = [];

  mostViewedArticlesTodayLoading = true;
  mostViewedArticlesWeekLoading = true;
  mostViewedArticlesMonthLoading = true;

  mostViewedAuthorsTodayLoading = true;
  mostViewedAuthorsWeekLoading = true;
  mostViewedAuthorsMonthLoading = true;

  exportRangeDates: RangeDates | null = null;
  formControlSection: FormControl | null = null;
  sections: SectionType[] = [];
  @ViewChild('modalExport') modalExport: ViewChild | null = null;

  constructor(private articleGraphqlService: ArticleGraphqlService,
              private authorGraphqlService: AuthorGraphqlService,
              private sectionGraphqlService: SectionGraphqlService,
              private ngbModal: NgbModal,
              private navigationService: NavigationService) {
  }

  ngOnInit(): void {
    this.formControlSection = new FormControl(0);
    this.loadSections();
    this.loadDataArticles();
    this.loadDataAuthors();
    if (this.formControlSection) {
      this.formControlSection.valueChanges.subscribe(sectionId => {
        const sectionIdNumber = Number(sectionId)
        if (sectionIdNumber > 0) {
          this.loadArticlesBySection(sectionIdNumber);
        } else {
          this.loadDataArticles();
        }
      });
    }
  }

  loadSections(): void {
    this.sectionGraphqlService.all().subscribe(sections => {
      this.sections = sections;
    });
  }

  loadArticlesBySection(sectionId: number): void {
    this.mostViewedArticlesTodayLoading = true;
    this.mostViewedArticlesWeekLoading = true;
    this.mostViewedArticlesMonthLoading = true;
    this.articleGraphqlService.mostViewedArticlesBySection(sectionId, moment().startOf('day').toISOString(), moment().endOf('day').toISOString(), 30).subscribe(articles => {
      this.mostViewedArticlesTodayLoading = false;
      this.mostViewedArticlesToday = articles;
      this.barChartArticlesLabelsToday = this.getLabelsArticles(articles);
      this.barChartArticlesDataToday[0].data = this.getViewsArticles(articles);
    });
    this.articleGraphqlService.mostViewedArticlesBySection(sectionId, moment().startOf('week').toISOString(), moment().endOf('week').toISOString()).subscribe(articles => {
      this.mostViewedArticlesWeekLoading = false;
      this.mostViewedArticlesWeek = articles;
      this.barChartArticlesLabelsWeek = this.getLabelsArticles(articles);
      this.barChartArticlesDataWeek[0].data = this.getViewsArticles(articles);
    });
    this.articleGraphqlService.mostViewedArticlesBySection(sectionId, moment().startOf('month').toISOString(), moment().endOf('month').toISOString()).subscribe(articles => {
      this.mostViewedArticlesMonthLoading = false;
      this.mostViewedArticlesMonth = articles;
      this.barChartArticlesLabelsMonth = this.getLabelsArticles(articles);
      this.barChartArticlesDataMonth[0].data = this.getViewsArticles(articles);
    });
  }
  loadDataArticles(): void {
    this.mostViewedArticlesTodayLoading = true;
    this.mostViewedArticlesWeekLoading = true;
    this.mostViewedArticlesMonthLoading = true;
    this.articleGraphqlService.mostViewedArticles(moment().startOf('day').toISOString(), moment().endOf('day').toISOString(), 30).subscribe(articles => {
      this.mostViewedArticlesTodayLoading = false;
      this.mostViewedArticlesToday = articles;
      this.barChartArticlesLabelsToday = this.getLabelsArticles(articles);
      this.barChartArticlesDataToday[0].data = this.getViewsArticles(articles);
    });
    this.articleGraphqlService.mostViewedArticles(moment().startOf('week').toISOString(), moment().endOf('week').toISOString()).subscribe(articles => {
      this.mostViewedArticlesWeekLoading = false;
      this.mostViewedArticlesWeek = articles;
      this.barChartArticlesLabelsWeek = this.getLabelsArticles(articles);
      this.barChartArticlesDataWeek[0].data = this.getViewsArticles(articles);
    });
    this.articleGraphqlService.mostViewedArticles(moment().startOf('month').toISOString(), moment().endOf('month').toISOString()).subscribe(articles => {
      this.mostViewedArticlesMonthLoading = false;
      this.mostViewedArticlesMonth = articles;
      this.barChartArticlesLabelsMonth = this.getLabelsArticles(articles);
      this.barChartArticlesDataMonth[0].data = this.getViewsArticles(articles);
    });
  }

  loadDataAuthors(): void {
    this.mostViewedAuthorsTodayLoading = true;
    this.mostViewedAuthorsWeekLoading = true;
    this.mostViewedAuthorsMonthLoading = true;
    this.authorGraphqlService.mostViewedAuthors(moment().startOf('day').toISOString(), moment().endOf('day').toISOString(), 30).subscribe(authors => {
      this.mostViewedAuthorsTodayLoading = false;
      this.mostViewedAuthorsToday = authors;
      this.barChartAuthorsLabelsToday = this.getLabelsAuthors(authors);
      this.barChartAuthorsDataToday[0].data = this.getViewsAuthors(authors);
    });
    this.authorGraphqlService.mostViewedAuthors(moment().startOf('week').toISOString(), moment().endOf('week').toISOString()).subscribe(authors => {
      this.mostViewedAuthorsWeekLoading = false;
      this.mostViewedAuthorsWeek = authors;
      this.barChartAuthorsLabelsWeek = this.getLabelsAuthors(authors);
      this.barChartAuthorsDataWeek[0].data = this.getViewsAuthors(authors);
    });
    this.authorGraphqlService.mostViewedAuthors(moment().startOf('month').toISOString(), moment().endOf('month').toISOString()).subscribe(authors => {
      this.mostViewedAuthorsMonthLoading = false;
      this.mostViewedAuthorsMonth = authors;
      this.barChartAuthorsLabelsMonth = this.getLabelsAuthors(authors);
      this.barChartAuthorsDataMonth[0].data = this.getViewsAuthors(authors);
    });
  }

  getLabelsArticles(articles: ArticleType[]): string[] {
    return articles.map(value => value.name ?? '');
  }

  getLabelsAuthors(articles: AuthorType[]): string[] {
    return articles.map(value => value.name ?? '');
  }

  getViewsArticles(articles: ArticleType[]): number[] {
    return articles.map(value => value.analytics ? value.analytics.totalViews : 0);
  }

  getViewsAuthors(articles: AuthorType[]): number[] {
    return articles.map(value => value.analytics ? value.analytics.totalViews : 0);
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
