class Api::V1::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # version 1 specific helpers, actions, etc. go in here
end
