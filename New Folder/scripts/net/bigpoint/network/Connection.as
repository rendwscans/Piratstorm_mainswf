package net.bigpoint.network
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.Endian;
   import flash.utils.getQualifiedClassName;
   import mindscriptact.utils.benchmark.BenchMark;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import net.bigpoint.network.messages.IMessage;
   import net.bigpoint.network.messages.LoginMessage;
   
   public class Connection extends EventDispatcher
   {
      
      public static const CONNECTION_READY:String = "CONNECTION_READY";
      
      public static const CONNECTION_PROBLEM:String = "CONNECTION_PROBLEM";
      
      public static const CONNECTION_NOT_FOUND:String = "CONNECTION_NOT_FOUND";
      
      private static const logger:ILogger = Log.getLogger("Connection");
      
      private static var _userId:int = 0;
      
      private var messageDispatcher:IMessageDispatcher;
      
      private var socket:Socket;
      
      private var isConnecting:Boolean = false;
      
      private var parser:MessageParser;
      
      private var _host:String;
      
      private var _port:String;
      
      public function Connection(proxy:IMessageDispatcher)
      {
         super();
         this.messageDispatcher = proxy;
         MessageLookup.init();
      }
      
      public static function get userId() : int
      {
         return _userId;
      }
      
      private function init(host:String, policyPort:String) : void
      {
         Security.loadPolicyFile("xmlsocket://" + host + ":" + policyPort);
         this.socket = new Socket();
         this.socket.endian = Endian.BIG_ENDIAN;
         if(this.parser == null)
         {
            this.parser = new MessageParser(this.socket,this);
         }
         else
         {
            this.parser.reInit(this.socket);
         }
      }
      
      public function connect(host:String, port:String, policyPort:String = "843") : void
      {
         if(this.isConnecting)
         {
            logger.warn("CONNECTING already in progress");
            return;
         }
         this.isConnecting = true;
         if(this.socket != null && this.socket.connected)
         {
            this.disconnect();
         }
         this._host = host;
         this._port = port;
         this.init(host,policyPort);
         logger.info("CONNECTING TO: " + host + ":" + port);
         this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.handleSocketData);
         this.socket.addEventListener(Event.CONNECT,this.handleConnect);
         this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleError);
         this.socket.addEventListener(Event.CLOSE,this.handleConnectionLost);
         this.socket.connect(host,parseInt(port));
      }
      
      public function disconnect() : void
      {
         try
         {
            this.socket.close();
         }
         catch(error:Error)
         {
            logger.warn(error.getStackTrace());
         }
      }
      
      private function handleConnect(event:Event) : void
      {
         logger.info("CONNECTING SUCCESSFUL");
         this.isConnecting = false;
         dispatchEvent(new Event(CONNECTION_READY));
      }
      
      public function handleConnectionLost(event:Event = null) : void
      {
         logger.error("LOST CONNECTION");
         dispatchEvent(new Event(CONNECTION_PROBLEM));
      }
      
      private function handleError(event:ErrorEvent) : void
      {
         logger.error("ERROR " + event.type.toUpperCase() + " while connecting to GameServer: " + event.text);
         this.isConnecting = false;
         dispatchEvent(new Event(CONNECTION_NOT_FOUND));
      }
      
      private function handleSocketData(event:ProgressEvent) : void
      {
         var benchmarkId:int = 0;
         if(BenchMark.isEnabled)
         {
            benchmarkId = BenchMark.stack("Skt");
         }
         if(!this.parser.incommingData())
         {
            this.disconnect();
            this.handleConnectionLost();
         }
         if(BenchMark.isEnabled)
         {
            BenchMark.unstack(benchmarkId);
         }
      }
      
      public function send(message:IMessage) : void
      {
         var name:Array = null;
         name = getQualifiedClassName(message).split("::");
         logger.debug("[" + _userId + "] SOCKET OUT: " + name[1] + " " + message);
         if(this.isConnected())
         {
            this.parser.sendMessage(message);
         }
      }
      
      public function sendLogin(userid:int, pid:String) : void
      {
         var message:LoginMessage = new LoginMessage();
         _userId = userid;
         message.userId = userid;
         message.sessionId = pid;
         this.send(message);
      }
      
      public function isConnected() : Boolean
      {
         if(this.socket == null)
         {
            return false;
         }
         return this.socket.connected;
      }
      
      public function consumedBytes(amount:int) : void
      {
         this.messageDispatcher.consumedBytes(amount);
      }
      
      public function execute(message:IMessage) : void
      {
         this.messageDispatcher.notify(message);
      }
   }
}

