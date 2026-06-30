package net.bigpoint.deprecated.network.commands.item
{
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import net.bigpoint.deprecated.game.model.InventoryProxy;
   import net.bigpoint.network.messages.InventoryMoveItemMessage;
   
   public class InventoryMoveItemMessageCommand
   {
      
      private static const inventoryProxy:InventoryProxy = UnpureFacade.getInstance().retrieveProxy(InventoryProxy.NAME) as InventoryProxy;
      
      public function InventoryMoveItemMessageCommand()
      {
         super();
      }
      
      public static function run(message:InventoryMoveItemMessage) : void
      {
         inventoryProxy.moveItem(message.itemDefaultId,message.itemType,message.itemLevel,message.amount);
      }
   }
}

