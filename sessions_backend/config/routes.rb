Rails.application.routes.draw do

  namespace :api do
    controller "session" do
      get "sessions", action: :get_sessions, as: :get_sessions
      get "clients", action: :get_clients, as: :get_clients
      get "coaches", action: :get_coaches, as: :get_coaches
      post "create", action: :create_session, as: :create_session
    end
  end
end
