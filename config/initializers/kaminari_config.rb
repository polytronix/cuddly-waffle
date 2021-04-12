# frozen_string_literal: true
Kaminari.configure do |config|

	config.default_per_page = 25
  config.max_per_page = 50
  config.window = 5

  # config.total_pages = 50
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.params_on_first_page = false
end
