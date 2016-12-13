class Poll < ActiveRecord::Base

    require 'roo'


    belongs_to :participant, polymorphic: true

    def self.save_file(doc)

    	xlsx = Roo::Spreadsheet.open(doc , extension: :xlsx)

    	pollInformation = []
    	errors = []

	    xlsx.each(hospital: 'HOSPITAL', name: 'NOMBRE COMPLETO', birthday: 'FECHA DE NACIMIENTO', address: 'DIRECCION DOMICILIO', city: 'CIUDAD O PROV.', relative: 'NOMBRE MAMÁ O TUTOR', phone: 'TELEFONO FIJO', cellphone: 'CELULAR', diagnostic: 'DIAGNOSTICO', dream: 'SUEÑO DEL NIÑ@', child_status: 'ESTADO') do |row|
	      next if row[:hospital] == 'HOSPITAL' 
	      pollInformation << row 
	    end

	    pollInformation.each do |info|

	    	# Crear una ciudad a partir de datos en el excel puede implicar
		    # Un error a nuestro criterio si el valor del nombre de la ciudad
		    # No existe. Toca revisar este punto.
		    # Crear el diagnostico puede incurrir en una condicion similar a la de crear la ciudad.
	        begin 
	        	city = City.find_or_create_by!(name: info[:city])
	         	hospital =  Hospital.find_or_create_by!(name: info[:hospital], city_id: city.id)
	    	    diagnostic = Diagnostic.find_or_create_by(name: info[:diagnostic]) 
	    		status =  ChildStatus.find_or_create_by!(name: info[:child_status])
	    		child = Child.create!(hospital: hospital, name: info[:name], birth_date: info[:birthday], genere: '', address: info[:address], city: city, dream: info[:dream] , diagnostic: diagnostic, child_status: status)
	        rescue ActiveRecord::RecordInvalid => e
	         	errors << 'Error en la creacion de ' + e.record.class.to_s + ': ' + e.message.to_s
	       end
	  	end

	  	return errors

    end


end