OSCHub {

	classvar >instances;
	var >instance;

	*new {

		^super.new;

	}

	connectTo {|id = "Default", ip = "127.0.0.1", port = 57120|

		id = id.toLower;


		// Asegura ID unico por instancia
		if(instances.isNil, {
			instances = Array.new(7);
			},{
				instances = instances;
		});
		//

		if(instances.find([id]).notNil, {

			^"Este ID ya existe, utiliza otro";

			},{

				instances.add(id);//coloca el nombre

				id = NetAddr.new(ip,port);

				instance = id;

				^"Conexión";
		});
	}

	inputType {|type = 'audio'|
		// type: audio,midi,custom

		if(type == 'audio' or: {type == 'midi'} or: {type == 'custom'}, {

			switch(type,
				\audio, {instance.sendMsg("/audio","Mensaje de amplitud");^"Audio".inform},
				\midi, {instance.sendMsg("/midi","Mensaje MIDI");^"MIDI".inform},
				\custom, {instance.sendMsg("/custom","Mensaje custom");^"Custom".inform},
			);
			}, {

				^"Tipos de entrada: \audio, \midi, \custom";

		});

	}



}