package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class MoveAbortMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1018;
      
      private var _reason:int;
      
      public function MoveAbortMessage()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._reason = input.readByte();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeByte(this._reason);
      }
      
      public function get reason() : int
      {
         return this._reason;
      }
      
      public function set reason(reason:int) : void
      {
         this._reason = reason;
      }
      
      public function toString() : String
      {
         return "\"MoveAbortMessage\": {" + "\"_reason\": \"" + this._reason + "\" " + "}";
      }
   }
}

