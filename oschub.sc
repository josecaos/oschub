OSCHub {

	classvar <instances;
	var instance;

	*new {

		^super.new;

	}

	connectTo {|id = "Default", ip = "127.0.0.1", port = 57120|

		var post = id;
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

				instances.add(id);//coloca el nombre en la lista

				id = NetAddr.new(ip,port);

				instance = id;

				^("Instancia '" + post + "' conectada a ip:" + ip + ", puerto:" + port);
		});
	}

	sendOSC {|type = 'single',tag ...args|

		if(type == 'single' or: {type == 'bundle'},{

			switch(type,

				'single', {
					instance.sendMsg(tag,args[0]);
					^("Mensaje simple:" + tag + args[0])
				},
				'bundle', {
					var list = [tag];
					args.collect({|item|
						list = list.add(item)
					});
					instance.sendBundle(0.01,list);
					^("Mensaje conjunto:" + list.join(", \n ->"));
				}
			);

			},{

				^"Solo usa las llaves 'single' o 'bundle' en el argumento 'type'";

		});

	}

	// Falta la logica para enviar distintos tipos de mensaje +
	// diferenciar entre mensaje y conjunto de mensajes
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