import { TestBed } from '@angular/core/testing';

import { AuthorGraphqlService } from './author-graphql.service';

describe('AuthorGraphqlService', () => {
  let service: AuthorGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AuthorGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
