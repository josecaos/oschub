s.boot;
//
b = OSCHub.new;
k = OSCHub.new;
b.connectTo("eich","127.0.0.1");
k.connectTo("cuatreoxs","192.168.0.1",57121);
b.instance.ip;
k.instance.ip;

b.inputSignal(\audio,SinOsc.ar([120,120.125],0,1),4);
b.loadTrig;
b.ampTrig(true);

OSCdef(\res,{|msg,time,addr,recvPort| [msg,time,addr,recvPort].postcln;},\test);
OSCdef(\test1,{|msg,time,addr,recvPort| [msg,time,addr,recvPort].postcln;},\uno,port:57120);
OSCdef(\test2,{|msg,time,addr,recvPort|[msg,time,addr,recvPort].postcln;},\dos,k.instance.ip,57120);

b.sendOSC(\single,\uno,rrand(100,10000));
k.sendOSC(\single,\dos,rrand(0,10));
b.sendOSC(\bundle,\uno,10,2000,300);
k.sendOSC(\bundle,\dos,1,2,3);
OSCHub.instances


//
x=NetAddr("127.0.0.1",57120);
OSCdef(\test,{|msg,time,addr,recvPort|[msg].postcln;},"\seq",x.ip,57120);
x.sendMsg("\seq",100000);
(
Tdef(\testloop,{
	var uno = Prand([0,1,2,3,4,5,6,7,8,9],inf).asStream;
	inf.do({|i|
		// k.sendOSC(\bundle,\tr,i,2,3);
		x.sendMsg("\seq",100000);
		// uno.resume.postcln;
		i=i+1;
		// i.post;
		0.15.wait;
	});
});
);
Tdef(\testloop).play;
Tdef(\testloop).stop;


// amplitud follower test
(
SynthDef("help-SendTrig",{
	SendTrig.kr(Impulse.kr(8),0,Amplitude.kr(SinOsc.ar([120,120.125],0,1)));
}).send(s);

// register to receive this message
/*o = OSCFunc({ arg msg, time;
    [msg].postln;
},'/tr', s.addr);*/
OSCdef(\ampResponder,{|msg,time,addr,recvPort| msg.postcln},'/tr');
)
Synth("help-SendTrig");
o.free;