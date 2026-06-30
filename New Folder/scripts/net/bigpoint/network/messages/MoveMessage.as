package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class MoveMessage implements IMessage
   {
      
      public static const MESSAGE_ID:int = 1016;
      
      private var _posX:int;
      
      private var _posY:int;
      
      public function MoveMessage()
      {
         super();
      }
      
      public function get id() : int
      {
         return MESSAGE_ID;
      }
      
      public function deserialize(input:IDataInput) : void
      {
         this._posX = input.readShort();
         this._posY = input.readShort();
      }
      
      public function serialize(output:IDataOutput) : void
      {
         output.writeShort(this._posX);
         output.writeShort(this._posY);
      }
      
      public function get posX() : int
      {
         return this._posX;
      }
      
      public function set posX(posX:int) : void
      {
         this._posX = posX;
      }
      
      public function get posY() : int
      {
         return this._posY;
      }
      
      public function set posY(posY:int) : void
      {
         this._posY = posY;
      }
      
      public function toString() : String
      {
         return "\"MoveMessage\": {" + "\"_posX\": \"" + this._posX + "\" " + ", " + "\"_posY\": \"" + this._posY + "\" " + "}";
      }
   }
}

