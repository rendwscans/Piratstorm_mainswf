package net.bigpoint.pirateStorm.factories.objectiveMessages
{
   import net.bigpoint.network.messages.IMessage;
   
   public class ObjectiveMessageFactory
   {
      
      private static var factories:Vector.<IObjectiveMessageFactory> = new <IObjectiveMessageFactory>[new EventObjectiveMessageFactory()];
      
      public function ObjectiveMessageFactory()
      {
         super();
      }
      
      private static function getFactory(objectiveMessagesId:int) : IObjectiveMessageFactory
      {
         var factory:IObjectiveMessageFactory = null;
         for each(factory in factories)
         {
            if(factory.canFabricate(objectiveMessagesId))
            {
               return factory;
            }
         }
         return null;
      }
      
      public static function getObjectiveMessages(objectiveMessagesId:int) : Vector.<IMessage>
      {
         var factory:IObjectiveMessageFactory = getFactory(objectiveMessagesId);
         if(factory != null)
         {
            return factory.getObjectiveMessages(objectiveMessagesId);
         }
         return new Vector.<IMessage>();
      }
   }
}

