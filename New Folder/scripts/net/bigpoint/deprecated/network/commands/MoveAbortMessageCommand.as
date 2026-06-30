package net.bigpoint.deprecated.network.commands
{
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.gui.view.components.hud.implementation.MessageArea;
   import net.bigpoint.deprecated.gui.view.components.text.IndicatorTextFactory;
   import net.bigpoint.network.messages.MoveAbortMessage;
   
   public class MoveAbortMessageCommand
   {
      
      private static const STUNNED:int = 2;
      
      public function MoveAbortMessageCommand()
      {
         super();
      }
      
      public static function run(message:MoveAbortMessage) : void
      {
         var reason:int = message.reason;
         switch(reason)
         {
            case STUNNED:
               displayAbortMessage(AbortAttackMessageCommand.STUNNED);
               return;
            default:
               return;
         }
      }
      
      private static function displayAbortMessage(reason:int) : void
      {
         MessageArea.displayInfo(LocaleProxy.getText(AbortAttackMessageCommand.ABORT_LOCA + reason),IndicatorTextFactory.DEATH,24);
      }
   }
}

