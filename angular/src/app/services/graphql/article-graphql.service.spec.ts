import { TestBed } from '@angular/core/testing';

import { ArticleGraphqlService } from './article-graphql.service';

describe('ArticleGraphqlService', () => {
  let service: ArticleGraphqlService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ArticleGraphqlService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
