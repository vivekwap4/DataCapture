Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  #

  match "/", to: "homepage#index", via: :get, as: :homepage

  match "/researcher/signup", to: "researcher#signuppage", via: :get
  match "/researcher/signup", to: "researcher#createResearcher", via: :post

  match "/dataentry/signup", to: "dataentry#signuppage", via: :get
  match "/dataentry/signup/", to: "dataentry#createDataEntry", via: :post

  match "/login", to: "authentication#login", via: :post
  match "/login", to: "authentication#loginpage", via: :get
  match "/logout", to: "authentication#destroy", via: :get

  match "/researcher/researcher_landing_page", to: "researcher#researcher_landing_page", via: :get
  match "/dataentry/dataentry_landing_page", to: "formaccess#displaydataentryforms", via: :get

  match "/forgotpassword", to: "authentication#forgotpassword", via: :get
  match "/forgotpassword", to: "authentication#sendresetlink", via: :post
  match "/tutorial/tutorialpage", to: "tutorialpage#index", via: :get

  match "/resetpassword/:userid/:reset_token", to: "authentication#resetpassword", via: :get
  match "/resetpassword", to: "authentication#updatepassword", via: :post

  match "/profile", to: "authentication#profile", via: :get
  match "/profile", to: "authentication#updateprofile", via: :patch

  match "/researcherupdate", to: "researcher#update", via: :post
  match "/dataentryupdate", to: "dataentry#update", via: :post

  match "/researcher/generateform", to: "researcher#generateform", via: :get
  match "/researcher/createform", to: "researcher#createform", via: :post

  match "/researcher/grantaccess", to: "researcher#grantaccess", via: :get
  match "/form/getforms", to: "form#getforms", via: :post
  match "/formaccess/getformsuser", to: "formaccess#getformsuser", via: :post
  match "/dataentry/allusers", to: "dataentry#getallusers", via: :post

  match "/researcher/approvedata", to: "researcher#approvedata", via: :get
  match "/researcher/approvedata", to: "researcher#updateresults", via: :post
  match "/researcher/deletedata", to: "researcher#deletedata", via: :post
  match "/researcher/editdata", to: "researcher#editdata", via: :post

  match "/formaccess/updateaccess", to: "formaccess#updateformaccess", via: :post

  match "/dataentry/adddata/:formid", to: "dataentry#displayform", via: :get
  match "/dataentry/adddata/", to: "result#savestagingdata", via: :post

  match "/researcher/getdata", to: "result#getstagingdata", via: :post

  match "/dataentry/update", to: "dataentry#updatepage", via: :get
  match "/dataentry/getrecordstoupdate", to: "dataentry#getrecordstoupdate", via: :post

  match "/dataentry/getformtoedit", to: "dataentry#getformtoedit", via: :post

  match "/dataentry/updateformdata", to: "dataentry#updateformdata", via: :post

  match "/forms/:formid", to: "form#showform", via: :get
  match "/forms/export/:formid", to: "form#export", via: :get

  match "/researcher/archive", to: "researcher#archive", via: :get
  match "/archiveforms/:formid", to: "form#showarchiveform", via: :get

  match "/form/archiveform", to: "form#archiveform", via: :post

  match "/project/archiveproject", to: "projects#archiveproject", via: :post

  match "/forms/:formid/:pagination", to: "form#showformnext", via: :get

  match "/forms/search", to: "form#search", via: :post

  match "/form/categorical_variables", to: "form#categorical_variables", via: :post

  match "/form/categorical_charts", to: "form#categorical_charts", via: :get

  resources :researcher
  resources :projects
  resources :form

end
