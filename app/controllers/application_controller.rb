class ApplicationController < ActionController::API
  require 'json_webtoken'
  include ActionController::Serialization
end
