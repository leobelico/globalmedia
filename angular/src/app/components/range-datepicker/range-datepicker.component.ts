import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {NgbCalendar, NgbDate} from "@ng-bootstrap/ng-bootstrap";
import {RangeDates} from "../../types/range-dates";

@Component({
  selector: 'app-range-datepicker',
  templateUrl: './range-datepicker.component.html',
  styleUrls: ['./range-datepicker.component.scss']
})
export class RangeDatepickerComponent implements OnInit {

  hoveredDate: NgbDate | null = null;

  fromDate: NgbDate;
  toDate: NgbDate | null = null;

  @Input() twice = false;

  @Output() onRangeChanged: EventEmitter<RangeDates> = new EventEmitter<RangeDates>();

  constructor(calendar: NgbCalendar) {
    this.fromDate = calendar.getToday();
    this.toDate = calendar.getNext(calendar.getToday(), 'd', 1);
  }

  ngOnInit(): void {
    this.onRangeChanged.emit({from: this.fromDate, to: this.toDate});
  }

  onDateSelection(date: NgbDate): void {
    if (!this.fromDate && !this.toDate) {
      this.fromDate = date;
    } else if (this.fromDate && !this.toDate && date.after(this.fromDate)) {
      this.toDate = date;
    } else {
      this.toDate = null;
      this.fromDate = date;
    }
    this.onRangeChanged.emit({from: this.fromDate, to: this.toDate});
  }

  isHovered(date: NgbDate) {
    return this.fromDate && !this.toDate && this.hoveredDate && date.after(this.fromDate) && date.before(this.hoveredDate);
  }

  isInside(date: NgbDate) {
    return this.toDate && date.after(this.fromDate) && date.before(this.toDate);
  }

  isRange(date: NgbDate) {
    return date.equals(this.fromDate) || (this.toDate && date.equals(this.toDate)) || this.isInside(date) || this.isHovered(date);
  }

}
