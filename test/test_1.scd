s.boot;
//clase
z=OSCHub;
z.instances;
//Instancia
a = OSCHub.new;//an OSCHub
b = OSCHub.new;//an OSCHub
c = OSCHub.new;//an OSCHub
a.connectTo("Test");
b.connectTo("Uno",port:57121);
c.connectTo("Dos",port:57122);

OSCdef(\test,{|msg,time,addr,recvPort,gate|play{CaosKick.ar(gate:msg[1])}},\test,h,57120);

OSCdef(\test,{|msg,time,addr,recvPort,gate|msg.postcln},\test,h,57120);

a.sendOSC(\single,\test,1);
a.sendOSC(\bundle,\test,1,2,3,4,5,6,7,8,9,0);
//
//
s.boot;
h = NetAddr("127.0.0.1",57120);
OSCdef(\responde,{|msg,time,addr,recvPort,gate|play{CaosKick.ar(gate:msg[1])}},\test,h,57120);
x = {SinOsc.ar(Amplitude.kr(Impulse.kr(1),0.01,0.01,80,120).poll)};
x.play;
x.value;
h.sendMsg("/test",1);
h.sendBundle(1e4,["/test",1,"Bundled message","xxx","---","///"]);
Amplitude.ar(Impulse.kr(2),0.01,0.01)
h.sendMsg("/test",x.post);
h.ip;
//
OSCFunc.trace(true);

NetAddr.langPort;
NetAddr.localAddr;

"PIZZA".toLower;
"pizzzza".toUpper;
//
AbstractResponderFunc.allFuncProxies
AbstractResponderFunc.allEnabled
OSCdef(\test).disable;
OSCdef(\test).enable;
AbstractResponderFunc.allDisabled
//
