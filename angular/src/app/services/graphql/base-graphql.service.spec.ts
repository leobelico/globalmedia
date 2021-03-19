import { TestBed } from '@angular/core/testing';

import { BaseGraphqlService } from './base-graphql.service';

describe('BaseGraphqlService', () => {
  let service: BaseGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(BaseGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
