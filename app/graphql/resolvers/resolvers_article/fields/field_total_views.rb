module Resolvers
  module ResolversArticle
    module Fields
      class FieldTotalViews < Resolvers::Base
        type Integer, null: false

        def resolve
          Hit.where('article_id = ?', object.id).sum(:number)
        end
      end
    end
  end
end