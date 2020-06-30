class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :update, :destroy]

  # GET /documents
  def index
    respond_with Document.all
  end

  # GET /documents/1
  def show
    respond_with Document.find(params[:id])
  end

  # POST /documents
  def create
    image_url = params["image_url"]
    expense_report_id = params["expense_report_id"]
    document_params ={image_url: image_url,
                      expense_report_id: expense_report_id}
    respond_with Document.create(document_params)
  end

  # PATCH/PUT /documents/1
  def update
    document = Document.find(params["id"])
    document.update_attributes(document_params)
    respond_with document, json: document
  end

  # DELETE /documents/1
  def destroy
    @document.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def document_params
      params.require(:document).permit(:image_url, :expense_report_id)
    end
end
