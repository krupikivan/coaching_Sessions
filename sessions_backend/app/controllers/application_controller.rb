class ApplicationController < ActionController::API
    # skip_forgery_protection

    include ResponseHelper
    include ExceptionHelper

end
