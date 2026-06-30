package net.bigpoint.deprecated.gui.view
{
   import mvcexpress.extensions.unpuremvc.patterns.mediator.UnpureMediator;
   import mvcexpress.extensions.unpuremvc.patterns.observer.UnpureNotification;
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.gui.model.services.InfoType;
   import net.bigpoint.deprecated.gui.model.services.PiratesColors;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.hud.implementation.HealthPanel;
   import net.bigpoint.deprecated.gui.view.components.hud.implementation.MessageArea;
   import net.bigpoint.deprecated.gui.view.components.text.IndicatorTextFactory;
   import net.bigpoint.network.messages.AddBuffMessage;
   import net.bigpoint.network.messages.ChangeBuffMessage;
   import net.bigpoint.network.messages.RemoveBuffMessage;
   import net.bigpoint.pirateStorm.notifications.Notice;
   import net.bigpoint.pirateStorm.view.mainScreen.params.HudScreenSystemMessageParams;
   
   public class PlayerHealthPanelMediator extends UnpureMediator
   {
      
      public static const NAME:String = "PlayerHealthPanelMediator";
      
      private static const NEW:String = "new";
      
      private static const CHANGE:String = "change";
      
      private static const REMOVE:String = "remove";
      
      private static const BUFF:String = "buff.";
      
      private static const BUFF_NAME:String = "buff.name.";
      
      private var view:HealthPanel;
      
      public function PlayerHealthPanelMediator(viewComponent:HealthPanel)
      {
         super(NAME);
         this.view = viewComponent;
      }
      
      override protected function onRegister() : void
      {
      }
      
      override public function listNotificationInterests() : Array
      {
         return [Notice.PLAYER_HEALTH_PANEL_ADD_BUFF,Notice.PLAYER_HEALTH_PANEL_REMOVE_BUFF,Notice.PLAYER_HEALTH_PANEL_CHANGE_BUFF];
      }
      
      override public function handleNotification(note:UnpureNotification) : void
      {
         var buffAddMsg:AddBuffMessage = null;
         var buffRemoveMsg:RemoveBuffMessage = null;
         var buffChangeMsg:ChangeBuffMessage = null;
         switch(note.getName())
         {
            case Notice.PLAYER_HEALTH_PANEL_ADD_BUFF:
               buffAddMsg = note.getBody() as AddBuffMessage;
               this.displayBuff(NEW,buffAddMsg.buffId);
               this.view.buffs.addBuff(buffAddMsg.buffId,buffAddMsg.duration,buffAddMsg.graphicsId,buffAddMsg.level,buffAddMsg.positive,buffAddMsg.buffValues);
               break;
            case Notice.PLAYER_HEALTH_PANEL_REMOVE_BUFF:
               buffRemoveMsg = note.getBody() as RemoveBuffMessage;
               this.displayBuff(REMOVE,buffRemoveMsg.buffId);
               this.view.buffs.removeBuff(buffRemoveMsg.buffId);
               break;
            case Notice.PLAYER_HEALTH_PANEL_CHANGE_BUFF:
               buffChangeMsg = note.getBody() as ChangeBuffMessage;
               this.displayBuff(CHANGE,buffChangeMsg.buffId);
               this.view.buffs.changeBuff(buffChangeMsg.buffId,buffChangeMsg.duration);
         }
      }
      
      private function displayBuff(type:String, buffId:int) : void
      {
         var buffName:String = this.getBuffName(buffId);
         var buffMessage:String = LocaleProxy.getText(BUFF + type) + PiratesStrings.SPACE + buffName;
         facade.sendNotification(Notice.HUD_SCREEN_SYSTEM_MESSAGE,new HudScreenSystemMessageParams(buffMessage,PiratesColors.COLOR_ABSTRACT,InfoType.INFO_BUFF));
         MessageArea.displayInfo(buffMessage,IndicatorTextFactory.DEATH,24);
      }
      
      private function getBuffName(buffId:int) : String
      {
         return LocaleProxy.getText(BUFF_NAME + buffId);
      }
   }
}

