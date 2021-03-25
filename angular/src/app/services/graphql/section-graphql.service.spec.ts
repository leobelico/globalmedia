import { TestBed } from '@angular/core/testing';

import { SectionGraphqlService } from './section-graphql.service';

describe('SectionGraphqlService', () => {
  let service: SectionGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SectionGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
