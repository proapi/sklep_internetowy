#encoding: utf-8

class Admin::ReportsController < ApplicationController

  layout "admin"

  before_filter :require_user

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])
    if @report.valid?
      respond_to do |format|
        format.html do
          @report.to_html
          render "show"
        end
        format.pdf do
          file = @report.to_pdf
          send_file file, :filename => "#{l Date.current, format: :report}_raport.pdf", :type => "application/pdf"
        end
      end
    else
      render "new"
    end
  end
end