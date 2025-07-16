RedmineApp::Application.routes.draw do
  get 'smile_enumerations/project', to: 'smile_enumeration_api#project'
end