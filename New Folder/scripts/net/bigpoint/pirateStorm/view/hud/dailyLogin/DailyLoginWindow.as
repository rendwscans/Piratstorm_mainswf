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
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import mx.binding.*;
   import mx.core.IFlexModuleFactory;
   import mx.core.IVisualElementContainer;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.graphics.SolidColor;
   import mx.styles.*;
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.gui.view.components.hud.buttons.ActionButton;
   import net.bigpoint.deprecated.gui.view.components.window.GameWindow;
   import net.bigpoint.deprecated.gui.view.components.window.HudWindow;
   import net.bigpoint.deprecated.gui.view.components.window.HudWindowTitlebar;
   import net.bigpoint.network.messages.UserReadyMessage;
   import net.bigpoint.pirateStorm.model.dailyLogin.DailyLoginBonusCardVO;
   import net.bigpoint.pirateStorm.notifications.Notice;
   import spark.components.Group;
   import spark.components.HGroup;
   import spark.components.VGroup;
   import spark.layouts.HorizontalAlign;
   import spark.primitives.Rect;
   
   use namespace mx_internal;
   
   public class DailyLoginWindow extends GameWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static const LOGIN_BONUS_TITLE:String = LocaleProxy.getText("dailybonus.title");
      
      private static const PANEL_TEXT_LOCA:String = LocaleProxy.getText("dailybonus.description");
      
      private var _1480909402acceptButton:ActionButton;
      
      private var _1081500497cardContainer:HGroup;
      
      private var _951530617content:VGroup;
      
      private var _1126995602curtain:Rect;
      
      private var _97692013frame:Group;
      
      private var _1051981609textPanel:DailyLoginTextPanel;
      
      private var _1870028133titleBar:HudWindowTitlebar;
      
      private var _787751952window:HudWindow;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _dayBonus:int;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function DailyLoginWindow()
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
         bindings = this._DailyLoginWindow_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_net_bigpoint_pirateStorm_view_hud_dailyLogin_DailyLoginWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(propertyName:String):*
         {
            return target[propertyName];
         },function(param1:String):*
         {
            return DailyLoginWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.top = 0;
         this.right = 0;
         this.bottom = 0;
         this.left = 0;
         this.mxmlContent = [this._DailyLoginWindow_Rect1_i(),this._DailyLoginWindow_Group1_i()];
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         DailyLoginWindow._watcherSetupUtil = param1;
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
      
      public function showDailyLogin(dayBonus:int) : void
      {
         this._dayBonus = dayBonus;
         dispatchEvent(new Event(DailyLoginMediator.REQUEST_DAILY_LOGIN_BONUS));
      }
      
      public function addDailyLoginBonus(dailyLoginBonusCardVOList:Vector.<DailyLoginBonusCardVO>) : void
      {
         var card:DailyLoginCard = null;
         var dailyLoginBonusCardVO:DailyLoginBonusCardVO = null;
         var i:int = 0;
         if(dailyLoginBonusCardVOList.length > 0)
         {
            for(i = 0; i < this.cardContainer.numElements; i++)
            {
               card = this.cardContainer.getElementAt(i) as DailyLoginCard;
               dailyLoginBonusCardVO = dailyLoginBonusCardVOList[i];
               card.update(dailyLoginBonusCardVO,i < this._dayBonus);
               if(i + 1 == this._dayBonus)
               {
                  card.isActive = true;
               }
               else
               {
                  card.isActive = false;
               }
            }
         }
      }
      
      override public function closeWindow() : void
      {
         UnpureFacade.getInstance().sendNotification(Notice.HARDWARE_TRACKING);
         UnpureFacade.getInstance().sendNotification(Notice.CONNECTION_SEND,new UserReadyMessage());
         if(this.parent as IVisualElementContainer != null)
         {
            IVisualElementContainer(this.parent).removeElement(this);
         }
      }
      
      private function _DailyLoginWindow_Rect1_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.top = 0;
         _loc1_.right = 0;
         _loc1_.bottom = 0;
         _loc1_.left = 0;
         _loc1_.fill = this._DailyLoginWindow_SolidColor1_c();
         _loc1_.initialized(this,"curtain");
         this.curtain = _loc1_;
         BindingManager.executeBindings(this,"curtain",this.curtain);
         return _loc1_;
      }
      
      private function _DailyLoginWindow_SolidColor1_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.color = 0;
         _loc1_.alpha = 0.5;
         return _loc1_;
      }
      
      private function _DailyLoginWindow_Group1_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.horizontalCenter = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.mxmlContent = [this._DailyLoginWindow_HudWindow1_i(),this._DailyLoginWindow_HudWindowTitlebar1_i(),this._DailyLoginWindow_VGroup1_i()];
         _loc1_.id = "frame";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.frame = _loc1_;
         BindingManager.executeBindings(this,"frame",this.frame);
         return _loc1_;
      }
      
      private function _DailyLoginWindow_HudWindow1_i() : HudWindow
      {
         var _loc1_:HudWindow = new HudWindow();
         _loc1_.id = "window";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.window = _loc1_;
         BindingManager.executeBindings(this,"window",this.window);
         return _loc1_;
      }
      
      private function _DailyLoginWindow_HudWindowTitlebar1_i() : HudWindowTitlebar
      {
         var _loc1_:HudWindowTitlebar = new HudWindowTitlebar();
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
      
      private function _DailyLoginWindow_VGroup1_i() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.top = 35;
         _loc1_.right = 14;
         _loc1_.bottom = 8;
         _loc1_.left = 14;
         _loc1_.mxmlContent = [this._DailyLoginWindow_HGroup1_i(),this._DailyLoginWindow_DailyLoginTextPanel1_i(),this._DailyLoginWindow_ActionButton1_i()];
         _loc1_.id = "content";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.content = _loc1_;
         BindingManager.executeBindings(this,"content",this.content);
         return _loc1_;
      }
      
      private function _DailyLoginWindow_HGroup1_i() : HGroup
      {
         var _loc1_:HGroup = new HGroup();
         _loc1_.gap = 1;
         _loc1_.mxmlContent = [this._DailyLoginWindow_DailyLoginCard1_c(),this._DailyLoginWindow_DailyLoginCard2_c(),this._DailyLoginWindow_DailyLoginCard3_c(),this._DailyLoginWindow_DailyLoginCard4_c(),this._DailyLoginWindow_DailyLoginCard5_c()];
         _loc1_.id = "cardContainer";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cardContainer = _loc1_;
         BindingManager.executeBindings(this,"cardContainer",this.cardContainer);
         return _loc1_;
      }
      
      private function _DailyLoginWindow_DailyLoginCard1_c() : DailyLoginCard
      {
         var _loc1_:DailyLoginCard = new DailyLoginCard();
         _loc1_.day = 1;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginWindow_DailyLoginCard2_c() : DailyLoginCard
      {
         var _loc1_:DailyLoginCard = new DailyLoginCard();
         _loc1_.day = 2;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginWindow_DailyLoginCard3_c() : DailyLoginCard
      {
         var _loc1_:DailyLoginCard = new DailyLoginCard();
         _loc1_.day = 3;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginWindow_DailyLoginCard4_c() : DailyLoginCard
      {
         var _loc1_:DailyLoginCard = new DailyLoginCard();
         _loc1_.day = 4;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginWindow_DailyLoginCard5_c() : DailyLoginCard
      {
         var _loc1_:DailyLoginCard = new DailyLoginCard();
         _loc1_.day = 5;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _DailyLoginWindow_DailyLoginTextPanel1_i() : DailyLoginTextPanel
      {
         var _loc1_:DailyLoginTextPanel = new DailyLoginTextPanel();
         _loc1_.id = "textPanel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.textPanel = _loc1_;
         BindingManager.executeBindings(this,"textPanel",this.textPanel);
         return _loc1_;
      }
      
      private function _DailyLoginWindow_ActionButton1_i() : ActionButton
      {
         var _loc1_:ActionButton = new ActionButton();
         _loc1_.localeTextKey = "button.accept";
         _loc1_.addEventListener("click",this.__acceptButton_click);
         _loc1_.id = "acceptButton";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.acceptButton = _loc1_;
         BindingManager.executeBindings(this,"acceptButton",this.acceptButton);
         return _loc1_;
      }
      
      public function __acceptButton_click(event:MouseEvent) : void
      {
         this.closeWindow();
      }
      
      private function _DailyLoginWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return frame.width;
         },null,"window.width");
         result[1] = new Binding(this,function():Number
         {
            return frame.height;
         },null,"window.height");
         result[2] = new Binding(this,function():Number
         {
            return frame.width;
         },null,"titleBar.width");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = LOGIN_BONUS_TITLE;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"titleBar.title");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = HorizontalAlign.CENTER;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"content.horizontalAlign");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = PANEL_TEXT_LOCA;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"textPanel.text");
         result[6] = new Binding(this,function():Number
         {
            return cardContainer.width - 7;
         },null,"textPanel.width");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get acceptButton() : ActionButton
      {
         return this._1480909402acceptButton;
      }
      
      public function set acceptButton(param1:ActionButton) : void
      {
         var _loc2_:Object = this._1480909402acceptButton;
         if(_loc2_ !== param1)
         {
            this._1480909402acceptButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"acceptButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cardContainer() : HGroup
      {
         return this._1081500497cardContainer;
      }
      
      public function set cardContainer(param1:HGroup) : void
      {
         var _loc2_:Object = this._1081500497cardContainer;
         if(_loc2_ !== param1)
         {
            this._1081500497cardContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cardContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get content() : VGroup
      {
         return this._951530617content;
      }
      
      public function set content(param1:VGroup) : void
      {
         var _loc2_:Object = this._951530617content;
         if(_loc2_ !== param1)
         {
            this._951530617content = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"content",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get curtain() : Rect
      {
         return this._1126995602curtain;
      }
      
      public function set curtain(param1:Rect) : void
      {
         var _loc2_:Object = this._1126995602curtain;
         if(_loc2_ !== param1)
         {
            this._1126995602curtain = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curtain",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get frame() : Group
      {
         return this._97692013frame;
      }
      
      public function set frame(param1:Group) : void
      {
         var _loc2_:Object = this._97692013frame;
         if(_loc2_ !== param1)
         {
            this._97692013frame = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"frame",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get textPanel() : DailyLoginTextPanel
      {
         return this._1051981609textPanel;
      }
      
      public function set textPanel(param1:DailyLoginTextPanel) : void
      {
         var _loc2_:Object = this._1051981609textPanel;
         if(_loc2_ !== param1)
         {
            this._1051981609textPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textPanel",_loc2_,param1));
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

