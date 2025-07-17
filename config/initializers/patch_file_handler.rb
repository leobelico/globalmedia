# config/initializers/patch_file_handler.rb
module ActionDispatch
  class FileHandler
    def match?(path)
      path.start_with?(@root)
    end
  end
end
