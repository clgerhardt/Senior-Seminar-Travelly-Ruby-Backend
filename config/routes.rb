Rails.application.routes.draw do
  resources :expense_coverages
  resources :expense_reports do
    collection do
      put 'final_approval'
    end
  end
  resources :expenses
  resources :documents
  resources :role
  resources :employees do
    collection do
      get 'travel_forms'
      get 'approvements_list'
    end
  end
  resources :department
  resources :budget_code
  resources :travel do
    collection do
      get 'expense_report'
    end
  end
  resources :approvement
  resources :comments
  post 'authenticate', to: 'authentication#authenticate'
end
