package net.bigpoint.pirateStorm.view.hud.dailyLogin
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
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.graphics.GradientEntry;
   import mx.graphics.LinearGradient;
   import mx.styles.*;
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.window.HudWindow;
   import net.bigpoint.deprecated.gui.view.components.window.HudWindowTitlebar;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusCardVO;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusItemVO;
   import spark.components.Group;
   import spark.components.VGroup;
   import spark.layouts.HorizontalAlign;
   import spark.primitives.Rect;
   
   use namespace mx_internal;
   
   public class DailyLoginCard extends Group implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _1332194002background:Rect;
      
      private var _1890563758itemContainer:VGroup;
      
      private var _1870028133titleBar:HudWindowTitlebar;
      
      private var _787751952window:HudWindow;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _isActive:Boolean = true;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function DailyLoginCard()
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
         bindings = this._DailyLoginCard_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginCardWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(propertyName:String):*
         {
            return target[propertyName];
         },function(param1:String):*
         {
            return DailyLoginCard[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.mxmlContent = [this._DailyLoginCard_Rect1_i(),this._DailyLoginCard_HudWindowTitlebar1_i(),this._DailyLoginCard_HudWindow1_i(),this._DailyLoginCard_VGroup1_i()];
         this.addEventListener("creationComplete",this.___DailyLoginCard_Group1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         DailyLoginCard._watcherSetupUtil = param1;
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
      
      private function onCreationComplete() : void
      {
         this.setActive();
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function set isActive(isActive:Boolean) : void
      {
         this._isActive = isActive;
         this.setActive();
      }
      
      private function setActive() : void
      {
         if(this.window != null)
         {
            this.window.isActive = this._isActive;
         }
         if(this.titleBar != null)
         {
            this.titleBar.isActive = this._isActive;
         }
      }
      
      public function set day(day:int) : void
      {
         this.titleBar.title = LocaleProxy.getText("dailybonus.day").replace(PiratesStrings.NUMBER_PATTERN,day);
      }
      
      public function update(dailyLoginBonusCardVO:DailyLoginBonusCardVO, isPicked:Boolean) : void
      {
         var i:int = 0;
         var dailyLoginItem:IDailyLoginItem = null;
         var dailyLoginBonusItemVO:DailyLoginBonusItemVO = null;
         for(i = 0; i < this.itemContainer.numElements; i++)
         {
            dailyLoginItem = this.itemContainer.getElementAt(i) as IDailyLoginItem;
            if(dailyLoginItem != null)
            {
               dailyLoginItem.visible = false;
            }
         }
         for(i = 0; i < dailyLoginBonusCardVO.itemList.length; i++)
         {
            dailyLoginBonusItemVO = dailyLoginBonusCardVO.itemList[i];
            dailyLoginItem = this.itemContainer.getElementAt(i) as IDailyLoginItem;
            if(dailyLoginBonusItemVO != null && dailyLoginItem != null)
            {
               dailyLoginItem.visible = true;
               dailyLoginItem.setItem(dailyLoginBonusItemVO,isPicked);
            }
         }
      }
      
      private function _DailyLoginCard_Rect1_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.top = 25;
         _loc1_.right = 6;
         _loc1_.bottom = 8;
         _loc1_.left = 6;
         _loc1_.radiusX = 5;
         _loc1_.radiusY = 5;
         _loc1_.rotation = 90;
         _loc1_.horizontalCenter = 0;
         _loc1_.fill = this._DailyLoginCard_LinearGradient1_c();
         _loc1_.initialized(this,"background");
         this.background = _loc1_;
         BindingManager.executeBindings(this,"background",this.background);
         return _loc1_;
      }
      
      private function _DailyLoginCard_LinearGradient1_c() : LinearGradient
      {
         var _loc1_:LinearGradient = new LinearGradient();
         _loc1_.entries = [this._DailyLoginCard_GradientEntry1_c(),this._DailyLoginCard_GradientEntry2_c()];
         return _loc1_;
      }
      
      private function _DailyLoginCard_GradientEntry1_c() : GradientEntry
      {
         var _loc1_:GradientEntry = new GradientEntry();
         _loc1_.color = 15198442;
         _loc1_.ratio = 0.7;
         return _loc1_;
      }
      
      private function _DailyLoginCard_GradientEntry2_c() : GradientEntry
      {
         var _loc1_:GradientEntry = new GradientEntry();
         _loc1_.color = 10531779;
         _loc1_.ratio = 0.8;
         return _loc1_;
      }
      
      private function _DailyLoginCard_HudWindowTitlebar1_i() : HudWindowTitlebar
      {
         var _loc1_:HudWindowTitlebar = new HudWindowTitlebar();
         _loc1_.top = 0;
         _loc1_.right = 0;
         _loc1_.bottom = 0;
         _loc1_.left = 0;
         _loc1_.titleFontSize = 12;
         _loc1_.closeable = false;
         _loc1_.titleCentered = true;
         _loc1_.id = "titleBar";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.titleBar = _loc1_;
         BindingManager.executeBindings(this,"titleBar",this.titleBar);
         return _loc1_;
      }
      
      private function _DailyLoginCard_HudWindow1_i() : HudWindow
      {
         var _loc1_:HudWindow = new HudWindow();
         _loc1_.top = 0;
         _loc1_.right = 0;
         _loc1_.bottom = 0;
         _loc1_.left = 0;
         _loc1_.withBackground = false;
         _loc1_.withGradient = false;
         _loc1_.id = "window";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.window = _loc1_;
         BindingManager.executeBindings(this,"window",this.window);
         return _loc1_;
      }
      
      private function _DailyLoginCard_VGroup1_i() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.top = 29;
         _loc1_.left = 10;
         _loc1_.right = 10;
         _loc1_.bottom = 10;
         _loc1_.gap = 2;
         _loc1_.mxmlContent = [this._DailyLoginCard_DailyLoginItemBig1_c(),this._DailyLoginCard_DailyLoginItemSmall1_c(),this._DailyLoginCard_DailyLoginItemSmall2_c()];
         _loc1_.id = "itemContainer";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.itemContainer = _loc1_;
         BindingManager.executeBindings(this,"itemContainer",this.itemContainer);
         return _loc1_;
      }
      
      private function _DailyLoginCard_DailyLoginItemBig1_c() : DailyLoginItemBig
      {
         var _loc1_:DailyLoginItemBig = new DailyLoginItemBig();
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginCard_DailyLoginItemSmall1_c() : DailyLoginItemSmall
      {
         var _loc1_:DailyLoginItemSmall = new DailyLoginItemSmall();
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginCard_DailyLoginItemSmall2_c() : DailyLoginItemSmall
      {
         var _loc1_:DailyLoginItemSmall = new DailyLoginItemSmall();
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      public function ___DailyLoginCard_Group1_creationComplete(event:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      private function _DailyLoginCard_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = HorizontalAlign.LEFT;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"itemContainer.horizontalAlign");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get background() : Rect
      {
         return this._1332194002background;
      }
      
      public function set background(param1:Rect) : void
      {
         var _loc2_:Object = this._1332194002background;
         if(_loc2_ !== param1)
         {
            this._1332194002background = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"background",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemContainer() : VGroup
      {
         return this._1890563758itemContainer;
      }
      
      public function set itemContainer(param1:VGroup) : void
      {
         var _loc2_:Object = this._1890563758itemContainer;
         if(_loc2_ !== param1)
         {
            this._1890563758itemContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleBar() : HudWindowTitlebar
      {
         return this._1870028133titleBar;
      }
      
      public function set titleBar(param1:HudWindowTitlebar) : void
      {
         var _loc2_:Object = this._1870028133titleBar;
         if(_loc2_ !== param1)
         {
            this._1870028133titleBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get window() : HudWindow
      {
         return this._787751952window;
      }
      
      public function set window(param1:HudWindow) : void
      {
         var _loc2_:Object = this._787751952window;
         if(_loc2_ !== param1)
         {
            this._787751952window = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"window",_loc2_,param1));
            }
         }
      }
   }
}

