package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   import net.bigpoint.pirateStorm.view.hud.dailyLogin.DailyLoginItemSmall;
   
   [ExcludeClass]
   public class _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemSmallWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemSmallWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DailyLoginItemSmall.watcherSetupUtil = new _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemSmallWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[3] = new PropertyWatcher("itemImage",{"propertyChange":true},[param4[3]],param2);
         param5[4] = new PropertyWatcher("width",{"propertyChange":true},[param4[3]],null);
         param5[3].updateParent(param1);
         param5[3].addChild(param5[4]);
      }
   }
}

