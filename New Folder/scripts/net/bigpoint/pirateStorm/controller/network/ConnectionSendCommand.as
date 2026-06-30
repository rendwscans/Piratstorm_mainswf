package net.bigpoint.pirateStorm.controller.network
{
   import mvcexpress.extensions.unpuremvc.patterns.command.UnpureSimpleCommand;
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import mvcexpress.extensions.unpuremvc.patterns.observer.UnpureNotification;
   import net.bigpoint.deprecated.game.model.ConnectionProxy;
   import net.bigpoint.network.messages.IMessage;
   
   public class ConnectionSendCommand extends UnpureSimpleCommand
   {
      
      private static var _connectionProxy:ConnectionProxy;
      
      protected static const facade:UnpureFacade = UnpureFacade.getInstance() as UnpureFacade;
      
      public function ConnectionSendCommand()
      {
         super();
      }
      
      public static function get connectionProxy() : ConnectionProxy
      {
         if(!_connectionProxy)
         {
            _connectionProxy = facade.retrieveProxy(ConnectionProxy.NAME) as ConnectionProxy;
         }
         return _connectionProxy;
      }
      
      override public function execute(notification:UnpureNotification) : void
      {
         connectionProxy.send(notification.getBody() as IMessage);
      }
   }
}

