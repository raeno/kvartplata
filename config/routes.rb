Kvartplata::Application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions'}

  scope '(:locale)' do
    resources :metrics, :tariffs
    resources :settings, :only => [:index] do
      collection do
        post :save
        post :save_apartment
      end
    end
    resources :reports, :except => [:show]
    get '/reports/:year/:month', :controller => :reports, :action => :show, :as => 'report_year_month'
    authenticated :user do
      root :to => 'welcome#index'
    end
    root :to => 'welcome#index'
    match ':controller/:action'
  end
end
