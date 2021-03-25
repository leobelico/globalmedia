import { TestBed } from '@angular/core/testing';

import { LocationGraphqlService } from './location-graphql.service';

describe('LocationGraphqlService', () => {
  let service: LocationGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LocationGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
