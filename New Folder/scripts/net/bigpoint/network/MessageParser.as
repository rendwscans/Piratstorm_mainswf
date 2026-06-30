package net.bigpoint.network
{
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import net.bigpoint.network.messages.IMessage;
   
   public class MessageParser
   {
      
      private static const MAGIC_BYTE:uint = 3735929054;
      
      private static const HEADER_LENGTH:uint = 13;
      
      private static const logger:ILogger = Log.getLogger("MessageParser");
      
      private var socket:Socket;
      
      private var connection:Connection;
      
      private var messageSession:MessageSession;
      
      private var _sequenceNumber:uint = 0;
      
      private var messageByteArray:ByteArray = new ByteArray();
      
      public function MessageParser(socket:Socket, connection:Connection)
      {
         super();
         this.socket = socket;
         this.connection = connection;
         this.messageSession = new MessageSession();
      }
      
      public static function retrieveMessage(input:IDataInput, internCall:Boolean = false) : IMessage
      {
         var name:Array = null;
         var messageID:uint = input.readUnsignedShort();
         var message:IMessage = new MessageLookup.getMessageLookupTable()[messageID]();
         message.deserialize(input);
         if(internCall)
         {
            name = getQualifiedClassName(message).split("::");
            logger.info("[" + Connection.userId + "] " + messageID + " " + name[1] + " [" + message + "]");
         }
         return message;
      }
      
      public static function writeMessage(message:IMessage, output:IDataOutput) : void
      {
         output.writeShort(message.id);
         message.serialize(output);
      }
      
      public function reInit(socket:Socket) : void
      {
         this.socket = socket;
      }
      
      public function incommingData() : Boolean
      {
         var before:uint = 0;
         var magicByte:uint = 0;
         while(true)
         {
            before = this.socket.bytesAvailable;
            if(this.messageSession.isReady())
            {
               if(before >= this.messageSession.getMessageLength())
               {
                  this.connection.execute(retrieveMessage(this.socket,true));
                  this.messageSession.reset();
               }
            }
            else if(before > HEADER_LENGTH)
            {
               magicByte = this.socket.readUnsignedInt();
               if(magicByte != MAGIC_BYTE)
               {
                  break;
               }
               this.messageSession.setValues(this.socket.readUnsignedShort(),this.socket.readUnsignedShort(),this.socket.readByte(),this.socket.readUnsignedInt());
            }
            this.consumed(before - this.socket.bytesAvailable);
            if(!(before > HEADER_LENGTH && before >= this.messageSession.getMessageLength()))
            {
               return true;
            }
         }
         logger.debug("MagicBytes " + magicByte + " " + MAGIC_BYTE);
         return false;
      }
      
      private function consumed(amount:int) : void
      {
         this.connection.consumedBytes(amount);
      }
      
      public function sendMessage(message:IMessage) : void
      {
         this.messageByteArray.clear();
         this.messageByteArray.writeUnsignedInt(MAGIC_BYTE);
         this.messageByteArray.writeShort(this._sequenceNumber++);
         this.messageByteArray.writeShort(0);
         this.messageByteArray.writeByte(240);
         this.messageByteArray.writeInt(0);
         writeMessage(message,this.messageByteArray);
         this.messageByteArray.position = HEADER_LENGTH - 4;
         this.messageByteArray.writeInt(this.messageByteArray.length - HEADER_LENGTH);
         this.socket.writeBytes(this.messageByteArray,0,this.messageByteArray.length);
         this.socket.flush();
      }
   }
}

