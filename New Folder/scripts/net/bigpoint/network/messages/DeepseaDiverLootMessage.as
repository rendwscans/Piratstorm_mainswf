package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class DeepseaDiverLootMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1546;
      
      private var _joker:int;
      
      private var _lootList:MessageList = new MessageList();
      
      public function DeepseaDiverLootMessage()
      {
         super();
         this.lootList = new MessageList();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._joker = input.readByte();
         this._lootList.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeByte(this._joker);
         this._lootList.serialize(output);
      }
      
      public function get joker() : int
      {
         return this._joker;
      }
      
      public function set joker(joker:int) : void
      {
         this._joker = joker;
      }
      
      public function get lootList() : MessageList
      {
         return this._lootList;
      }
      
      public function set lootList(lootList:MessageList) : void
      {
         this._lootList = lootList;
      }
      
      public function toString() : String
      {
         return "\"DeepseaDiverLootMessage\": {" + "\"_joker\": \"" + this._joker + "\" " + ", " + "\"_lootList\": \"" + this._lootList + "\" " + "}";
      }
   }
}

