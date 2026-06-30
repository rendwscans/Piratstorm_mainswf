package net.bigpoint.deprecated.gui.view.components.window.profile
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
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   import net.bigpoint.deprecated.game.controller.game.profile.ranking.RankingRequestCommand;
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.gui.model.services.ImageFromWeb;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.hud.textcomponents.LocalizedLabel;
   import net.bigpoint.deprecated.gui.view.components.window.common.InnerWindowFrame;
   import spark.components.Group;
   import spark.components.Label;
   import spark.components.VGroup;
   import spark.primitives.BitmapImage;
   
   public class PlayerDetails extends Group
   {
      
      private static const RANK_ALL_TIME:String = "profile.ranking.rank.alltime.";
      
      private static const RANK_SEASON:String = "profile.ranking.rank.season.";
      
      private static const RANK_ALL_TIME_IMAGE:String = "img/icons/rank/big/" + PiratesStrings.VALUE_PATTERN_UPPERCASE + ".png";
      
      private static const RANK_SEASON_IMAGE:String = "img/icons/rank_season/big/" + PiratesStrings.VALUE_PATTERN_UPPERCASE + ".png";
      
      private var _744859681lastloginLabel:Label;
      
      private var _188974544levelLabel:Label;
      
      private var _1044040155rankAllTimeIcon:BitmapImage;
      
      private var _1991795246rankAllTimeLabel:Label;
      
      private var _343790408rankSeasonIcon:BitmapImage;
      
      private var _2070266373rankSeasonLabel:Label;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function PlayerDetails()
      {
         super();
         mx_internal::_document = this;
         this.mxmlContent = [this._PlayerDetails_InnerWindowFrame1_c(),this._PlayerDetails_VGroup1_c()];
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.fontWeight = "bold";
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      public function updateLastLogin(date:String) : void
      {
         this.lastloginLabel.text = date;
      }
      
      public function updateValues(level:int, eliteLevel:int, skills:int, rankAllTime:int, rankSeason:int, pirateSinceDate:String) : void
      {
         this.levelLabel.text = String(level);
         this.setAllTimeRank(rankAllTime);
         this.setSeasonRank(rankSeason);
      }
      
      private function setAllTimeRank(rankValue:int) : void
      {
         if(rankValue == RankingRequestCommand.MIN_NO_RANK_VALUE || rankValue == RankingRequestCommand.MAX_NO_RANK_VALUE)
         {
            this.rankAllTimeLabel.text = PiratesStrings.MINUS;
            rankValue = 0;
         }
         else
         {
            this.rankAllTimeLabel.text = LocaleProxy.getText(RANK_ALL_TIME + rankValue);
         }
         this.rankAllTimeIcon.source = null;
         ImageFromWeb.getImage(RANK_ALL_TIME_IMAGE.replace(PiratesStrings.VALUE_PATTERN_UPPERCASE,rankValue),this.addAllTimeRankIcon);
      }
      
      private function setSeasonRank(rankValue:int) : void
      {
         if(rankValue == RankingRequestCommand.MIN_NO_RANK_VALUE || rankValue == RankingRequestCommand.MAX_NO_RANK_VALUE)
         {
            rankValue = 0;
            this.rankSeasonLabel.text = PiratesStrings.MINUS;
         }
         else
         {
            this.rankSeasonLabel.text = LocaleProxy.getText(RANK_SEASON + rankValue);
         }
         ImageFromWeb.getImage(RANK_SEASON_IMAGE.replace(PiratesStrings.VALUE_PATTERN_UPPERCASE,rankValue),this.addSeasonRankIcon);
      }
      
      private function addAllTimeRankIcon(url:String, image:Bitmap) : void
      {
         this.rankAllTimeIcon.source = image;
      }
      
      private function addSeasonRankIcon(url:String, image:Bitmap) : void
      {
         this.rankSeasonIcon.source = image;
      }
      
      public function updateXP(current:int, max:int) : void
      {
      }
      
      public function updateEliteLevel(current:int, max:int) : void
      {
      }
      
      private function _PlayerDetails_InnerWindowFrame1_c() : InnerWindowFrame
      {
         var _loc1_:InnerWindowFrame = new InnerWindowFrame();
         _loc1_.top = 5;
         _loc1_.right = 5;
         _loc1_.bottom = 5;
         _loc1_.left = 5;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_VGroup1_c() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.top = 13;
         _loc1_.gap = 5;
         _loc1_.left = 15;
         _loc1_.mxmlContent = [this._PlayerDetails_Group2_c(),this._PlayerDetails_Group3_c(),this._PlayerDetails_Group4_c(),this._PlayerDetails_Group5_c()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_Group2_c() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.width = 270;
         _loc1_.mxmlContent = [this._PlayerDetails_LocalizedLabel1_c(),this._PlayerDetails_Label1_i(),this._PlayerDetails_BitmapImage1_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_LocalizedLabel1_c() : LocalizedLabel
      {
         var _loc1_:LocalizedLabel = null;
         _loc1_ = new LocalizedLabel();
         _loc1_.useAsLabel = true;
         _loc1_.localeTextKey = "profile.rankSeason";
         _loc1_.width = 130;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.y = 7;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_Label1_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 85;
         _loc1_.width = 140;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.y = 7;
         _loc1_.id = "rankSeasonLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.rankSeasonLabel = _loc1_;
         BindingManager.executeBindings(this,"rankSeasonLabel",this.rankSeasonLabel);
         return _loc1_;
      }
      
      private function _PlayerDetails_BitmapImage1_i() : BitmapImage
      {
         var _loc1_:BitmapImage = new BitmapImage();
         _loc1_.left = 180;
         _loc1_.initialized(this,"rankSeasonIcon");
         this.rankSeasonIcon = _loc1_;
         BindingManager.executeBindings(this,"rankSeasonIcon",this.rankSeasonIcon);
         return _loc1_;
      }
      
      private function _PlayerDetails_Group3_c() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.width = 270;
         _loc1_.mxmlContent = [this._PlayerDetails_LocalizedLabel2_c(),this._PlayerDetails_Label2_i(),this._PlayerDetails_BitmapImage2_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_LocalizedLabel2_c() : LocalizedLabel
      {
         var _loc1_:LocalizedLabel = new LocalizedLabel();
         _loc1_.useAsLabel = true;
         _loc1_.localeTextKey = "profile.rankAllTime";
         _loc1_.width = 130;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.y = 7;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_Label2_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 85;
         _loc1_.width = 140;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.y = 7;
         _loc1_.id = "rankAllTimeLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.rankAllTimeLabel = _loc1_;
         BindingManager.executeBindings(this,"rankAllTimeLabel",this.rankAllTimeLabel);
         return _loc1_;
      }
      
      private function _PlayerDetails_BitmapImage2_i() : BitmapImage
      {
         var _loc1_:BitmapImage = new BitmapImage();
         _loc1_.left = 180;
         _loc1_.initialized(this,"rankAllTimeIcon");
         this.rankAllTimeIcon = _loc1_;
         BindingManager.executeBindings(this,"rankAllTimeIcon",this.rankAllTimeIcon);
         return _loc1_;
      }
      
      private function _PlayerDetails_Group4_c() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.height = 19;
         _loc1_.mxmlContent = [this._PlayerDetails_LocalizedLabel3_c(),this._PlayerDetails_Label3_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_LocalizedLabel3_c() : LocalizedLabel
      {
         var _loc1_:LocalizedLabel = new LocalizedLabel();
         _loc1_.useAsLabel = true;
         _loc1_.localeTextKey = "profile.level";
         _loc1_.width = 130;
         _loc1_.maxDisplayedLines = 1;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_Label3_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 85;
         _loc1_.width = 135;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.id = "levelLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.levelLabel = _loc1_;
         BindingManager.executeBindings(this,"levelLabel",this.levelLabel);
         return _loc1_;
      }
      
      private function _PlayerDetails_Group5_c() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.height = 19;
         _loc1_.mxmlContent = [this._PlayerDetails_LocalizedLabel4_c(),this._PlayerDetails_Label4_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_LocalizedLabel4_c() : LocalizedLabel
      {
         var _loc1_:LocalizedLabel = new LocalizedLabel();
         _loc1_.useAsLabel = true;
         _loc1_.localeTextKey = "profile.lastlogin";
         _loc1_.width = 130;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.y = -7;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _PlayerDetails_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.left = 135;
         _loc1_.width = 135;
         _loc1_.maxDisplayedLines = 1;
         _loc1_.y = -7;
         _loc1_.id = "lastloginLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.lastloginLabel = _loc1_;
         BindingManager.executeBindings(this,"lastloginLabel",this.lastloginLabel);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get lastloginLabel() : Label
      {
         return this._744859681lastloginLabel;
      }
      
      public function set lastloginLabel(param1:Label) : void
      {
         var _loc2_:Object = this._744859681lastloginLabel;
         if(_loc2_ !== param1)
         {
            this._744859681lastloginLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lastloginLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get levelLabel() : Label
      {
         return this._188974544levelLabel;
      }
      
      public function set levelLabel(param1:Label) : void
      {
         var _loc2_:Object = this._188974544levelLabel;
         if(_loc2_ !== param1)
         {
            this._188974544levelLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"levelLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rankAllTimeIcon() : BitmapImage
      {
         return this._1044040155rankAllTimeIcon;
      }
      
      public function set rankAllTimeIcon(param1:BitmapImage) : void
      {
         var _loc2_:Object = this._1044040155rankAllTimeIcon;
         if(_loc2_ !== param1)
         {
            this._1044040155rankAllTimeIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rankAllTimeIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rankAllTimeLabel() : Label
      {
         return this._1991795246rankAllTimeLabel;
      }
      
      public function set rankAllTimeLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1991795246rankAllTimeLabel;
         if(_loc2_ !== param1)
         {
            this._1991795246rankAllTimeLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rankAllTimeLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rankSeasonIcon() : BitmapImage
      {
         return this._343790408rankSeasonIcon;
      }
      
      public function set rankSeasonIcon(param1:BitmapImage) : void
      {
         var _loc2_:Object = this._343790408rankSeasonIcon;
         if(_loc2_ !== param1)
         {
            this._343790408rankSeasonIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rankSeasonIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rankSeasonLabel() : Label
      {
         return this._2070266373rankSeasonLabel;
      }
      
      public function set rankSeasonLabel(param1:Label) : void
      {
         var _loc2_:Object = this._2070266373rankSeasonLabel;
         if(_loc2_ !== param1)
         {
            this._2070266373rankSeasonLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rankSeasonLabel",_loc2_,param1));
            }
         }
      }
   }
}

