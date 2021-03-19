import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {LocalStorageService} from './local-storage.service';

@Injectable()
export class AuthService {
  private _token: string | null = null;
  private _clientSession: string | null = null;

  constructor(
    private httpClient: HttpClient,
    private localStorageService: LocalStorageService) {
  }

  public get token(): string | null {
    return this._token;
  }

  public get clientSession(): string | null {
    return this._clientSession;
  }
}
