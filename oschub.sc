OSCHub {

	classvar <instances;
	var <instance, <trigSynth, <sendReply;

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
					^("Mensaje conjunto:" + list.join(", \n -> "));
				}
			);

			},{

				^"Solo usa las llaves 'single' o 'bundle' en el argumento 'type'";

		});

	}

	triggerOSC {|signal = 'audio', frames = 30, inputFunc|

		if(signal == 'audio' or: {signal == 'midi'} or: {signal == 'custom'}, {

			switch(signal,
				\audio, {

					sendReply = {SendReply.kr(Impulse.kr(frames),'/reply1',Amplitude.kr(inputFunc.value))};

					// OSCdef(\responder,{|msg| instance.sendMsg(signal,msg[3]);},'/reply1');
					OSCdef(\responder,{|msg| this.sendOSC('single',signal,msg[3].postln)},'/reply1');

					sendReply.play;

					// sendReply.stopTrigger;

					^"Mensajes OSC ejecutandose";

				},

				\midi, {instance.sendMsg("/midi","Mensaje MIDI");^"MIDI".inform},
				\custom, {instance.sendMsg("/custom","Mensaje custom");^"Custom".inform},
			);
			}, {

				^"Tipos de entrada, llaves: \audio, \midi o \custom";

		});

	}

	stopTrigger { ^sendReply.free }

}