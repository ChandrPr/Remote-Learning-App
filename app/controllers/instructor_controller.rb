class InstructorController < ApplicationController
  before_action :authenticate_instructor!

  def home
    @courses = Course.where( :instructor_id => current_instructor.id ).order({ :created_at => :desc })
    render({ :template => "home/instructor_home"})
  end

  def document_create
    the_document = Document.new
    the_document.course_id = params.fetch("query_course_id")
    the_document.name = params.fetch("query_name")
    the_document.doc_url = params.fetch("query_doc_url")
    the_document.doctype = params.fetch("query_doctype")
    the_document.uploadto_llm = params.fetch("query_uploadto_llm")

#    if the_document.valid?
      the_document.save
      redirect_to("/courses/#{the_document.course_id}", { :notice => "Document created successfully." })
#    else
#      redirect_to("/courses/#{the_document.course_id}", { :alert => the_document.errors.full_messages.to_sentence })
    end
  end

  def document_destroy
    the_document = Document.where({ :id => params["path_id"] }).first
    course_id = the_document.course_id
    the_document.destroy
    redirect_to("/courses/#{course_id}", { :notice => "Document deleted successfully."} )
  end

  def samplequestion_create
    the_sample_question = SampleQuestion.new
    the_sample_question.question_body = params.fetch("query_question_body")
    the_sample_question.course_id = params.fetch("query_course_id")

    if the_sample_question.valid?
      the_sample_question.save
      redirect_to("/courses/#{the_sample_question.course_id}", { :notice => "Sample question created successfully." })
    else
      redirect_to("/courses/#{the_sample_question.course_id}", { :alert => the_sample_question.errors.full_messages.to_sentence })
    end
  end

  def samplequestion_destroy
    the_sample_question = SampleQuestion.where({ :id => params["path_id"] }).first
    course_id = the_sample_question.course_id
    the_sample_question.destroy
    redirect_to("/courses/#{course_id}", { :notice => "Sample question deleted successfully."} )
  end

  def question_destroy
    the_question = Question.where({ :id => params["path_id"] }).first
    enrollment_id = the_question.enrollment_id
    the_question.destroy
    redirect_to("/enrollments/#{enrollment_id}", { :notice => "Question deleted successfully."} )
  end

end
