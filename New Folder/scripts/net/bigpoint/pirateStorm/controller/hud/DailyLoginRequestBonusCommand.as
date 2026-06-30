package net.bigpoint.pirateStorm.controller.hud
{
   import mvcexpress.extensions.unpuremvc.patterns.command.UnpureSimpleCommand;
   import mvcexpress.extensions.unpuremvc.patterns.observer.UnpureNotification;
   import net.bigpoint.deprecated.game.model.WebProxy;
   import net.bigpoint.deprecated.gui.model.services.json.JsonRequestIn;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusCardVO;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusItemVO;
   import net.bigpoint.pirateStorm.model.itemStats.ItemStatRequestParamVO;
   import net.bigpoint.pirateStorm.model.itemStats.ItemStatsListRequestParamVO;
   import net.bigpoint.pirateStorm.model.itemStats.ItemStatsProxy;
   import net.bigpoint.pirateStorm.notifications.ViewNotice;
   
   public class DailyLoginRequestBonusCommand extends UnpureSimpleCommand
   {
      
      public function DailyLoginRequestBonusCommand()
      {
         super();
      }
      
      override public function execute(notice:UnpureNotification) : void
      {
         var webProxy:WebProxy = facade.retrieveProxy(WebProxy.NAME) as WebProxy;
         webProxy.getDailyLoginBonus(this.onReceiveDailyLoginBonus);
      }
      
      private function onReceiveDailyLoginBonus(request:JsonRequestIn) : void
      {
         var itemType:int = 0;
         var itemId:int = 0;
         var itemAmount:int = 0;
         var itemStatsListRequestParamVO:ItemStatsListRequestParamVO = null;
         var dailyLoginBonusCardVOList:Vector.<DailyLoginBonusCardVO> = null;
         var dailyLoginBonusCardVO:DailyLoginBonusCardVO = null;
         var cardData:Object = null;
         var itemStatsProxy:ItemStatsProxy = null;
         var itemData:Object = null;
         var data:Object = request.data["result"]["bonus"];
         if(data != null)
         {
            itemStatsListRequestParamVO = new ItemStatsListRequestParamVO();
            dailyLoginBonusCardVOList = new Vector.<DailyLoginBonusCardVO>();
            for each(cardData in data)
            {
               dailyLoginBonusCardVO = new DailyLoginBonusCardVO();
               for each(itemData in cardData)
               {
                  itemType = parseInt(itemData["itemtype"]);
                  itemId = parseInt(itemData["id"]);
                  itemAmount = parseInt(itemData["amount"]);
                  itemStatsListRequestParamVO.addItemStatRequest(new ItemStatRequestParamVO(itemType,itemId));
                  dailyLoginBonusCardVO.addItem(new DailyLoginBonusItemVO(itemType,itemId,itemAmount));
               }
               dailyLoginBonusCardVOList.push(dailyLoginBonusCardVO);
            }
            itemStatsProxy = facade.retrieveProxy(ItemStatsProxy.NAME) as ItemStatsProxy;
            itemStatsProxy.loadItemStats(itemStatsListRequestParamVO);
            sendNotification(ViewNotice.DAILY_LOGIN_ADD_BONUS,dailyLoginBonusCardVOList);
         }
      }
   }
}

