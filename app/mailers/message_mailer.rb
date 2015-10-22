class MessageMailer < ActionMailer::Base
  default from: "admin@ayudandonos.com"

  def joined(event, user)
    @event = event
    @user = user
    mail(to: user.email, subject: "Participacion en el evento #{@event.name}")
  end

  def new_register(event, user)
    @event = event
    @user = user
    mail(to: event.responsable_email, subject: "Un nuevo participante al evento #{@event.name}")
  end

  def info(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: "david@alturasoluciones.com, rebecab@fcr.org.ec, comunicacion@fcr.org.ec", subject: "Solicitud de informacion")
  end
  
end
