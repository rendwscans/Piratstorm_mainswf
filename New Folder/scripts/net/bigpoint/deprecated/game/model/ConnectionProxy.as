package net.bigpoint.deprecated.game.model
{
   import flash.events.Event;
   import flash.utils.getTimer;
   import mx.logging.Log;
   import net.bigpoint.deprecated.game.controller.init.GameNotification;
   import net.bigpoint.deprecated.game.debug.DebugView;
   import net.bigpoint.deprecated.network.CommandLookup;
   import net.bigpoint.deprecated.network.QuestLookup;
   import net.bigpoint.network.Connection;
   import net.bigpoint.network.IMessageDispatcher;
   import net.bigpoint.network.messages.IMessage;
   import net.bigpoint.network.messages.MessageList;
   import net.bigpoint.pirateStorm.constants.LoadirgErrorCode;
   import net.bigpoint.pirateStorm.notifications.Notice;
   
   public class ConnectionProxy extends LoadableProxy implements IMessageDispatcher
   {
      
      public static const NAME:String = "ConnectionProxy";
      
      public static const LOAD_SUCCESSFUL:String = NAME + "loadSuccessful";
      
      public static const LOAD_FAILED:String = NAME + "loadFailed";
      
      private static const MESSAGE_QUEUE_THRESHOLD:int = 50;
      
      private static const MAX_EXECUTION_TIME:int = 15;
      
      private var execute:Function;
      
      private var executeModeDirect:Boolean = true;
      
      private var connection:Connection;
      
      private var connectionCallback:Function = null;
      
      private var messageQueue:Vector.<IMessage> = new Vector.<IMessage>();
      
      public function ConnectionProxy(data:Object = null)
      {
         this.execute = this.executeDirect;
         super(NAME,data);
      }
      
      override public function load() : void
      {
         CommandLookup.init();
         QuestLookup.init();
         this.connection = new Connection(this);
         var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
         if(configProxy.getValue(ConfigProxy.TUTORIAL) != "1")
         {
            this.connect();
         }
         else
         {
            loadingEnd(LOAD_SUCCESSFUL);
         }
         this.execute = this.executeDelayed;
         UpdateHandler.addCallback(this.onEnterFrame);
         this.executeModeDirect = false;
      }
      
      private function handleGameserverConnection(event:Event) : void
      {
         Log.getLogger("ConnectionProxy").info("CONNECTION ESTABLISHED");
         if(this.connectionCallback == null)
         {
            loadingEnd(LOAD_SUCCESSFUL);
         }
         else
         {
            this.connectionCallback();
         }
      }
      
      private function handleGameserverConnectionProblem(event:Event) : void
      {
         Log.getLogger("ConnectionProxy").error("CONNECTION LOST");
         facade.sendNotification(Notice.LOGOUT_START_LOGOUT);
         loadingEnd(LOAD_FAILED,LoadirgErrorCode.ERROR_CONNECTION_LOST);
      }
      
      private function handleGameserverNotFound(event:Event) : void
      {
         Log.getLogger("ConnectionProxy").error("SERVER NOT FOUND");
         facade.sendNotification(GameNotification.CONNECTION_RECONNECT);
         loadingEnd(LOAD_FAILED,LoadirgErrorCode.ERROR_CONNECTION_NOT_FOUND);
      }
      
      public function send(message:IMessage) : void
      {
         this.connection.send(message);
      }
      
      public function connectAndLogin() : void
      {
         this.connectionCallback = this.sendLogin;
         this.connect();
      }
      
      private function connect() : void
      {
         var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
         var host:String = configProxy.getValue(ConfigProxy.HOST);
         var port:String = configProxy.getValue(ConfigProxy.PORT);
         var policyPort:String = configProxy.getValue(ConfigProxy.POLICY_PORT);
         this.connection.addEventListener(Connection.CONNECTION_READY,this.handleGameserverConnection);
         this.connection.addEventListener(Connection.CONNECTION_PROBLEM,this.handleGameserverConnectionProblem);
         this.connection.addEventListener(Connection.CONNECTION_NOT_FOUND,this.handleGameserverNotFound);
         this.connection.connect(host,port,policyPort);
      }
      
      public function sendLogin() : void
      {
         var config:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
         this.connection.sendLogin(parseInt(config.getValue(ConfigProxy.USER_ID)),config.getValue(ConfigProxy.SESSION_ID));
      }
      
      public function isConnected() : Boolean
      {
         return this.connection.isConnected();
      }
      
      public function notify(message:IMessage) : void
      {
         this.execute(message);
      }
      
      private function executeDirect(message:IMessage) : void
      {
         CommandLookup.execute(message);
      }
      
      private function executeDelayed(message:IMessage) : void
      {
         var mess:IMessage = null;
         if(message is MessageList)
         {
            for each(mess in MessageList(message).list)
            {
               this.executeDelayed(mess);
            }
         }
         else
         {
            this.messageQueue.push(message);
         }
      }
      
      public function toggleExecuteMode() : void
      {
         this.executeModeDirect = !this.executeModeDirect;
         if(this.executeModeDirect)
         {
            this.execute = this.executeDirect;
            UpdateHandler.removeCallback(this.onEnterFrame);
            while(this.messageQueue.length > 0)
            {
               this.onEnterFrame();
            }
         }
         else
         {
            this.execute = this.executeDelayed;
            UpdateHandler.addCallback(this.onEnterFrame);
         }
         Log.getLogger("ConnectionProxy").warn("executeMode: " + (this.executeModeDirect ? "direct" : "delayed"));
      }
      
      private function onEnterFrame() : void
      {
         var message:IMessage = null;
         var ts:int = getTimer() + MAX_EXECUTION_TIME;
         if(this.messageQueue.length > 0)
         {
            if(this.messageQueue.length > MESSAGE_QUEUE_THRESHOLD)
            {
               while(this.messageQueue.length > MESSAGE_QUEUE_THRESHOLD / 2)
               {
                  message = this.messageQueue.shift();
                  if(message != null)
                  {
                     this.executeDirect(message);
                  }
               }
            }
            else
            {
               do
               {
                  message = this.messageQueue.shift();
                  if(message != null)
                  {
                     this.executeDirect(message);
                  }
               }
               while(ts > getTimer());
            }
         }
      }
      
      public function consumedBytes(amount:int) : void
      {
         DebugView.getInstance().consumedBytes(amount);
      }
   }
}

