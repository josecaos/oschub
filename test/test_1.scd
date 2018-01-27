Platform.userExtensionDir;
Platform.systemExtensionDir;
//
OSCHub;//OSCHub
OSCHub.connectTo;
//
h = OSCHub.new;//an OSCHub
i = OSCHub.new;//an OSCHub
j = OSCHub.new;//an OSCHub
h.connectTo;
i.connectTo("Uno",port:57121);
j.connectTo("Dos",port:57122);
OSCHub.instances;
h.inputType;

OSCdef(\responde,{|msg,time,addr,recvPort|[msg,time,addr,recvPort].postcln},\audio);
OSCdef.freeAll;


//
s.boot;
h = NetAddr("127.0.0.1",57120);
h.sendMsg("/test",10000000);
x = {SinOsc.ar(80,0,0.1)};
x.play;
s.scope
h.sendMsg("/test",Amplitude.ar(x));
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