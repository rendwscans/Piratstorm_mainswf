package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class SocialFriendInviteSendRequestMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1502;
      
      private var _userId:int;
      
      public function SocialFriendInviteSendRequestMessage()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._userId = input.readInt();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeInt(this._userId);
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function set userId(userId:int) : void
      {
         this._userId = userId;
      }
      
      public function toString() : String
      {
         return "\"SocialFriendInviteSendRequestMessage\": {" + "\"_userId\": \"" + this._userId + "\" " + "}";
      }
   }
}

