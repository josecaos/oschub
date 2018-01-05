OSCHub {

	*new {

		^super.new;
	}


	*connectTo {|ip = "127.0.0.1", port = 57120|

		NetAddr(ip,port);

		^"Conexión";
	}

	inputType {|type = 'custom'|
		// type: audio,midi,custom

		if(type == 'audio' or: {type == 'midi'} or: {type == 'custom'}, {

			switch(type,
				\audio, {^"Audio".inform},
				\midi, {^"MIDI".inform},
				\custom, {^"Custom".inform},
				);
			}, {

				^"Tipos de entrada: \audio, \midi, \custom";

		});

	}



}