package net.bigpoint.pirateStorm.view.hud.dailyLogin
{
   import mvcexpress.extensions.unpuremvc.patterns.mediator.UnpureMediator;
   import mvcexpress.extensions.unpuremvc.patterns.observer.UnpureNotification;
   import net.bigpoint.deprecated.game.model.WebProxy;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusCardVO;
   import net.bigpoint.pirateStorm.model.itemStats.ItemStatsEvent;
   import net.bigpoint.pirateStorm.model.itemStats.ItemStatsProxy;
   import net.bigpoint.pirateStorm.notifications.ViewNotice;
   import spark.components.Group;
   
   public class DailyLoginMediator extends UnpureMediator
   {
      
      public static const NAME:String = "DailyLoginMediator";
      
      public static const REQUEST_DAILY_LOGIN_BONUS:String = "requestDailyLoginBonus";
      
      private var view:DailyLoginWindow;
      
      private var _webProxy:WebProxy;
      
      private var _itemStatsProxy:ItemStatsProxy;
      
      public var _parent:Group;
      
      public function DailyLoginMediator(viewComponent:DailyLoginWindow)
      {
         super(NAME);
         this.view = viewComponent;
      }
      
      public function set parent(value:Group) : void
      {
         this._parent = value;
      }
      
      override protected function onRegister() : void
      {
         this._webProxy = facade.retrieveProxy(WebProxy.NAME) as WebProxy;
         this._itemStatsProxy = facade.retrieveProxy(ItemStatsProxy.NAME) as ItemStatsProxy;
         this.view.addEventListener(REQUEST_DAILY_LOGIN_BONUS,this.onRequestDailyLoginBonus);
         this.view.addEventListener(ItemStatsEvent.REQUEST_ITEM_STATS,this.onRequestItemStats);
      }
      
      override protected function onRemove() : void
      {
         this._itemStatsProxy = null;
         this.view.removeEventListener(ItemStatsEvent.REQUEST_ITEM_STATS,this.onRequestItemStats);
      }
      
      override public function listNotificationInterests() : Array
      {
         return [ViewNotice.DAILY_LOGIN_SHOW,ViewNotice.DAILY_LOGIN_ADD_BONUS];
      }
      
      override public function handleNotification(note:UnpureNotification) : void
      {
         var dailyLoginBonusCardVOList:Vector.<DailyLoginBonusCardVO> = null;
         switch(note.getName())
         {
            case ViewNotice.DAILY_LOGIN_SHOW:
               this.view.showDailyLogin(note.getBody() as int);
               break;
            case ViewNotice.DAILY_LOGIN_ADD_BONUS:
               dailyLoginBonusCardVOList = note.getBody() as Vector.<DailyLoginBonusCardVO>;
               this.view.addDailyLoginBonus(dailyLoginBonusCardVOList);
         }
      }
      
      private function onRequestDailyLoginBonus(event:String) : void
      {
         sendNotification(ViewNotice.DAILY_LOGIN_REQUEST_BONUS);
      }
      
      private function onRequestItemStats(event:ItemStatsEvent) : void
      {
         var item:IDailyLoginItem = event.target as IDailyLoginItem;
         var tooltipText:String = this._itemStatsProxy.getItemStatsWithName(event.itemType,event.itemDefaultId);
         if(tooltipText.indexOf("-[") == -1)
         {
            item.hasTooltip = true;
            item.toolTip = tooltipText;
         }
      }
   }
}

