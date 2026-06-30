package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   import net.bigpoint.pirateStorm.view.hud.dailyLogin.DailyLoginItemBig;
   
   [ExcludeClass]
   public class _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemBigWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemBigWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DailyLoginItemBig.watcherSetupUtil = new _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemBigWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[5] = new PropertyWatcher("hook",{"propertyChange":true},[param4[5]],param2);
         param5[6] = new PropertyWatcher("width",{"propertyChange":true},[param4[5]],null);
         param5[2] = new PropertyWatcher("itemImage",{"propertyChange":true},[param4[1]],param2);
         param5[3] = new PropertyWatcher("width",{"propertyChange":true},[param4[1]],null);
         param5[5].updateParent(param1);
         param5[5].addChild(param5[6]);
         param5[2].updateParent(param1);
         param5[2].addChild(param5[3]);
      }
   }
}

