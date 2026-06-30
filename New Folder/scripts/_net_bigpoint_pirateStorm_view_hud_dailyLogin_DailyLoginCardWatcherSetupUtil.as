package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   import net.bigpoint.pirateStorm.view.hud.dailyLogin.DailyLoginCard;
   
   [ExcludeClass]
   public class _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginCardWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginCardWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DailyLoginCard.watcherSetupUtil = new _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginCardWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}

