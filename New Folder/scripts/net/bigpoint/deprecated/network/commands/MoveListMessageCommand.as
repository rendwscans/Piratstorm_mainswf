package net.bigpoint.deprecated.network.commands
{
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import mx.logging.Log;
   import net.bigpoint.deprecated.game.model.EntityProxy;
   import net.bigpoint.deprecated.game.model.vo.EntityVO;
   import net.bigpoint.network.messages.MoveListMessage;
   
   public class MoveListMessageCommand
   {
      
      private static const entityProxy:EntityProxy = UnpureFacade.getInstance().retrieveProxy(EntityProxy.NAME) as EntityProxy;
      
      public function MoveListMessageCommand()
      {
         super();
      }
      
      public static function run(message:MoveListMessage) : void
      {
         var entityVO:EntityVO = entityProxy.getEntity(message.userId);
         if(entityVO != null)
         {
            entityVO.entity.movePath(message.moveList,message.time);
         }
         else
         {
            Log.getLogger("MoveListMessageCommand").warn("unknown entity! can\'t move " + message.userId);
         }
      }
   }
}

