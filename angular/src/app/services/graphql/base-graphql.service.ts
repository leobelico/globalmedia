import {Injectable} from '@angular/core';
import {Apollo} from "apollo-angular";
import {AuthService} from "../auth.service";
import {Observable, throwError} from "rxjs";

@Injectable()
export class BaseGraphqlService {
  constructor(protected authService: AuthService, protected apollo: Apollo) {
  }

  protected handleError(error: any): Observable<never> {
    if (error.status === 401) {
    }
    throw throwError(error);
  }
}
