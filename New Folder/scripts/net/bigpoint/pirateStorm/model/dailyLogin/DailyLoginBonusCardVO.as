package net.bigpoint.pirateStorm.model.dailyLogin
{
   public class DailyLoginBonusCardVO
   {
      
      private var _itemList:Vector.<DailyLoginBonusItemVO>;
      
      public function DailyLoginBonusCardVO()
      {
         super();
         this._itemList = new Vector.<DailyLoginBonusItemVO>();
      }
      
      public function addItem(item:DailyLoginBonusItemVO) : void
      {
         this._itemList.push(item);
      }
      
      public function get itemList() : Vector.<DailyLoginBonusItemVO>
      {
         return this._itemList;
      }
   }
}

