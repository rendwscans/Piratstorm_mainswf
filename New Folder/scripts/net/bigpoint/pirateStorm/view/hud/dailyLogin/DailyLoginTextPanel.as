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
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.graphics.GradientEntry;
   import mx.graphics.LinearGradient;
   import mx.graphics.SolidColor;
   import mx.graphics.SolidColorStroke;
   import mx.styles.*;
   import net.bigpoint.deprecated.gui.model.services.PiratesColors;
   import spark.components.Group;
   import spark.components.Label;
   import spark.primitives.Rect;
   
   use namespace mx_internal;
   
   public class DailyLoginTextPanel extends Group implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public var _DailyLoginTextPanel_GradientEntry1:GradientEntry;
      
      public var _DailyLoginTextPanel_GradientEntry2:GradientEntry;
      
      public var _DailyLoginTextPanel_GradientEntry3:GradientEntry;
      
      public var _DailyLoginTextPanel_SolidColor1:SolidColor;
      
      public var _DailyLoginTextPanel_SolidColorStroke1:SolidColorStroke;
      
      private var _1055687225textLabel:Label;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function DailyLoginTextPanel()
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
         bindings = this._DailyLoginTextPanel_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginTextPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(propertyName:String):*
         {
            return target[propertyName];
         },function(param1:String):*
         {
            return DailyLoginTextPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.mxmlContent = [this._DailyLoginTextPanel_Rect1_c(),this._DailyLoginTextPanel_Rect2_c(),this._DailyLoginTextPanel_Label1_i()];
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         DailyLoginTextPanel._watcherSetupUtil = param1;
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
      
      public function set text(panelText:String) : void
      {
         this.textLabel.text = panelText;
      }
      
      private function _DailyLoginTextPanel_Rect1_c() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.top = 0;
         _loc1_.right = 0;
         _loc1_.bottom = 0;
         _loc1_.left = 0;
         _loc1_.radiusX = 4;
         _loc1_.radiusY = 4;
         _loc1_.fill = this._DailyLoginTextPanel_SolidColor1_i();
         _loc1_.initialized(this,null);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_SolidColor1_i() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         this._DailyLoginTextPanel_SolidColor1 = _loc1_;
         BindingManager.executeBindings(this,"_DailyLoginTextPanel_SolidColor1",this._DailyLoginTextPanel_SolidColor1);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_Rect2_c() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.top = 1;
         _loc1_.right = 1;
         _loc1_.bottom = 1;
         _loc1_.left = 1;
         _loc1_.radiusX = 4;
         _loc1_.radiusY = 4;
         _loc1_.stroke = this._DailyLoginTextPanel_SolidColorStroke1_i();
         _loc1_.fill = this._DailyLoginTextPanel_LinearGradient1_c();
         _loc1_.initialized(this,null);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_SolidColorStroke1_i() : SolidColorStroke
      {
         var _loc1_:SolidColorStroke = new SolidColorStroke();
         _loc1_.weight = 1;
         this._DailyLoginTextPanel_SolidColorStroke1 = _loc1_;
         BindingManager.executeBindings(this,"_DailyLoginTextPanel_SolidColorStroke1",this._DailyLoginTextPanel_SolidColorStroke1);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_LinearGradient1_c() : LinearGradient
      {
         var _loc1_:LinearGradient = new LinearGradient();
         _loc1_.rotation = 90;
         _loc1_.entries = [this._DailyLoginTextPanel_GradientEntry1_i(),this._DailyLoginTextPanel_GradientEntry2_i(),this._DailyLoginTextPanel_GradientEntry3_i()];
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_GradientEntry1_i() : GradientEntry
      {
         var _loc1_:GradientEntry = new GradientEntry();
         this._DailyLoginTextPanel_GradientEntry1 = _loc1_;
         BindingManager.executeBindings(this,"_DailyLoginTextPanel_GradientEntry1",this._DailyLoginTextPanel_GradientEntry1);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_GradientEntry2_i() : GradientEntry
      {
         var _loc1_:GradientEntry = new GradientEntry();
         _loc1_.ratio = 0.7;
         this._DailyLoginTextPanel_GradientEntry2 = _loc1_;
         BindingManager.executeBindings(this,"_DailyLoginTextPanel_GradientEntry2",this._DailyLoginTextPanel_GradientEntry2);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_GradientEntry3_i() : GradientEntry
      {
         var _loc1_:GradientEntry = new GradientEntry();
         _loc1_.ratio = 1;
         this._DailyLoginTextPanel_GradientEntry3 = _loc1_;
         BindingManager.executeBindings(this,"_DailyLoginTextPanel_GradientEntry3",this._DailyLoginTextPanel_GradientEntry3);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_Label1_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.top = 10;
         _loc1_.right = 20;
         _loc1_.bottom = 6;
         _loc1_.left = 20;
         _loc1_.id = "textLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.textLabel = _loc1_;
         BindingManager.executeBindings(this,"textLabel",this.textLabel);
         return _loc1_;
      }
      
      private function _DailyLoginTextPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():uint
         {
            return PiratesColors.WHITE;
         },null,"_DailyLoginTextPanel_SolidColor1.color");
         result[1] = new Binding(this,function():uint
         {
            return PiratesColors.InventoryItemStroke;
         },null,"_DailyLoginTextPanel_SolidColorStroke1.color");
         result[2] = new Binding(this,function():uint
         {
            return PiratesColors.PlateBGFromColor;
         },null,"_DailyLoginTextPanel_GradientEntry1.color");
         result[3] = new Binding(this,function():uint
         {
            return PiratesColors.PlateBGMiddleColor;
         },null,"_DailyLoginTextPanel_GradientEntry2.color");
         result[4] = new Binding(this,function():uint
         {
            return PiratesColors.PlateBGToColor;
         },null,"_DailyLoginTextPanel_GradientEntry3.color");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get textLabel() : Label
      {
         return this._1055687225textLabel;
      }
      
      public function set textLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1055687225textLabel;
         if(_loc2_ !== param1)
         {
            this._1055687225textLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textLabel",_loc2_,param1));
            }
         }
      }
   }
}

