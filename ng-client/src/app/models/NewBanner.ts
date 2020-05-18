export class NewBanner {
  id: number;
  name: string;
  description: string;
  banner_type: string;
  content: string;
  is_active: boolean;
  show_at: Date | string;
  expiry_at: Date | string;
  created_at: Date | string;
  updated_at: Date | string;
}
