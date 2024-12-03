Rails.application.routes.draw do

  root "topics#index"
  devise_for :students
  devise_for :instructors

  # TOPIC
  post("/insert_topic", { :controller => "topics", :action => "create" })
  get("/topics", { :controller => "topics", :action => "index" })
  get("/topics/:path_id", { :controller => "topics", :action => "show" })
  post("/modify_topic/:path_id", { :controller => "topics", :action => "update" })
  get("/delete_topic/:path_id", { :controller => "topics", :action => "destroy" })
  #------------------------------

  # ENROLLMENT
  post("/insert_enrollment", { :controller => "enrollments", :action => "create" })
  get("/enrollments", { :controller => "enrollments", :action => "index" })
  get("/enrollments/:path_id", { :controller => "enrollments", :action => "show" })
  post("/modify_enrollment/:path_id", { :controller => "enrollments", :action => "update" })
  get("/delete_enrollment/:path_id", { :controller => "enrollments", :action => "destroy" })
  #------------------------------

  # QUESTION
  post("/insert_question", { :controller => "questions", :action => "create" })
  get("/questions", { :controller => "questions", :action => "index" })  
  get("/questions/:path_id", { :controller => "questions", :action => "show" })
  post("/modify_question/:path_id", { :controller => "questions", :action => "update" })
  get("/delete_question/:path_id", { :controller => "questions", :action => "destroy" })
  #------------------------------

  # SAMPLE QUESTION
  post("/insert_sample_question", { :controller => "sample_questions", :action => "create" })
  get("/sample_questions", { :controller => "sample_questions", :action => "index" })
  get("/sample_questions/:path_id", { :controller => "sample_questions", :action => "show" })
  post("/modify_sample_question/:path_id", { :controller => "sample_questions", :action => "update" })
  get("/delete_sample_question/:path_id", { :controller => "sample_questions", :action => "destroy" })
  #------------------------------

  # DOCUMENT
  post("/insert_document", { :controller => "documents", :action => "create" })
  get("/documents", { :controller => "documents", :action => "index" })
  get("/documents/:path_id", { :controller => "documents", :action => "show" })
  post("/modify_document/:path_id", { :controller => "documents", :action => "update" })
  get("/delete_document/:path_id", { :controller => "documents", :action => "destroy" })
  #------------------------------

end
