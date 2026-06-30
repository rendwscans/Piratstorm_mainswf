package net.bigpoint.network.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public interface IMessage
   {
      
      function get id() : int;
      
      function deserialize(param1:IDataInput) : void;
      
      function serialize(param1:IDataOutput) : void;
      
      function toString() : String;
   }
}

