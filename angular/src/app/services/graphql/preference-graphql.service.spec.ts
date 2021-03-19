import { TestBed } from '@angular/core/testing';

import { PreferenceGraphqlService } from './preference-graphql.service';

describe('PreferenceGraphqlService', () => {
  let service: PreferenceGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PreferenceGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
