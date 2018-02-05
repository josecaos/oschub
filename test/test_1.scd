Platform.userExtensionDir;
Platform.systemExtensionDir;
//clase
OSCHub;
//Instancia
a = OSCHub.new;//an OSCHub
b = OSCHub.new;//an OSCHub
c = OSCHub.new;//an OSCHub
a.connectTo;
b.connectTo("Uno",port:57121);
c.connectTo("Dos",port:57122);
OSCHub.instances;
a.inputType;

OSCdef(\responde,{|msg,time,addr,recvPort|[msg,time,addr,recvPort].postcln},\audio);
OSCdef.freeAll;


//
s.boot;
h = NetAddr("127.0.0.1",57120);
h.sendMsg("/test","Single Message");
h.sendBundle(1e4,["/test","Bundle message","xxx"]);
x = {SinOsc.ar(Amplitude.kr(Impulse.kr(2),0.01,0.01,80,120).poll)};
x.play;
s.scope;
x.value;
Amplitude.ar(Impulse.kr(2),0.01,0.01)
h.sendMsg("/test",x.post);
OSCdef(\responde,{|msg,time,addr,recvPort|[msg,time,addr,recvPort].postcln},\test,h,57120);
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
