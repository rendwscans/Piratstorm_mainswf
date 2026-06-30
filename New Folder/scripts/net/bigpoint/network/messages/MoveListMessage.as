package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class MoveListMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1015;
      
      private var _userId:int;
      
      private var _moveList:MessageList = new MessageList();
      
      private var _time:int;
      
      public function MoveListMessage()
      {
         super();
         this.moveList = new MessageList();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._userId = input.readInt();
         this._moveList.deserialize(input);
         this._time = input.readInt();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeInt(this._userId);
         this._moveList.serialize(output);
         output.writeInt(this._time);
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function set userId(userId:int) : void
      {
         this._userId = userId;
      }
      
      public function get moveList() : MessageList
      {
         return this._moveList;
      }
      
      public function set moveList(moveList:MessageList) : void
      {
         this._moveList = moveList;
      }
      
      public function get time() : int
      {
         return this._time;
      }
      
      public function set time(time:int) : void
      {
         this._time = time;
      }
      
      public function toString() : String
      {
         return "\"MoveListMessage\": {" + "\"_userId\": \"" + this._userId + "\" " + ", " + "\"_moveList\": \"" + this._moveList + "\" " + ", " + "\"_time\": \"" + this._time + "\" " + "}";
      }
   }
}

