import { TestBed } from '@angular/core/testing';

import { HighlightGraphqlService } from './highlight-graphql.service';

describe('HighlightGraphqlService', () => {
  let service: HighlightGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HighlightGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
