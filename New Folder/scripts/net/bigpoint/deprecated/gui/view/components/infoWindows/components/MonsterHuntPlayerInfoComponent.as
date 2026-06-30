package net.bigpoint.deprecated.gui.view.components.infoWindows.components
{
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.FontWeight;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import flashx.textLayout.formats.TextAlign;
   import mx.binding.*;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.gui.model.services.IconHelper;
   import net.bigpoint.deprecated.gui.model.services.LayoutHelper;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.hud.buttons.StaticRoundedButton;
   import spark.components.Group;
   import spark.components.HGroup;
   import spark.components.Label;
   import spark.components.VGroup;
   import spark.layouts.HorizontalAlign;
   import spark.primitives.BitmapImage;
   
   use namespace mx_internal;
   
   public class MonsterHuntPlayerInfoComponent extends InfoContentComponent implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static const PLAYER_AVATAR_URL:String = "avatar/player";
      
      private static const WINNER_L10N:String = LocaleProxy.getText("monsterHunt.winner");
      
      private static const RUNNER_UP_L10N:String = LocaleProxy.getText("monsterHunt.runnerUp");
      
      private static const YOUR_RESULTS_L10N:String = LocaleProxy.getText("monsterHunt.yourResult");
      
      private static const RANK_L10N:String = LocaleProxy.getText("monsterHunt.rank") + PiratesStrings.SPACE;
      
      private static const MONSTERS_KILLED_L10N:String = LocaleProxy.getText("monsterHunt.monstersKilled") + PiratesStrings.COLON_SPACE;
      
      public var _MonsterHuntPlayerInfoComponent_HGroup1:HGroup;
      
      public var _MonsterHuntPlayerInfoComponent_VGroup1:VGroup;
      
      private var _3226745icon:StaticRoundedButton;
      
      private var _1947377397itemCounterLabel:Label;
      
      private var _777691818itemNameLabel:Label;
      
      private var _836173551itemTitleLabel:Label;
      
      private var _1032244676laurelWreath:BitmapImage;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MonsterHuntPlayerInfoComponent()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._MonsterHuntPlayerInfoComponent_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_net_bigpoint_deprecated_gui_view_components_infoWindows_components_MonsterHuntPlayerInfoComponentWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(propertyName:String):*
         {
            return target[propertyName];
         },function(param1:String):*
         {
            return MonsterHuntPlayerInfoComponent[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 260;
         this.height = 60;
         this.mxmlContent = [this._MonsterHuntPlayerInfoComponent_HGroup1_i()];
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MonsterHuntPlayerInfoComponent._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function addIcon(url:String, image:Bitmap) : void
      {
         this.icon.iconImage = image;
      }
      
      public function renderItem(name:String, avatarId:int, killCount:int, rank:int, isWinner:Boolean, isRunnerUp:Boolean) : void
      {
         IconHelper.loadGenericImageByCategory(PLAYER_AVATAR_URL,avatarId,IconHelper.SIZE_SMALL_44x44,this.addIcon);
         this.laurelWreath.visible = isWinner;
         if(isWinner)
         {
            this.itemTitleLabel.text = WINNER_L10N;
         }
         else if(isRunnerUp)
         {
            this.itemTitleLabel.text = RUNNER_UP_L10N;
         }
         else
         {
            this.itemTitleLabel.text = YOUR_RESULTS_L10N;
         }
         this.itemNameLabel.text = (isWinner ? "" : RANK_L10N + rank + PiratesStrings.COLON_SPACE) + name;
         this.itemCounterLabel.text = MONSTERS_KILLED_L10N + killCount;
         toolTip = null;
         hasToolTip = true;
      }
      
      override protected function handleMouseOver(event:MouseEvent) : void
      {
      }
      
      private function _MonsterHuntPlayerInfoComponent_HGroup1_i() : HGroup
      {
         var _loc1_:HGroup = new HGroup();
         _loc1_.top = 0;
         _loc1_.left = 0;
         _loc1_.gap = 20;
         _loc1_.mxmlContent = [this._MonsterHuntPlayerInfoComponent_Group1_c(),this._MonsterHuntPlayerInfoComponent_VGroup1_i()];
         _loc1_.id = "_MonsterHuntPlayerInfoComponent_HGroup1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._MonsterHuntPlayerInfoComponent_HGroup1 = _loc1_;
         BindingManager.executeBindings(this,"_MonsterHuntPlayerInfoComponent_HGroup1",this._MonsterHuntPlayerInfoComponent_HGroup1);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_Group1_c() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.verticalCenter = 0;
         _loc1_.mxmlContent = [this._MonsterHuntPlayerInfoComponent_BitmapImage1_i(),this._MonsterHuntPlayerInfoComponent_StaticRoundedButton1_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_BitmapImage1_i() : BitmapImage
      {
         var _loc1_:BitmapImage = new BitmapImage();
         _loc1_.horizontalCenter = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.initialized(this,"laurelWreath");
         this.laurelWreath = _loc1_;
         BindingManager.executeBindings(this,"laurelWreath",this.laurelWreath);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_StaticRoundedButton1_i() : StaticRoundedButton
      {
         var _loc1_:StaticRoundedButton = new StaticRoundedButton();
         _loc1_.horizontalCenter = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.id = "icon";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.icon = _loc1_;
         BindingManager.executeBindings(this,"icon",this.icon);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_VGroup1_i() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.maxWidth = 170;
         _loc1_.verticalCenter = 0;
         _loc1_.mxmlContent = [this._MonsterHuntPlayerInfoComponent_Label1_i(),this._MonsterHuntPlayerInfoComponent_Label2_i(),this._MonsterHuntPlayerInfoComponent_Label3_i()];
         _loc1_.id = "_MonsterHuntPlayerInfoComponent_VGroup1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._MonsterHuntPlayerInfoComponent_VGroup1 = _loc1_;
         BindingManager.executeBindings(this,"_MonsterHuntPlayerInfoComponent_VGroup1",this._MonsterHuntPlayerInfoComponent_VGroup1);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_Label1_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 60;
         _loc1_.right = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.maxWidth = 170;
         _loc1_.minWidth = 170;
         _loc1_.setStyle("fontSize",14);
         _loc1_.id = "itemTitleLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.itemTitleLabel = _loc1_;
         BindingManager.executeBindings(this,"itemTitleLabel",this.itemTitleLabel);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_Label2_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 60;
         _loc1_.right = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.maxWidth = 170;
         _loc1_.showTruncationTip = true;
         _loc1_.id = "itemNameLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.itemNameLabel = _loc1_;
         BindingManager.executeBindings(this,"itemNameLabel",this.itemNameLabel);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_Label3_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 60;
         _loc1_.right = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.maxWidth = 170;
         _loc1_.id = "itemCounterLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.itemCounterLabel = _loc1_;
         BindingManager.executeBindings(this,"itemCounterLabel",this.itemCounterLabel);
         return _loc1_;
      }
      
      private function _MonsterHuntPlayerInfoComponent_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = HorizontalAlign.CENTER;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MonsterHuntPlayerInfoComponent_HGroup1.horizontalAlign");
         result[1] = new Binding(this,function():Object
         {
            return HUDIMAGE_deko_laurel_ring_small;
         },null,"laurelWreath.source");
         result[2] = new Binding(this,function():Number
         {
            return LayoutHelper.SCALE_X;
         },null,"icon.scaleX");
         result[3] = new Binding(this,function():Number
         {
            return LayoutHelper.calculateTransformXOffset(icon.width);
         },null,"icon.transformX");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = HorizontalAlign.CENTER;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MonsterHuntPlayerInfoComponent_VGroup1.horizontalAlign");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = LayoutHelper.DIRECTION;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemTitleLabel.setStyle("direction",param1);
         },"itemTitleLabel.direction");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = FontWeight.BOLD;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemTitleLabel.setStyle("fontWeight",param1);
         },"itemTitleLabel.fontWeight");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = TextAlign.CENTER;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemTitleLabel.setStyle("textAlign",param1);
         },"itemTitleLabel.textAlign");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = LayoutHelper.DIRECTION;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemNameLabel.setStyle("direction",param1);
         },"itemNameLabel.direction");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = TextAlign.CENTER;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemNameLabel.setStyle("textAlign",param1);
         },"itemNameLabel.textAlign");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = LayoutHelper.DIRECTION;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemCounterLabel.setStyle("direction",param1);
         },"itemCounterLabel.direction");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = TextAlign.CENTER;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            itemCounterLabel.setStyle("textAlign",param1);
         },"itemCounterLabel.textAlign");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get icon() : StaticRoundedButton
      {
         return this._3226745icon;
      }
      
      public function set icon(param1:StaticRoundedButton) : void
      {
         var _loc2_:Object = this._3226745icon;
         if(_loc2_ !== param1)
         {
            this._3226745icon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"icon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemCounterLabel() : Label
      {
         return this._1947377397itemCounterLabel;
      }
      
      public function set itemCounterLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1947377397itemCounterLabel;
         if(_loc2_ !== param1)
         {
            this._1947377397itemCounterLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemCounterLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemNameLabel() : Label
      {
         return this._777691818itemNameLabel;
      }
      
      public function set itemNameLabel(param1:Label) : void
      {
         var _loc2_:Object = this._777691818itemNameLabel;
         if(_loc2_ !== param1)
         {
            this._777691818itemNameLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemNameLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemTitleLabel() : Label
      {
         return this._836173551itemTitleLabel;
      }
      
      public function set itemTitleLabel(param1:Label) : void
      {
         var _loc2_:Object = this._836173551itemTitleLabel;
         if(_loc2_ !== param1)
         {
            this._836173551itemTitleLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemTitleLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get laurelWreath() : BitmapImage
      {
         return this._1032244676laurelWreath;
      }
      
      public function set laurelWreath(param1:BitmapImage) : void
      {
         var _loc2_:Object = this._1032244676laurelWreath;
         if(_loc2_ !== param1)
         {
            this._1032244676laurelWreath = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"laurelWreath",_loc2_,param1));
            }
         }
      }
   }
}

