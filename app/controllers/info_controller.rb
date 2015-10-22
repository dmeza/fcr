class InfoController < ApplicationController
 	 
  layout "public"

  def index
  end

  def send_mail
    if params[:name].blank? || params[:email].blank? || params[:message].blank?
      flash[:notice] = "Por favor llene los campos: nombre, email, mensaje para contactarnos!"
      render :index
    else
      MessageMailer.info(params[:name], params[:email], params[:message]).deliver
      flash[:notice] = "Gracias por contactarnos"
      redirect_to info_path and return
    end
  end

  def historia
  end
end
