package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class DebugMoveRequestMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1362;
      
      private var _enable:Boolean;
      
      public function DebugMoveRequestMessage()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._enable = input.readBoolean();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeBoolean(this._enable);
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      public function set enable(enable:Boolean) : void
      {
         this._enable = enable;
      }
      
      public function toString() : String
      {
         return "\"DebugMoveRequestMessage\": {" + "\"_enable\": \"" + this._enable + "\" " + "}";
      }
   }
}

