class Hit < ApplicationRecord
	belongs_to :article, optional: true

	def self.search(initial_date, end_date, section_id)
      joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = '#{section_id}' AND hits.created_at >= '#{initial_date}' AND hits.created_at <= '#{end_date}'").order("hits.created_at ASC").group_by { |l| [l.created_at.beginning_of_week, l.created_at.month, l.created_at.year] }

      #.select(" DATE_TRUNC('month', hits.created_at) AS month").group('month')w

      #.group_by { |l| [l.hits.created_at.beginning_of_month, l.created_at.beginning_of_week] }

      #.group('hits.id').group('EXTRACT(MONTH FROM hits.created_at)')
  	end
  def self.search_by_author(initial_date, end_date, author_id)
      joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.author_id = '#{author_id}' AND hits.created_at >= '#{initial_date}' AND hits.created_at <= '#{end_date}'").order("hits.created_at ASC").group_by { |l| [l.created_at.beginning_of_week, l.created_at.month, l.created_at.year] }

      #.select(" DATE_TRUNC('month', hits.created_at) AS month").group('month')w

      #.group_by { |l| [l.hits.created_at.beginning_of_month, l.created_at.beginning_of_week] }

      #.group('hits.id').group('EXTRACT(MONTH FROM hits.created_at)')
    end
	def self.search_by_user(initial_date, end_date, user_id)
      joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.user_id = '#{user_id}' AND hits.created_at >= '#{initial_date}' AND hits.created_at <= '#{end_date}'").order("hits.created_at ASC").group_by { |l| [l.created_at.beginning_of_week, l.created_at.month, l.created_at.year] }

      #.select(" DATE_TRUNC('month', hits.created_at) AS month").group('month')w

      #.group_by { |l| [l.hits.created_at.beginning_of_month, l.created_at.beginning_of_week] }

      #.group('hits.id').group('EXTRACT(MONTH FROM hits.created_at)')
  	end
end
