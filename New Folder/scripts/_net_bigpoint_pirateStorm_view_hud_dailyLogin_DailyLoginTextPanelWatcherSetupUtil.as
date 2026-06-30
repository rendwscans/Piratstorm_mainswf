package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   import net.bigpoint.pirateStorm.view.hud.dailyLogin.DailyLoginTextPanel;
   
   [ExcludeClass]
   public class _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginTextPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginTextPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DailyLoginTextPanel.watcherSetupUtil = new _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginTextPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}

