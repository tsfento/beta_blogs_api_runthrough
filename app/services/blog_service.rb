# frozen_string_literal: true

# Blog service
module BlogService
  module Base
    def self.filter(params)
      page = params.fetch(:page, 1).to_i
      per_page = params.fetch(:per_page, 10).to_i

      begin
        offset = (page - 1) * per_page

        blogs = Blog.offset(offset).limit(per_page)

        # return ServiceContract.error('No Blogs found!') if blogs.empty?
      rescue ActiveRecord::RecordInvalid => e
        return ServiceContract.error(e.record.errors.full_messages) unless e.record.valid?
      end

      ServiceContract.success(blogs)
    end
  end
end
