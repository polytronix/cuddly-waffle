class AdminController < ApplicationController
  before_action :check_admin

  layout 'admin'
end
