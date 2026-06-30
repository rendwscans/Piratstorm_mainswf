package net.bigpoint.pirateStorm.model.dailyLogin
{
   public class DailyLoginBonusItemVO
   {
      
      private var _itemType:int;
      
      private var _itemId:int;
      
      private var _amount:int;
      
      public function DailyLoginBonusItemVO(itemType:int, itemId:int, amount:int)
      {
         super();
         this._itemType = itemType;
         this._itemId = itemId;
         this._amount = amount;
      }
      
      public function get itemType() : int
      {
         return this._itemType;
      }
      
      public function get itemId() : int
      {
         return this._itemId;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}

