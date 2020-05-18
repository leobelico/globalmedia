import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {environment} from "../../environments/environment";

@Injectable()
export class BaseEndpointService {

  protected apiUrl: string = environment.apiUrl;
  protected baseUrl: string = environment.baseUrl;
  private _bearerToken: string = null;

  constructor(protected httpClient: HttpClient) {
  }


  protected handleError(error): any {
    // if (error.status == 401) {
    //   this.authService.unauthorizedUser();
    // }
    // if (error.status === 403) {
    //   this.authService.unauthorizedActionError();
    // }
    throw error;
  }

  public getHeaders(): { headers: HttpHeaders | { [header: string]: string | string[]; } } {
    const headers = new HttpHeaders({
      Authorization: (this._bearerToken ? (`Bearer ${this._bearerToken}`) : ''),
      'Content-Type': 'application/json',
      Accept: 'application/json, text/plain, */*'
    });
    return {headers};
  }

}
