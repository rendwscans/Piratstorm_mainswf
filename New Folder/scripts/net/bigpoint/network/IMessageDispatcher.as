package net.bigpoint.network
{
   import net.bigpoint.network.messages.IMessage;
   
   public interface IMessageDispatcher
   {
      
      function notify(param1:IMessage) : void;
      
      function consumedBytes(param1:int) : void;
   }
}

