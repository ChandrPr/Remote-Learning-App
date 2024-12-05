class DocumentsController < ApplicationController
  def index
    @list_of_documents = Document.all.order({ :created_at => :desc })
    render({ :template => "documents/index" })
  end

  def show
    @the_document = Document.where({ :id => params["path_id"] }).first
    render({ :template => "documents/show" })
  end

  def create
    the_document = Document.new
    the_document.course_id = params.fetch("query_course_id")
    the_document.name = params.fetch("query_name")
    the_document.doc_url = params.fetch("query_doc_url")
    the_document.doctype = params.fetch("query_doctype")
    the_document.uploadto_llm = params.fetch("query_uploadto_llm")

    if the_document.valid?
      the_document.save
      redirect_to("/courses/#{the_document.course_id}", { :notice => "Document created successfully." })
    else
      redirect_to("/courses/#{the_document.course_id}", { :alert => the_document.errors.full_messages.to_sentence })
    end
  end

  def update
    the_document = Document.where({ :id => params["path_id"] }).first
    the_document.course_id = params.fetch("query_course_id")
    the_document.name = params.fetch("query_name")
    the_document.doc_url = params.fetch("query_doc_url")
    the_document.doctype = params.fetch("query_doctype")
    the_document.uploadto_llm = params.fetch("query_uploadto_llm")

    if the_document.valid?
      the_document.save
      redirect_to("/documents/#{the_document.id}", { :notice => "Document updated successfully."} )
    else
      redirect_to("/documents/#{the_document.id}", { :alert => the_document.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_document = Document.where({ :id => params["path_id"] }).first
    course_id = the_document.course_id
    the_document.destroy
    redirect_to("/courses/#{course_id}", { :notice => "Document deleted successfully."} )
  end
end
