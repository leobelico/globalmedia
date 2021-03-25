export interface UpsertHighlightInput {
  order: number;
  articleId: number;
  locationId: number,
  scheduledTime: string;
  published?: boolean;
}
