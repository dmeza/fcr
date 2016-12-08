# encoding: UTF-8
class Admin::PollsController < Admin::AdminController

  before_filter :set_menu



  def index
    @polls = Poll.paginate(page: params[:page], per_page: 50).order('created_at desc')


    xlsx = Roo::Spreadsheet.open('/home/developer/Projects/fcr/doc/FormatoDemo.xlsx')
    # xlsx = Roo::Excelx.new("/home/developer/Projects/fcr/doc/FormatoDemo.xlsx")

    # Get Hospitals
    @pollInformation = []
    xlsx.each(hospital: 'HOSPITAL', name: 'NOMBRE COMPLETO', birthday: 'FECHA DE NACIMIENTO', address: 'DIRECCION DOMICILIO', city: 'CIUDAD O PROV.', relative: 'NOMBRE MAMÁ O TUTOR', phone: 'TELEFONO FIJO', cellphone: 'CELULAR', diagnostic: 'DIAGNOSTICO', dream: 'SUEÑO DEL NIÑ@', child_status: 'ESTADO') do |row|
      next if row[:hospital] == 'HOSPITAL' 
      @pollInformation << row 
    end

    @pollInformation.each do |info|

      
      # Crear una ciudad a partir de datos en el excel puede implicar
      #   un error a nuestro criterio si el valor del nombre de la ciudad
      #   no existe. Toca revisar este punto.

      city = City.find_or_create_by!(name: info[:city])
      hospital =  Hospital.find_or_create_by!(name: info[:hospital], city_id: city.id)
      diagnostic = Diagnostic.find_or_create_by!(name: info[:diagnostic])
      status =  ChildStatus.find_or_create_by!(name: info[:child_status])

      # Crear el diagnostico puede incurrir en una condicion similar a la de crear la ciudad.
      # # child = Child.where(name: info[:name], birth_date: info[:birthday], address: info[:address], city: city, diagnostic: diagnostic)
      child = Child.find_or_create_by!(hospital: hospital, name: info[:name], birth_date: info[:birthday], genere: '', address: info[:address], city: city, dream: info[:dream] , diagnostic: diagnostic, child_status: status )


      # puts city.id.inspect
      # Crear el nino puede incurrir en una condicion similar a la de crear la ciudad.
    
      
      
      

    end


    
  end

  def poll_filter
    @polls = Poll.order('created_at desc')
    if(params[:code].present? )
      @polls = @polls.where('code = ?', params[:code])
    end
    if(params[:date].present? )
      @polls = @polls.where(poll_date: DateTime.strptime(params[:date], '%d/%m/%Y'))
    end
    @polls = @polls.paginate(page: params[:page], per_page: 50)
    respond_to do |format|
      format.html {}
      format.js { render :index }
    end
  end

  def to_xlsx
    @polls = Poll.all
    headers['Content-Disposition'] = "attachment; filename=Polls_#{Date.today.strftime('%Y/%m/%d')}.xlsx"
  end


  def from_xlsx
    
  end




  private
  
  def set_menu
    @selected_menu = 'Poll'
  end

end
