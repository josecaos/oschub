Platform.userExtensionDir;
Platform.systemExtensionDir;
//
OSCHub;//OSCHub
OSCHub.connectTo;
h = OSCHub.new;//an OSCHub
h.connectTo;
h.inputType;



//
h = NetAddr("127.0.0.1",57120);
h.sendMsg("/test",10000000);
OSCdef(\responde,{|msg,time,addr,recvPort|[msg,time,addr,recvPort].postcln},\test,h,57120);
//
OSCFunc.trace(true);

NetAddr.langPort;
NetAddr.localAddr;

//
AbstractResponderFunc.allFuncProxies
AbstractResponderFunc.allEnabled
OSCdef(\test).disable;
OSCdef(\test).enable;
AbstractResponderFunc.allDisabled