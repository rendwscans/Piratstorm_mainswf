package net.bigpoint.network
{
   public class MessageSession
   {
      
      private var _sequenceNumber:uint;
      
      private var _replySequenceNumber:uint;
      
      private var _flags:int;
      
      private var _messageLength:uint = 0;
      
      private var _ready:Boolean;
      
      public function MessageSession()
      {
         super();
      }
      
      public function isReady() : Boolean
      {
         return this._ready;
      }
      
      public function reset() : void
      {
         this._ready = false;
      }
      
      public function setValues(sequenceNumber:uint, replySequenceNumber:uint, flags:int, messageLength:uint) : void
      {
         this._sequenceNumber = sequenceNumber;
         this._replySequenceNumber = replySequenceNumber;
         this._flags = flags;
         this._messageLength = messageLength;
         this._ready = true;
      }
      
      public function getMessageLength() : uint
      {
         return this._messageLength;
      }
   }
}

