package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.getQualifiedClassName;
   import net.bigpoint.network.MessageParser;
   
   public class MessageList implements IMessage
   {
      
      public static const MESSAGE_ID:int = 0;
      
      private var _list:Vector.<IMessage> = new Vector.<IMessage>();
      
      public function MessageList()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         var length:int = input.readShort();
         this.list.length = 0;
         for(var i:int = 0; i < length; i++)
         {
            this.list.push(MessageParser.retrieveMessage(input));
         }
      }
      
      public function serialize(output:IDataOutput) : void
      {
         var message:IMessage = null;
         output.writeShort(this.list.length);
         for each(message in this.list)
         {
            MessageParser.writeMessage(message,output);
         }
      }
      
      public function toString() : String
      {
         var message:IMessage = null;
         var name:String = null;
         var listing:String = "{";
         var count:int = 0;
         for each(message in this.list)
         {
            name = getQualifiedClassName(message);
            name = name.substr(name.lastIndexOf(":") + 1,name.length);
            listing += name + " [" + message;
            if(count++ < this.list.length)
            {
               listing += "] ";
            }
         }
         return listing + "}";
      }
      
      public function get list() : Vector.<IMessage>
      {
         return this._list;
      }
      
      public function set list(list:Vector.<IMessage>) : void
      {
         this._list = list;
      }
   }
}

