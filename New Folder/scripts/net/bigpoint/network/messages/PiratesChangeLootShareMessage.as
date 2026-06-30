package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class PiratesChangeLootShareMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1129;
      
      private var _lootShare:int;
      
      public function PiratesChangeLootShareMessage()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._lootShare = input.readByte();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeByte(this._lootShare);
      }
      
      public function get lootShare() : int
      {
         return this._lootShare;
      }
      
      public function set lootShare(lootShare:int) : void
      {
         this._lootShare = lootShare;
      }
      
      public function toString() : String
      {
         return "\"PiratesChangeLootShareMessage\": {" + "\"_lootShare\": \"" + this._lootShare + "\" " + "}";
      }
   }
}

