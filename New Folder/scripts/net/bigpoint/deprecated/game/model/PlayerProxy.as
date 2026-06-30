package net.bigpoint.deprecated.game.model
{
   import flash.utils.getTimer;
   import net.bigpoint.deprecated.game.controller.init.ChatConnectCommand;
   import net.bigpoint.deprecated.game.model.services.SoundManager;
   import net.bigpoint.deprecated.game.model.services.Type;
   import net.bigpoint.deprecated.game.model.vo.GainRewardAnimationVO;
   import net.bigpoint.deprecated.game.view.components.worldobjects.PlayerShip;
   import net.bigpoint.deprecated.gui.model.services.InfoType;
   import net.bigpoint.deprecated.gui.model.services.LayoutHelper;
   import net.bigpoint.deprecated.gui.model.services.PiratesColors;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.text.DefaultNumberFormatter;
   import net.bigpoint.deprecated.gui.view.components.text.IndicatorTextFactory;
   import net.bigpoint.pirateStorm.notifications.Notice;
   import net.bigpoint.pirateStorm.view.mainScreen.params.HudScreenSystemMessageParams;
   
   public class PlayerProxy extends LoadableProxy
   {
      
      private static var SYSTEM_MESSAGE_GAIN_XP:String;
      
      private static var SYSTEM_MESSAGE_GAIN_GUILD_XP:String;
      
      private static var SYSTEM_MESSAGE_GAIN_GOLD:String;
      
      private static var SYSTEM_MESSAGE_GAIN_DIAMOND:String;
      
      private static var SYSTEM_MESSAGE_GAIN_DOUBLOONS:String;
      
      private static var SYSTEM_MESSAGE_GAIN_SKULLS:String;
      
      private static var SYSTEM_MESSAGE_GAIN_PVP_POINTS:String;
      
      private static var SYSTEM_MESSAGE_GAIN_SEASON_PVP_POINTS:String;
      
      private static var SYSTEM_MESSAGE_LOSS_PVP_POINTS:String;
      
      private static var SYSTEM_MESSAGE_LOSS_SEASON_PVP_POINTS:String;
      
      private static var SYSTEM_MESSAGE_LOSS_SKULLS:String;
      
      private static var SYSTEM_MESSAGE_GAIN_DRAGONSCALE:String;
      
      private static var SKULL_NAME:String;
      
      public static const NAME:String = "PlayerProxy";
      
      public static const LOAD_SUCCESSFUL:String = NAME + "loadSuccessful";
      
      public static const LOAD_FAILED:String = NAME + "loadFailed";
      
      public static const DOUBLOONS_UPDATED:String = NAME + "updateDoubloons";
      
      public static const ENABLE_DOUBLOONS_UPDATE:String = NAME + "enableDoubloonsUpdate";
      
      private var _isPremium:Boolean;
      
      private var _playerShip:PlayerShip;
      
      private var _guildId:int = -1;
      
      private var _guildRole:int = 4;
      
      private var _userId:int = -1;
      
      private var _userName:String = null;
      
      private var _isGroupLeader:Boolean = false;
      
      private var _eliteLevel:int = -1;
      
      private var _currentElitePoints:int = -1;
      
      private var _maxElitePoints:int = -1;
      
      private var _skills:int = -1;
      
      private var _pirateSince:String = null;
      
      private var _gold:int = 2147483647;
      
      private var _diamonds:int = 2147483647;
      
      private var _seals:int = 2147483647;
      
      private var _victoryToken:int = 2147483647;
      
      private var _rum:int = 2147483647;
      
      private var _doubloons:int = 2147483647;
      
      private var _skulls:int = 2147483647;
      
      private var _dragonscale:int = 2147483647;
      
      private var _pvpPoints:int = 2147483647;
      
      private var _seasonPoints:int = 2147483647;
      
      private var _premiumEndTimeSeconds:int;
      
      private var _guildCrest:int = 1;
      
      private var _isDoubloonsActive:Boolean = false;
      
      public function PlayerProxy(data:Object = null)
      {
         super(NAME,data);
      }
      
      public function get playerShip() : PlayerShip
      {
         return this._playerShip;
      }
      
      public function set playerShip(playerShip:PlayerShip) : void
      {
         this._playerShip = playerShip;
         this._playerShip.objectId = this.userId;
      }
      
      public function get guildId() : int
      {
         return this._guildId;
      }
      
      public function set guildId(guildId:int) : void
      {
         if(this._guildId != guildId)
         {
            this._guildId = guildId;
            facade.sendNotification(Notice.GUILD_SET_GUILDID,guildId);
         }
      }
      
      public function get guildRole() : int
      {
         return this._guildRole;
      }
      
      public function set guildRole(guildRole:int) : void
      {
         this._guildRole = guildRole;
         sendNotification(Notice.PLAYER_GUILD_ROLE_UPDATED,this._guildRole);
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function set userId(userId:int) : void
      {
         this._userId = userId;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function set userName(userName:String) : void
      {
         this._userName = userName;
         this.playerShip.displayName = userName;
         facade.sendNotification(Notice.HUD_SCREEN_UPDATE_USER_NAME,userName);
      }
      
      public function get isGroupLeader() : Boolean
      {
         return this._isGroupLeader;
      }
      
      public function set isGroupLeader(isGroupLeader:Boolean) : void
      {
         this._isGroupLeader = isGroupLeader;
      }
      
      public function get eliteLevel() : int
      {
         return this._eliteLevel;
      }
      
      public function set eliteLevel(eliteLevel:int) : void
      {
         this._eliteLevel = eliteLevel;
      }
      
      public function get currentElitePoints() : int
      {
         return this._currentElitePoints;
      }
      
      public function set currentElitePoints(currentElitePoints:int) : void
      {
         this._currentElitePoints = currentElitePoints;
      }
      
      public function get maxElitePoints() : int
      {
         return this._maxElitePoints;
      }
      
      public function set maxElitePoints(maxElitePoints:int) : void
      {
         this._maxElitePoints = maxElitePoints;
      }
      
      public function get skills() : int
      {
         return this._skills;
      }
      
      public function set skills(skills:int) : void
      {
         this._skills = skills;
      }
      
      public function get pirateSince() : String
      {
         return this._pirateSince;
      }
      
      public function set pirateSince(pirateSince:String) : void
      {
         this._pirateSince = pirateSince;
      }
      
      public function get gold() : int
      {
         return this._gold;
      }
      
      public function get diamonds() : int
      {
         return this._diamonds;
      }
      
      public function get seals() : int
      {
         return this._seals;
      }
      
      public function get victoryToken() : int
      {
         return this._victoryToken;
      }
      
      public function get rum() : int
      {
         return this._rum;
      }
      
      public function get doubloons() : Number
      {
         return this._doubloons / 100;
      }
      
      public function get skulls() : int
      {
         return this._skulls;
      }
      
      public function get dragonscale() : int
      {
         return this._dragonscale;
      }
      
      public function set dragonscale(value:int) : void
      {
         this._dragonscale = value;
      }
      
      public function get pvpPoints() : int
      {
         return this._pvpPoints;
      }
      
      public function set pvpPoints(value:int) : void
      {
         var diff:int = 0;
         if(this._pvpPoints == int.MAX_VALUE || value < 0 || this._pvpPoints == value)
         {
            this._pvpPoints = value;
            return;
         }
         if(this._pvpPoints < value)
         {
            if(this._pvpPoints > 0)
            {
               diff = value - this._pvpPoints;
            }
            else
            {
               diff = value;
            }
            IndicatorTextFactory.showText(LayoutHelper.formatText(PiratesStrings.PLUS,diff),this._playerShip,IndicatorTextFactory.PVP_POINTS);
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_PVP_POINTS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diff),PiratesColors.COLOR_GOT_PVP_POINTS);
         }
         if(this._pvpPoints > value)
         {
            diff = this._pvpPoints - value;
            IndicatorTextFactory.showText(LayoutHelper.formatText(PiratesStrings.MINUS,diff),this._playerShip,IndicatorTextFactory.PVP_POINTS);
            this.addSystemMessage(SYSTEM_MESSAGE_LOSS_PVP_POINTS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diff),PiratesColors.TextRedColor);
         }
         this._pvpPoints = value;
      }
      
      public function get seasonPoints() : int
      {
         return this._seasonPoints;
      }
      
      public function set seasonPoints(value:int) : void
      {
         var diff:int = 0;
         if(this._seasonPoints == int.MAX_VALUE || value < 0 || this._seasonPoints == value)
         {
            this._seasonPoints = value;
            return;
         }
         if(this._seasonPoints < value)
         {
            if(this._seasonPoints > 0)
            {
               diff = value - this._seasonPoints;
            }
            else
            {
               diff = value;
            }
            IndicatorTextFactory.showText(LayoutHelper.formatText(PiratesStrings.PLUS,diff),this._playerShip,IndicatorTextFactory.PVP_POINTS);
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_SEASON_PVP_POINTS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diff),PiratesColors.COLOR_GOT_PVP_POINTS);
         }
         if(this._seasonPoints > value)
         {
            diff = this._seasonPoints - value;
            IndicatorTextFactory.showText(LayoutHelper.formatText(PiratesStrings.MINUS,diff),this._playerShip,IndicatorTextFactory.PVP_POINTS);
            this.addSystemMessage(SYSTEM_MESSAGE_LOSS_SEASON_PVP_POINTS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diff),PiratesColors.COLOR_GOT_PVP_POINTS);
         }
         this._seasonPoints = value;
      }
      
      public function maxPlacedMinesInfo() : void
      {
         var maxMinesPlaced:String = LocaleProxy.getText("mines.maxAmountReached");
         IndicatorTextFactory.showText(maxMinesPlaced,this._playerShip,IndicatorTextFactory.MAX_MINES_INFO);
         this.addSystemMessage(maxMinesPlaced,PiratesColors.COLOR_MAX_MINES);
      }
      
      public function hasEnoughMoney(currency:int, costs:int) : Boolean
      {
         if(currency == Type.CURRENCY_GOLD)
         {
            return this._gold >= costs;
         }
         if(currency == Type.CURRENCY_DIAMOND)
         {
            return this._diamonds >= costs;
         }
         if(currency == Type.CURRENCY_SEAL)
         {
            return this._seals >= costs;
         }
         if(currency == Type.CURRENCY_VICTORY_TOKEN)
         {
            return this._victoryToken >= costs;
         }
         if(currency == Type.CURRENCY_RUM)
         {
            return this._rum >= costs;
         }
         if(currency == Type.CURRENCY_DOUBLOON)
         {
            return this._doubloons >= costs;
         }
         if(currency == Type.CURRENCY_SKULL)
         {
            return this._skulls >= costs;
         }
         if(currency == Type.CURRENCY_DRAGONSCALE)
         {
            return this._dragonscale >= costs;
         }
         return false;
      }
      
      public function get isPremium() : Boolean
      {
         return this._isPremium;
      }
      
      public function set premiumEndTimeSeconds(endTimeSeconds:int) : void
      {
         this._isPremium = endTimeSeconds != 0;
         this._premiumEndTimeSeconds = endTimeSeconds;
      }
      
      public function get guildCrest() : int
      {
         return this._guildCrest;
      }
      
      public function set guildCrest(guildCrest:int) : void
      {
         this._guildCrest = guildCrest;
         sendNotification(Notice.GUILD_SET_GUILDCREST,guildCrest);
      }
      
      public function get isDoubloonsActive() : Boolean
      {
         return this._isDoubloonsActive;
      }
      
      public function get guildTag() : String
      {
         return this.playerShip.guildTag;
      }
      
      public function set guildTag(guildTag:String) : void
      {
         if(guildTag != ChatConnectCommand.NO_CLAN)
         {
            this.playerShip.guildTag = guildTag;
         }
      }
      
      public function get inGroup() : Boolean
      {
         return this.playerShip.inGroup;
      }
      
      public function set inGroup(inGroup:Boolean) : void
      {
         this.playerShip.inGroup = inGroup;
      }
      
      public function get level() : int
      {
         return this._playerShip.level;
      }
      
      public function set level(level:int) : void
      {
         this._playerShip.level = level;
      }
      
      public function set currentXp(currentXp:int) : void
      {
         var xpGain:int = 0;
         if(this._playerShip.currentXp < currentXp)
         {
            xpGain = currentXp - this._playerShip.currentXp;
            IndicatorTextFactory.showBitmapText(LayoutHelper.formatText(PiratesStrings.PLUS,xpGain),this._playerShip,IndicatorTextFactory.XP);
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_XP.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,xpGain),PiratesColors.COLOR_GOT_XP);
         }
         this._playerShip.currentXp = currentXp;
      }
      
      public function set collectGuildXp(guildXpGain:int) : void
      {
         this.addSystemMessage(SYSTEM_MESSAGE_GAIN_GUILD_XP.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,guildXpGain),PiratesColors.COLOR_GOT_XP);
      }
      
      public function get graphicsId() : int
      {
         return this.playerShip.graphicsId;
      }
      
      public function get remainingDays() : int
      {
         var remaining:int = 0;
         var nowSeconds:int = 0;
         if(this._premiumEndTimeSeconds == 0)
         {
            remaining = 30;
         }
         else
         {
            nowSeconds = getTimer() / 1000;
            remaining = this._premiumEndTimeSeconds - nowSeconds;
            remaining /= 86400;
            remaining += 1;
         }
         return remaining;
      }
      
      override public function load() : void
      {
         var config:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
         this._userId = parseInt(config.getValue(ConfigProxy.USER_ID));
         this._userName = config.getValue(ConfigProxy.USER_NAME);
         SYSTEM_MESSAGE_GAIN_XP = LocaleProxy.getText("system.gained.xp");
         SYSTEM_MESSAGE_GAIN_GUILD_XP = LocaleProxy.getText("system.gained.guildXp");
         SYSTEM_MESSAGE_GAIN_GOLD = LocaleProxy.getText("system.gained.gold");
         SYSTEM_MESSAGE_GAIN_DIAMOND = LocaleProxy.getText("system.gained.diamond");
         SYSTEM_MESSAGE_GAIN_DOUBLOONS = LocaleProxy.getText("system.gained.doubloon");
         SYSTEM_MESSAGE_GAIN_PVP_POINTS = LocaleProxy.getText("system.gained.pvpPoints");
         SYSTEM_MESSAGE_GAIN_SEASON_PVP_POINTS = LocaleProxy.getText("system.gained.seasonPoints");
         SYSTEM_MESSAGE_LOSS_PVP_POINTS = LocaleProxy.getText("system.lost.pvpPoints");
         SYSTEM_MESSAGE_LOSS_SEASON_PVP_POINTS = LocaleProxy.getText("system.lost.seasonPoints");
         SYSTEM_MESSAGE_GAIN_SKULLS = LocaleProxy.getText("system.obtain.item");
         SYSTEM_MESSAGE_LOSS_SKULLS = LocaleProxy.getText("system.loss.item");
         SKULL_NAME = LocaleProxy.getText("item.currency.7");
         SYSTEM_MESSAGE_GAIN_DRAGONSCALE = LocaleProxy.getText("system.gained.dragoncale");
         this.registerCurrencyUpdates();
         loadingEnd(LOAD_SUCCESSFUL);
      }
      
      public function isInGuild() : Boolean
      {
         return this._guildId > 0;
      }
      
      public function activateDoublons() : void
      {
         this._isDoubloonsActive = true;
         sendNotification(ENABLE_DOUBLOONS_UPDATE,this._isDoubloonsActive);
      }
      
      private function updateSeal(seals:int) : void
      {
         this._seals = seals;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_SEAL,this.updateSeal);
      }
      
      private function updateVictoryToken(victoryToken:int) : void
      {
         this._victoryToken = victoryToken;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_VICTORY_TOKEN,this.updateVictoryToken);
      }
      
      private function updateDiamond(diamonds:int) : void
      {
         if(this._diamonds < diamonds)
         {
            SoundManager.playSoundEffect(SoundManager.MONEY_GAIN);
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_DIAMOND.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diamonds - this._diamonds),PiratesColors.COLOR_GOT_DIAMOND);
         }
         this._diamonds = diamonds;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_DIAMOND,this.updateDiamond);
      }
      
      private function updateGold(gold:int) : void
      {
         if(this._gold < gold)
         {
            SoundManager.playSoundEffect(SoundManager.MONEY_GAIN);
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_GOLD.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,gold - this._gold),PiratesColors.COLOR_GOT_GOLD);
         }
         this._gold = gold;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_GOLD,this.updateGold);
      }
      
      private function updateRum(rum:int) : void
      {
         this._rum = rum;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_RUM,this.updateRum);
      }
      
      private function updateDoubloon(newDoubloons:int) : void
      {
         if(this._doubloons < newDoubloons)
         {
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_DOUBLOONS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,(newDoubloons - this._doubloons) / 100),PiratesColors.COLOR_GOT_GOLD);
         }
         this._doubloons = newDoubloons;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_DOUBLOON,this.updateDoubloon);
         if(this._isDoubloonsActive)
         {
            sendNotification(DOUBLOONS_UPDATED,DefaultNumberFormatter.formatCurrency(this._doubloons / 100));
         }
      }
      
      private function updateSkull(newSkulls:int) : void
      {
         var diff:int = 0;
         if(this._skulls != int.MAX_VALUE)
         {
            if(this._skulls < newSkulls)
            {
               diff = newSkulls - this._skulls;
               IndicatorTextFactory.showText(LayoutHelper.formatText(PiratesStrings.PLUS,diff),this._playerShip,IndicatorTextFactory.PVP_POINTS);
               this.addSystemMessage(SYSTEM_MESSAGE_GAIN_SKULLS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diff).replace(PiratesStrings.ITEM_PATTERN_UPPERCASE,SKULL_NAME),PiratesColors.COLOR_GOT_SKULL_POINTS);
            }
            else
            {
               diff = this._skulls - newSkulls;
               if(this._skulls > 0)
               {
                  this.addSystemMessage(SYSTEM_MESSAGE_LOSS_SKULLS.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,diff).replace(PiratesStrings.ITEM_PATTERN_UPPERCASE,SKULL_NAME),PiratesColors.TextRedColor);
               }
            }
         }
         this._skulls = newSkulls;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_SKULL,this.updateSkull);
      }
      
      private function updateDragonscale(newDragonscale:int) : void
      {
         if(this._dragonscale < newDragonscale)
         {
            this.addSystemMessage(SYSTEM_MESSAGE_GAIN_DRAGONSCALE.replace(PiratesStrings.AMOUNT_PATTERN_UPPERCASE,newDragonscale - this._dragonscale),PiratesColors.COLOR_GOT_GOLD);
         }
         this._dragonscale = newDragonscale;
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_DRAGONSCALE,this.updateDragonscale);
      }
      
      private function registerCurrencyUpdates() : void
      {
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_GOLD,this.updateGold);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_DIAMOND,this.updateDiamond);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_VICTORY_TOKEN,this.updateVictoryToken);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_SEAL,this.updateSeal);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_RUM,this.updateRum);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_DOUBLOON,this.updateDoubloon);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_SKULL,this.updateSkull);
         CurrencyUpdateHandler.addCallback(Type.CURRENCY_DRAGONSCALE,this.updateDragonscale);
      }
      
      private function addSystemMessage(text:String, color:uint = 16777215) : void
      {
         facade.sendNotification(Notice.HUD_SCREEN_SYSTEM_MESSAGE,new HudScreenSystemMessageParams(text,color,InfoType.INFO_GAINED));
         GainRewardAnimationVO.inst().displayFX(this.playerShip);
      }
   }
}

