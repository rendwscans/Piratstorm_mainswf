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
   import mx.styles.*;
   import net.bigpoint.deprecated.gui.model.services.IconHelper;
   import net.bigpoint.deprecated.gui.model.services.LayoutHelper;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.text.DefaultNumberFormatter;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusItemVO;
   import net.bigpoint.pirateStorm.model.itemStats.ItemStatsEvent;
   import spark.components.Group;
   import spark.components.Label;
   import spark.primitives.BitmapImage;
   
   use namespace mx_internal;
   
   public class DailyLoginItemBig extends Group implements IBindingClient, IDailyLoginItem
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public var _DailyLoginItemBig_BitmapImage2:BitmapImage;
      
      private var _3208483hook:BitmapImage;
      
      private var _1478417739itemAmount:Label;
      
      private var _2133275144itemImage:BitmapImage;
      
      private var _1903793523itemPicked:Group;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _itemType:int;
      
      private var _itemId:int;
      
      private var _hasTooltip:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function DailyLoginItemBig()
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
         bindings = this._DailyLoginItemBig_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginItemBigWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(propertyName:String):*
         {
            return target[propertyName];
         },function(param1:String):*
         {
            return DailyLoginItemBig[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.mxmlContent = [this._DailyLoginItemBig_BitmapImage1_i(),this._DailyLoginItemBig_Group2_i(),this._DailyLoginItemBig_Label1_i()];
         this.addEventListener("mouseOver",this.___DailyLoginItemBig_Group1_mouseOver);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         DailyLoginItemBig._watcherSetupUtil = param1;
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
      
      public function setItem(dailyLoginBonusItemVO:DailyLoginBonusItemVO, isPicked:Boolean) : void
      {
         this._itemType = dailyLoginBonusItemVO.itemType;
         this._itemId = dailyLoginBonusItemVO.itemId;
         this.itemPicked.visible = isPicked;
         IconHelper.loadGenericImageById(this._itemType,this._itemId,IconHelper.SIZE_111x65,this.setIcon);
         this.itemAmount.text = PiratesStrings.MULTIPLY + PiratesStrings.SPACE + DefaultNumberFormatter.format(dailyLoginBonusItemVO.amount);
      }
      
      public function setIcon(url:String, image:Bitmap) : void
      {
         this.itemImage.source = image;
      }
      
      public function get itemType() : int
      {
         return this._itemType;
      }
      
      public function get itemId() : int
      {
         return this._itemId;
      }
      
      public function get hasTooltip() : Boolean
      {
         return this._hasTooltip;
      }
      
      public function set hasTooltip(hasTooltip:Boolean) : void
      {
         this._hasTooltip = hasTooltip;
      }
      
      private function onMouseOver() : void
      {
         if(!this.hasTooltip)
         {
            dispatchEvent(new ItemStatsEvent(ItemStatsEvent.REQUEST_ITEM_STATS,this._itemType,this._itemId,null,true));
         }
      }
      
      private function _DailyLoginItemBig_BitmapImage1_i() : BitmapImage
      {
         var _loc1_:BitmapImage = new BitmapImage();
         _loc1_.top = 0;
         _loc1_.bottom = 18;
         _loc1_.width = 111;
         _loc1_.height = 65;
         _loc1_.horizontalCenter = 0;
         _loc1_.initialized(this,"itemImage");
         this.itemImage = _loc1_;
         BindingManager.executeBindings(this,"itemImage",this.itemImage);
         return _loc1_;
      }
      
      private function _DailyLoginItemBig_Group2_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.bottom = 10;
         _loc1_.right = 0;
         _loc1_.mxmlContent = [this._DailyLoginItemBig_BitmapImage2_i(),this._DailyLoginItemBig_BitmapImage3_i()];
         _loc1_.id = "itemPicked";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.itemPicked = _loc1_;
         BindingManager.executeBindings(this,"itemPicked",this.itemPicked);
         return _loc1_;
      }
      
      private function _DailyLoginItemBig_BitmapImage2_i() : BitmapImage
      {
         var _loc1_:BitmapImage = new BitmapImage();
         _loc1_.horizontalCenter = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.initialized(this,"_DailyLoginItemBig_BitmapImage2");
         this._DailyLoginItemBig_BitmapImage2 = _loc1_;
         BindingManager.executeBindings(this,"_DailyLoginItemBig_BitmapImage2",this._DailyLoginItemBig_BitmapImage2);
         return _loc1_;
      }
      
      private function _DailyLoginItemBig_BitmapImage3_i() : BitmapImage
      {
         var _loc1_:BitmapImage = new BitmapImage();
         _loc1_.horizontalCenter = 0;
         _loc1_.verticalCenter = -2;
         _loc1_.initialized(this,"hook");
         this.hook = _loc1_;
         BindingManager.executeBindings(this,"hook",this.hook);
         return _loc1_;
      }
      
      private function _DailyLoginItemBig_Label1_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.bottom = 0;
         _loc1_.horizontalCenter = 0;
         _loc1_.id = "itemAmount";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.itemAmount = _loc1_;
         BindingManager.executeBindings(this,"itemAmount",this.itemAmount);
         return _loc1_;
      }
      
      public function ___DailyLoginItemBig_Group1_mouseOver(event:MouseEvent) : void
      {
         this.onMouseOver();
      }
      
      private function _DailyLoginItemBig_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return LayoutHelper.SCALE_X;
         },null,"itemImage.scaleX");
         result[1] = new Binding(this,function():Number
         {
            return LayoutHelper.calculateTransformXOffset(itemImage.width);
         },null,"itemImage.transformX");
         result[2] = new Binding(this,function():Object
         {
            return HUDIMAGE_button_default_small;
         },null,"_DailyLoginItemBig_BitmapImage2.source");
         result[3] = new Binding(this,function():Object
         {
            return HUDIMAGE_button_hook;
         },null,"hook.source");
         result[4] = new Binding(this,function():Number
         {
            return LayoutHelper.SCALE_X;
         },null,"hook.scaleX");
         result[5] = new Binding(this,function():Number
         {
            return LayoutHelper.calculateTransformXOffset(hook.width);
         },null,"hook.transformX");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get hook() : BitmapImage
      {
         return this._3208483hook;
      }
      
      public function set hook(param1:BitmapImage) : void
      {
         var _loc2_:Object = this._3208483hook;
         if(_loc2_ !== param1)
         {
            this._3208483hook = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hook",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemAmount() : Label
      {
         return this._1478417739itemAmount;
      }
      
      public function set itemAmount(param1:Label) : void
      {
         var _loc2_:Object = this._1478417739itemAmount;
         if(_loc2_ !== param1)
         {
            this._1478417739itemAmount = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemAmount",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemImage() : BitmapImage
      {
         return this._2133275144itemImage;
      }
      
      public function set itemImage(param1:BitmapImage) : void
      {
         var _loc2_:Object = this._2133275144itemImage;
         if(_loc2_ !== param1)
         {
            this._2133275144itemImage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemImage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemPicked() : Group
      {
         return this._1903793523itemPicked;
      }
      
      public function set itemPicked(param1:Group) : void
      {
         var _loc2_:Object = this._1903793523itemPicked;
         if(_loc2_ !== param1)
         {
            this._1903793523itemPicked = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemPicked",_loc2_,param1));
            }
         }
      }
   }
}

