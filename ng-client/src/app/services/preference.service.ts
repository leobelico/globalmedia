import { Injectable } from '@angular/core';
import {BaseEndpointService} from "./base-endpoint.service";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {catchError, map} from "rxjs/operators";
import * as moment from "moment";
import {Preference} from "../models/Preference";

@Injectable()
export class PreferenceService extends BaseEndpointService {

  constructor(httpClient: HttpClient) {
    super(httpClient);
  }

  all(): Observable<Preference[]> {
    const url = `${this.apiUrl}/preferences`;
    return this.httpClient.get<Preference[]>(url, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<Preference[], Preference[]>(value => {
        for (let i = 0; i < value.length; i++) {
          value[i].created_at = moment(value[i].created_at).toDate();
          value[i].updated_at = moment(value[i].updated_at).toDate();
        }
        return value;
      }));
  }
  find(id: number): Observable<Preference> {
    const url = `${this.apiUrl}/preference/${id}`;
    return this.httpClient.get<Preference>(url, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<Preference, Preference>(value => {
        if (value) {
          value.created_at = moment(value.created_at).toDate();
          value.updated_at = moment(value.updated_at).toDate();
        }
        return value;
      }));
  }
  create(request: Preference): Observable<Preference> {
    const url = `${this.apiUrl}/preference`;
    return this.httpClient.post<Preference>(url, request, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<Preference, Preference>(value => {
        if (value) {
          value.created_at = moment(value.created_at).toDate();
          value.updated_at = moment(value.updated_at).toDate();
        }
        return value;
      }));
  }
  update(id: number, request: Preference): Observable<Preference> {
    const url = `${this.apiUrl}/preference/${id}`;
    return this.httpClient.post<Preference>(url, request, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<Preference, Preference>(value => {
        if (value) {
          value.created_at = moment(value.created_at).toDate();
          value.updated_at = moment(value.updated_at).toDate();
        }
        return value;
      }));
  }
  delete(id: number): Observable<Preference> {
    const url = `${this.apiUrl}/preference/${id}`;
    return this.httpClient.delete<Preference>(url, this.getHeaders()).pipe(
      catchError(err => this.handleError(err)),
      map<Preference, Preference>(value => {
        if (value) {
          value.created_at = moment(value.created_at).toDate();
          value.updated_at = moment(value.updated_at).toDate();
        }
        return value;
      }));
  }
}
