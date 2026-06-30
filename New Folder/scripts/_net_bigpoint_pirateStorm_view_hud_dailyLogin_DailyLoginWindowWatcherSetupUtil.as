package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   import net.bigpoint.pirateStorm.view.hud.dailyLogin.DailyLoginWindow;
   
   [ExcludeClass]
   public class _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DailyLoginWindow.watcherSetupUtil = new _net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[6] = new PropertyWatcher("cardContainer",{"propertyChange":true},[param4[6]],param2);
         param5[7] = new PropertyWatcher("width",{"widthChanged":true},[param4[6]],null);
         param5[0] = new PropertyWatcher("frame",{"propertyChange":true},[param4[0],param4[1],param4[2]],param2);
         param5[1] = new PropertyWatcher("width",{"widthChanged":true},[param4[0],param4[2]],null);
         param5[2] = new PropertyWatcher("height",{"heightChanged":true},[param4[1]],null);
         param5[6].updateParent(param1);
         param5[6].addChild(param5[7]);
         param5[0].updateParent(param1);
         param5[0].addChild(param5[1]);
         param5[0].addChild(param5[2]);
      }
   }
}

