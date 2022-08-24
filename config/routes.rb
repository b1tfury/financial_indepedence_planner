Rails.application.routes.draw do
  get "/income_tax", to: "income#show"
end
