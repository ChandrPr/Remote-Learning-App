Rails.application.routes.draw do

  root "public#login"

  devise_for :students
  get("/student_home", { :controller => "student", :action => "home" })
  # QUESTION
  get("/exam/:enrollment_id", { :controller => "student", :action => "exam" } )
  post("/create_question/:path_id", { :controller => "student", :action => "question_create" })
  post("/modify_question/:path_id", { :controller => "student", :action => "question_update" })
  get("/retake_exam/:enrollment_id", { :controller => "student", :action => "retake_exam" })

  devise_for :instructors
  get("/instructor_home", { :controller => "instructor", :action => "home" })
  # DOCUMENT
  post("/insert_document", { :controller => "instructor", :action => "document_create" })
  get("/delete_document/:path_id", { :controller => "instructor", :action => "document_destroy" })
  # SAMPLE QUESTION
  post("/insert_sample_question", { :controller => "instructor", :action => "samplequestion_create" })
  get("/delete_sample_question/:path_id", { :controller => "instructor", :action => "samplequestion_destroy" })
  # QUESTION
  get("/delete_question/:path_id", { :controller => "instructor", :action => "question_destroy" })
  #------------------------------

  # COURSE
  post("/insert_course", { :controller => "courses", :action => "create" })
  get("/courses", { :controller => "courses", :action => "index" })
  get("/courses/:path_id", { :controller => "courses", :action => "show" })
  post("/modify_course/:path_id", { :controller => "courses", :action => "update" })
  get("/delete_course/:path_id", { :controller => "courses", :action => "destroy" })
  #------------------------------

  # ENROLLMENT
  post("/insert_enrollment", { :controller => "enrollments", :action => "create" })
  get("/insert_enrollment/:query_course_id/:query_student_id", { :controller => "enrollments", :action => "create" })
  get("/enrollments/:path_id", { :controller => "enrollments", :action => "show" })
  post("/modify_enrollment/:path_id", { :controller => "enrollments", :action => "update" })
  get("/delete_enrollment/:path_id", { :controller => "enrollments", :action => "destroy" })
  #------------------------------

end
