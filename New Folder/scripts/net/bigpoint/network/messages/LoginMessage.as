package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class LoginMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1003;
      
      private var _userId:int;
      
      private var _sessionId:String;
      
      public function LoginMessage()
      {
         super();
         this.sessionId = "";
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._userId = input.readInt();
         this._sessionId = input.readUTF();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeInt(this._userId);
         output.writeUTF(this._sessionId);
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function set userId(userId:int) : void
      {
         this._userId = userId;
      }
      
      public function get sessionId() : String
      {
         return this._sessionId;
      }
      
      public function set sessionId(sessionId:String) : void
      {
         this._sessionId = sessionId;
      }
      
      public function toString() : String
      {
         return "\"LoginMessage\": {" + "\"_userId\": \"" + this._userId + "\" " + ", " + "\"_sessionId\": \"" + this._sessionId + "\" " + "}";
      }
   }
}

