//
// SynthDef(\amp,{SendTrig.kr(Impulse.kr(4),0,Amplitude.kr(Pulse.ar([40,40.5],0.25,1)))}).add;
a = {SendTrig.kr(Impulse.kr(4),0,Amplitude.kr(Pulse.ar([40,40.5],0.25,1)))};
a.play;
// Synth(\amp);

//
s.boot;
x = OSCHub.new;
OSCdef(\test,{|msg| ~test = msg[1].post},\audio);
~test.value.postcln;
x.connectTo("amplitud");
x.triggerOSC(\audio,1,{Pulse.ar(SinOsc.ar(2,0,60,120),0.1,LFNoise0.ar(4,0.01,1))});
x.triggerOSC(\audio,8,{CaosKick.ar(att:0.15,rel:0.1,gate:1)});
x.stopTrigger;

// OSCFunc.trace(false);

x = { |freq = 440| SinOsc.ar(freq, 0, 0.3) }.play; // this returns a Synth object;
x.set(\freq, 42); // note you can set the freq argument
x.defName; // the name of the resulting SynthDef (generated automatically in a cycle of 512)
x.release(4); // fadeout over 4 seconds