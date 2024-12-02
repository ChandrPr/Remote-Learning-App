Rails.application.routes.draw do
  # Routes for the Question resource:

  root "topics#index"

  # CREATE
  post("/insert_question", { :controller => "questions", :action => "create" })
          
  # READ
  get("/questions", { :controller => "questions", :action => "index" })
  
  get("/questions/:path_id", { :controller => "questions", :action => "show" })
  
  # UPDATE
  
  post("/modify_question/:path_id", { :controller => "questions", :action => "update" })
  
  # DELETE
  get("/delete_question/:path_id", { :controller => "questions", :action => "destroy" })

  #------------------------------

  # Routes for the Sample question resource:

  # CREATE
  post("/insert_sample_question", { :controller => "sample_questions", :action => "create" })
          
  # READ
  get("/sample_questions", { :controller => "sample_questions", :action => "index" })
  
  get("/sample_questions/:path_id", { :controller => "sample_questions", :action => "show" })
  
  # UPDATE
  
  post("/modify_sample_question/:path_id", { :controller => "sample_questions", :action => "update" })
  
  # DELETE
  get("/delete_sample_question/:path_id", { :controller => "sample_questions", :action => "destroy" })

  #------------------------------

  # Routes for the Document resource:

  # CREATE
  post("/insert_document", { :controller => "documents", :action => "create" })
          
  # READ
  get("/documents", { :controller => "documents", :action => "index" })
  
  get("/documents/:path_id", { :controller => "documents", :action => "show" })
  
  # UPDATE
  
  post("/modify_document/:path_id", { :controller => "documents", :action => "update" })
  
  # DELETE
  get("/delete_document/:path_id", { :controller => "documents", :action => "destroy" })

  #------------------------------

  devise_for :instructors
  # Routes for the Enrollment resource:

  # CREATE
  post("/insert_enrollment", { :controller => "enrollments", :action => "create" })
          
  # READ
  get("/enrollments", { :controller => "enrollments", :action => "index" })
  
  get("/enrollments/:path_id", { :controller => "enrollments", :action => "show" })
  
  # UPDATE
  
  post("/modify_enrollment/:path_id", { :controller => "enrollments", :action => "update" })
  
  # DELETE
  get("/delete_enrollment/:path_id", { :controller => "enrollments", :action => "destroy" })

  #------------------------------

  # Routes for the Topic resource:

  # CREATE
  post("/insert_topic", { :controller => "topics", :action => "create" })
          
  # READ
  get("/topics", { :controller => "topics", :action => "index" })
  
  get("/topics/:path_id", { :controller => "topics", :action => "show" })
  
  # UPDATE
  
  post("/modify_topic/:path_id", { :controller => "topics", :action => "update" })
  
  # DELETE
  get("/delete_topic/:path_id", { :controller => "topics", :action => "destroy" })

  #------------------------------

  devise_for :students

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
