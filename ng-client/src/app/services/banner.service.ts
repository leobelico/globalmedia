import { Injectable } from '@angular/core';
import {BaseEndpointService} from "./base-endpoint.service";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {NewBanner} from "../models/NewBanner";
import {catchError, map} from "rxjs/operators";
import * as moment from "moment";

@Injectable()
export class BannerService extends BaseEndpointService{


  constructor(httpClient: HttpClient) {
    super(httpClient);
  }
  getAllBanners(): Observable<NewBanner[]> {
    const url = `${this.apiUrl}/new_banner`;
    return this.httpClient.get<NewBanner[]>(url, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<NewBanner[], NewBanner[]>(value => {
        for (let i = 0; i < value.length; i++) {
          value[i].show_at = moment(value[i].show_at).toDate();
          value[i].expiry_at = moment(value[i].expiry_at).toDate();
          value[i].created_at = moment(value[i].created_at).toDate();
          value[i].updated_at = moment(value[i].updated_at).toDate();
        }
        return value;
      }));
  }
  getBannersForNow(): Observable<NewBanner[]> {
    const url = `${this.apiUrl}/new_banner/now`;
    return this.httpClient.get<NewBanner[]>(url, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<NewBanner[], NewBanner[]>(value => {
        for (let i = 0; i < value.length; i++) {
          value[i].show_at = moment(value[i].show_at).toDate();
          value[i].expiry_at = moment(value[i].expiry_at).toDate();
          value[i].created_at = moment(value[i].created_at).toDate();
          value[i].updated_at = moment(value[i].updated_at).toDate();
        }
      return value;
    }));
  }
  getBannerById(id: number): Observable<NewBanner|null> {
    const url = `${this.apiUrl}/new_banner/${id}`;
    return this.httpClient.get<NewBanner>(url, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<NewBanner, NewBanner>(value => {
        if (value) {
          value.show_at = moment(value.show_at).toDate();
          value.expiry_at = moment(value.expiry_at).toDate();
          value.created_at = moment(value.created_at).toDate();
          value.updated_at = moment(value.updated_at).toDate();
        }
      return value;
    }));
  }
  createBanner(newBanner: NewBanner): Observable<NewBanner> {
    const url = `${this.apiUrl}/new_banner`;
    return this.httpClient.post<NewBanner>(url, newBanner, this.getHeaders());
  }
  updateBanner(id: number, newBanner: NewBanner): Observable<NewBanner> {
    const url = `${this.apiUrl}/new_banner/${id}`;
    return this.httpClient.patch<NewBanner>(url, newBanner, this.getHeaders());
  }
  deleteBanner(id: number): Observable<void> {
    const url = `${this.apiUrl}/new_banner/${id}`;
    return this.httpClient.delete<void>(url, this.getHeaders());
  }
}
