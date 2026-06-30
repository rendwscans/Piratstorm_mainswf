package net.bigpoint.pirateStorm.view.hud.dailyLogin
{
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusItemVO;
   
   public interface IDailyLoginItem
   {
      
      function setItem(param1:DailyLoginBonusItemVO, param2:Boolean) : void;
      
      function set visible(param1:Boolean) : void;
      
      function get itemType() : int;
      
      function get itemId() : int;
      
      function get hasTooltip() : Boolean;
      
      function set hasTooltip(param1:Boolean) : void;
      
      function set toolTip(param1:String) : void;
   }
}

