package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class LastmanStandingPlayercountMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1407;
      
      private var _playerCount:int;
      
      public function LastmanStandingPlayercountMessage()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._playerCount = input.readShort();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeShort(this._playerCount);
      }
      
      public function get playerCount() : int
      {
         return this._playerCount;
      }
      
      public function set playerCount(playerCount:int) : void
      {
         this._playerCount = playerCount;
      }
      
      public function toString() : String
      {
         return "\"LastmanStandingPlayercountMessage\": {" + "\"_playerCount\": \"" + this._playerCount + "\" " + "}";
      }
   }
}

