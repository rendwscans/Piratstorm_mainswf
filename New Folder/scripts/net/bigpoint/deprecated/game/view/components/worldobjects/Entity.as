package net.bigpoint.deprecated.game.view.components.worldobjects
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mindscriptact.assetLibrary.AssetLibrary;
   import mindscriptact.assetLibrary.assets.SwfAsset;
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import mx.logging.Log;
   import net.bigpoint.deprecated.external.TimedBitmapClip;
   import net.bigpoint.deprecated.game.controller.game.EntitySelectedCommand;
   import net.bigpoint.deprecated.game.controller.game.profile.ranking.RankingRequestCommand;
   import net.bigpoint.deprecated.game.controller.init.GameNotification;
   import net.bigpoint.deprecated.game.debug.DebugEntityPosition;
   import net.bigpoint.deprecated.game.model.EntityProxy;
   import net.bigpoint.deprecated.game.model.PlayerProxy;
   import net.bigpoint.deprecated.game.model.WorldProxy;
   import net.bigpoint.deprecated.game.model.services.Type;
   import net.bigpoint.deprecated.game.model.vo.EntityVO;
   import net.bigpoint.deprecated.game.model.vo.InsigniaVO;
   import net.bigpoint.deprecated.game.model.vo.MoveEntityVO;
   import net.bigpoint.deprecated.game.view.components.world.WaterComponent;
   import net.bigpoint.deprecated.game.view.components.worldobjects.Shoot.ShootingHandler;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.EntityEffect;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.fire.FirePool;
   import net.bigpoint.deprecated.gui.model.services.IconHelper;
   import net.bigpoint.deprecated.gui.model.services.ImageFromWeb;
   import net.bigpoint.deprecated.gui.model.services.LayoutHelper;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.text.EntityTextFactory;
   import net.bigpoint.deprecated.network.commands.AddObjectMessageCommand;
   import net.bigpoint.network.messages.MessageList;
   import net.bigpoint.network.messages.MoveMessage;
   import net.bigpoint.pirateStorm.constants.AssetId;
   import net.bigpoint.pirateStorm.constants.InsigniaIds;
   import net.bigpoint.pirateStorm.notifications.Notice;
   import net.bigpoint.utils.color.filters.FrozenFilter;
   
   public class Entity extends EntityBase
   {
      
      private static var HIDE_NAMES:Boolean;
      
      private static var worldProxy:WorldProxy;
      
      public static const FRIENDLY_FILTER:Array = [new ColorMatrixFilter([0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0])];
      
      public static const NEUTRAL_FILTER:Array = [new ColorMatrixFilter([1,0,0,0,0,0,0.8,0,0,0,0,0,0,0,0,0,0,0,1,0])];
      
      public static const NEUTRAL_SPECIAL_FILTER:Array = [new ColorMatrixFilter([0.95,0,0,0,0,0,0.28,0,0,0,0,0,0.75,0,0,0,0,0,1,0])];
      
      public static const HOSTILE_FILTER:Array = [new ColorMatrixFilter([0.6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0])];
      
      public static const FROZEN_FILTER:FrozenFilter = new FrozenFilter();
      
      private static const POSITION_OFFSET_TOLERANCE:int = 150;
      
      public static const FRIENDLY:int = 0;
      
      public static const NEUTRAL:int = 1;
      
      public static const HOSTILE:int = 2;
      
      private static const RANK_IMAGE:String = "img/icons/rank/big/" + PiratesStrings.VALUE_PATTERN_UPPERCASE + ".png";
      
      private static const RANK_SEASON_IMAGE:String = "img/icons/rank_season/big/" + PiratesStrings.VALUE_PATTERN_UPPERCASE + ".png";
      
      private static const ELITE_IMAGE:String = "img/icons/elite/" + PiratesStrings.VALUE_PATTERN_UPPERCASE + ".png";
      
      private static const MOV_INDICATOR_IMAGE:String = IconHelper.getGenericImageUrlById(Type.ITEM_INSIGNIA,12,IconHelper.SIZE_INDICATOR_22x23);
      
      private static const PVP_INDICATOR_IMAGE:String = IconHelper.getGenericImageUrlByName(Type.ITEM_INSIGNIA,"pvp/pvp_kill_indicator",IconHelper.SIZE_INDICATOR_22x23);
      
      private static const PVP_WON_SEASON_INDICATOR_IMAGE:String = IconHelper.getGenericImageUrlByName(Type.ITEM_INSIGNIA,"pvp/won_season_indicator",IconHelper.SIZE_INDICATOR_22x23);
      
      private static const TRUCE_INDICATOR_IMAGE:String = IconHelper.getGenericImageUrlByName(Type.ITEM_INSIGNIA,"guild/truceindicator",IconHelper.SIZE_INDICATOR_22x23);
      
      private static const CENTER:String = "center";
      
      private static const INSIGNIA_OFFSET:int = 20;
      
      private static const GUILD_OFFSET:int = 18;
      
      public static const IDLE:String = "idle";
      
      private static const HEALTHNESS_PERCENTAGE_TO_BURN:int = 33;
      
      private static const filterList:Array = new Array();
      
      protected static const INVISIBILITY_ALPHA:Number = 0.5;
      
      private static const LEVELMARK:String = "lvl";
      
      private static const LEVEL_STRING:String = PiratesStrings.ROUND_BRACKET_OPEN + PiratesStrings.LTR_MARK + LEVELMARK + PiratesStrings.ROUND_BRACKET_CLOSE;
      
      private static const GUILDMARK:String = "guildTag";
      
      private static const GUILD_STRING:String = PiratesStrings.SQUARE_BRACKET_OPEN + PiratesStrings.LTR_MARK + GUILDMARK + PiratesStrings.SQUARE_BRACKET_CLOSE;
      
      private static var CURRENT_SCALE:Number = 1;
      
      private static var shotlineColor:uint = 13369344;
      
      protected const entityInfo:Sprite = new Sprite();
      
      private const movingPath:Vector.<MoveEntityVO> = new Vector.<MoveEntityVO>();
      
      protected const endPos:Point = new Point();
      
      private const activeEffects:Dictionary = new Dictionary();
      
      private const _userInsignias:Vector.<InsigniaVO> = new Vector.<InsigniaVO>();
      
      private const _guildInsignias:Vector.<InsigniaVO> = new Vector.<InsigniaVO>();
      
      protected var frameAmount:int = 16;
      
      protected var rotationPercentage:Number = 22.5;
      
      protected var defaultName:String = "defaultShip";
      
      protected var myName:String;
      
      protected var _showName:Boolean = true;
      
      protected var entityNameBitmap:Bitmap;
      
      protected var hideEntityName:Boolean;
      
      private var entityGuildBitmap:Bitmap;
      
      private var entityRankAllTimeBitmap:Bitmap;
      
      private var entityRankSeasonBitmap:Bitmap;
      
      private var userInsignias:Sprite = new Sprite();
      
      private var guildInsignias:Sprite = new Sprite();
      
      private var movIndicator:Bitmap;
      
      private var pvpIndicator:Bitmap;
      
      private var pvpWonSeasonIndicator:Bitmap;
      
      private var truceIndicator:Bitmap;
      
      private var _hasMovIndicator:Boolean;
      
      private var _hasPvpIndicator:Boolean;
      
      private var _hasTruceIndicator:Boolean;
      
      private var _pvpIndicatorAdding:Boolean;
      
      private var _pvpWonSeasonIndicatorAdding:Boolean;
      
      private var _movIndicatorAdding:Boolean;
      
      private var fire:TimedBitmapClip;
      
      private var waveTimer:int = 0;
      
      private var totalDistance:Number = 0;
      
      private var debugEntityPosition:DebugEntityPosition;
      
      private var activateDebugEntityPosition:Boolean = false;
      
      private var _objectId:int = -1;
      
      protected var _animationType:String;
      
      protected var _representation:MovieClip;
      
      private var _frozen:Boolean;
      
      protected var _displayName:String = "npc";
      
      protected var _guildTag:String = "";
      
      private var _level:int = -1;
      
      protected var _currentHealth:int = 100;
      
      protected var _maxHealth:int = 100;
      
      protected var _avatarId:int = -1;
      
      private var _relationState:int;
      
      protected var _isHuman:Boolean;
      
      protected var _invulnerable:Boolean;
      
      protected var _hideOnMiniMap:Boolean;
      
      protected var _nextTargetPos:MoveEntityVO;
      
      protected var _highlightMultiplier:Number = 1;
      
      protected var _graphicsId:int = -1;
      
      private var _rankAllTime:int = 0;
      
      private var _rankSeason:int = 0;
      
      private var _inGroup:Boolean;
      
      private var _viewDistance:int = 1150;
      
      private var _invisible:Boolean;
      
      public function Entity()
      {
         super();
         if(worldProxy == null)
         {
            worldProxy = UnpureFacade.getInstance().retrieveProxy(WorldProxy.NAME) as WorldProxy;
         }
         this._animationType = AddObjectMessageCommand.TYPES[0];
         if(filterList.length == 0)
         {
            filterList[FRIENDLY] = FRIENDLY_FILTER;
            filterList[NEUTRAL] = NEUTRAL_FILTER;
            filterList[HOSTILE] = HOSTILE_FILTER;
         }
         this.entityInfo.mouseEnabled = false;
         this.entityInfo.mouseChildren = false;
         addToInfoLayer(this.entityInfo);
      }
      
      private static function warnDuplicateEntry(listLength:uint) : void
      {
         Log.getLogger("Entity").error("Got a list with equal move-entries! List-length: " + listLength);
      }
      
      public function get objectId() : int
      {
         return this._objectId;
      }
      
      public function set objectId(objectId:int) : void
      {
         this._objectId = objectId;
      }
      
      public function get animationType() : String
      {
         return this._animationType;
      }
      
      public function get representation() : MovieClip
      {
         return this._representation;
      }
      
      public function set frozen(value:Boolean) : void
      {
         this._frozen = value;
         this.updateFrozenFilter();
      }
      
      public function get frozen() : Boolean
      {
         return this._frozen;
      }
      
      public function get displayName() : String
      {
         return this._displayName;
      }
      
      public function set displayName(displayName:String) : void
      {
         if(this._displayName != displayName)
         {
            this._displayName = displayName;
            this.updateName();
         }
      }
      
      public function get guildTag() : String
      {
         return this._guildTag;
      }
      
      public function set guildTag(guildTag:String) : void
      {
         if(this._guildTag != guildTag)
         {
            this._guildTag = guildTag;
            this.updateName();
         }
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(level:int) : void
      {
         if(this._level != level)
         {
            this._level = level;
            this.updateName();
         }
      }
      
      public function get currentHealth() : int
      {
         return this._currentHealth;
      }
      
      public function set currentHealth(currentHealth:int) : void
      {
         this._currentHealth = currentHealth;
         EntitySelectedCommand.updateTarget(this);
         this.checkHighDamaged();
      }
      
      public function get maxHealth() : int
      {
         return this._maxHealth;
      }
      
      public function set maxHealth(maxHealth:int) : void
      {
         this._maxHealth = maxHealth;
         EntitySelectedCommand.updateTarget(this);
         this.checkHighDamaged();
      }
      
      public function get avatarId() : int
      {
         return this._avatarId;
      }
      
      public function set avatarId(avatarId:int) : void
      {
         this._avatarId = avatarId;
      }
      
      public function get relationState() : int
      {
         return this._relationState;
      }
      
      public function set relationState(relationState:int) : void
      {
         if(this._relationState != relationState)
         {
            this._relationState = relationState;
            this.updateFilter();
         }
      }
      
      public function get isHuman() : Boolean
      {
         return this._isHuman;
      }
      
      public function set isHuman(isHuman:Boolean) : void
      {
         this._isHuman = isHuman;
      }
      
      public function get invulnerable() : Boolean
      {
         return this._invulnerable;
      }
      
      public function set invulnerable(invulnerable:Boolean) : void
      {
         this._invulnerable = invulnerable;
      }
      
      public function get hideOnMiniMap() : Boolean
      {
         return this._hideOnMiniMap;
      }
      
      public function set hideOnMiniMap(value:Boolean) : void
      {
         this._hideOnMiniMap = value;
      }
      
      public function get nextTargetPos() : MoveEntityVO
      {
         return this._nextTargetPos;
      }
      
      public function set nextTargetPos(nextTargetPos:MoveEntityVO) : void
      {
         if(this._nextTargetPos != null)
         {
            this._nextTargetPos.release();
         }
         this._nextTargetPos = nextTargetPos;
      }
      
      public function get highlightMultiplier() : Number
      {
         return this._highlightMultiplier;
      }
      
      public function get graphicsId() : int
      {
         return this._graphicsId;
      }
      
      public function get rankAllTime() : int
      {
         return this._rankAllTime;
      }
      
      public function set rankAllTime(rank:int) : void
      {
         if(rank > RankingRequestCommand.MIN_NO_RANK_VALUE)
         {
            this._rankAllTime = rank;
            this.updateRankAllTime();
         }
      }
      
      public function get rankSeason() : int
      {
         return this._rankSeason;
      }
      
      public function set rankSeason(rank:int) : void
      {
         if(rank > RankingRequestCommand.MIN_NO_RANK_VALUE)
         {
            this._rankSeason = rank;
            this.updateRankSeason();
         }
      }
      
      public function get inGroup() : Boolean
      {
         return this._inGroup;
      }
      
      public function set inGroup(inGroup:Boolean) : void
      {
         if(this._inGroup != inGroup)
         {
            this._inGroup = inGroup;
            this.updateFilter();
         }
      }
      
      public function get viewDistance() : int
      {
         return this._viewDistance;
      }
      
      public function set viewDistance(viewDistance:int) : void
      {
         this._viewDistance = viewDistance;
      }
      
      public function set invisible(invisible:Boolean) : void
      {
         this._invisible = invisible;
         this.restoreAlpha();
      }
      
      public function set debugPosition(activate:Boolean) : void
      {
         this.activateDebugEntityPosition = activate;
         if(activate)
         {
            this.addDebugEntity();
         }
         else
         {
            this.removeDebugEntity();
         }
      }
      
      public function set representationAlpha(alpha:Number) : void
      {
         if(this._representation != null)
         {
            this._representation.alpha = alpha;
         }
      }
      
      public function load(graphicsId:int) : void
      {
         if(this._graphicsId == graphicsId)
         {
            return;
         }
         this.updateHighlighMultiplier(graphicsId);
         this._graphicsId = graphicsId;
         if(LayoutHelper.IS_MIRRORED && this._animationType == AddObjectMessageCommand.TYPES[0] && graphicsId == 5)
         {
            this.myName = this._animationType + PiratesStrings.UNDERSCORE + graphicsId + PiratesStrings.UNDERSCORE_RTL;
         }
         else if(this._animationType == AddObjectMessageCommand.TYPES[5])
         {
            this.myName = this._animationType + PiratesStrings.UNDERSCORE + graphicsId;
         }
         else
         {
            this.myName = this._animationType + PiratesStrings.UNDERSCORE + graphicsId;
         }
         this.loadRepresentation(this.myName);
         mouseEnabled = false;
         mouseChildren = true;
      }
      
      public function stop(destX:int, destY:int) : void
      {
         var distance:Number = NaN;
         var time:Number = NaN;
         var moveVO:MoveEntityVO = null;
         this.discardMovePath();
         var dx:Number = destX - this.x;
         var dy:Number = destY - this.y;
         if(Math.abs(dx) > 50 || Math.abs(dy) > 50)
         {
            distance = Math.sqrt(dx * dx + dy * dy);
            time = distance / 75;
            moveVO = MoveEntityVO.getValueObject();
            moveVO.setValues(destX,destY,distance,dx,dy);
            moveVO.setTraverTime(time);
            this.movingPath.push(moveVO);
            this.totalDistance = distance;
            this.travelPath();
         }
      }
      
      public function movePath(moveList:MessageList, totalTimeMs:int) : void
      {
         var distanceX:Number = NaN;
         var distanceY:Number = NaN;
         var lastPos:MoveMessage = null;
         var nextPos:MoveMessage = null;
         var pathPointCount:int = 0;
         var i:int = 0;
         var distance:Number = NaN;
         var moveVO:MoveEntityVO = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var tdx:int = 0;
         var tdy:int = 0;
         var fixTime:int = 0;
         this.discardMovePath();
         var listLength:uint = moveList.list.length;
         var firstPoint:MoveMessage = moveList.list.shift() as MoveMessage;
         if(firstPoint != null)
         {
            lastPos = firstPoint;
            this.totalDistance = 0;
            for each(nextPos in moveList.list)
            {
               distanceX = nextPos.posX - lastPos.posX;
               distanceY = nextPos.posY - lastPos.posY;
               if(distanceX == 0 && distanceY == 0)
               {
                  warnDuplicateEntry(listLength);
               }
               else
               {
                  distance = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
                  this.totalDistance += distance;
                  moveVO = MoveEntityVO.getValueObject();
                  if(this.movingPath.length == 0)
                  {
                     dx = x - firstPoint.posX;
                     dy = y - firstPoint.posY;
                     if(dx > POSITION_OFFSET_TOLERANCE || dy > POSITION_OFFSET_TOLERANCE || dx < -POSITION_OFFSET_TOLERANCE || dy < -POSITION_OFFSET_TOLERANCE)
                     {
                        x = firstPoint.posX;
                        y = firstPoint.posY;
                        moveVO.setValues(nextPos.posX,nextPos.posY,distance,distanceX,distanceY);
                     }
                     else
                     {
                        tdx = dx < 0 ? int(-dx) : int(dx);
                        tdy = dy < 0 ? int(-dy) : int(dy);
                        fixTime = tdx > tdy ? int(tdx * 10) : int(tdy * 10);
                        moveVO.setValues(nextPos.posX,nextPos.posY,distance,distanceX,distanceY,dx,dy,fixTime);
                     }
                  }
                  else
                  {
                     moveVO.setValues(nextPos.posX,nextPos.posY,distance,distanceX,distanceY);
                  }
                  this.movingPath.push(moveVO);
                  lastPos = nextPos;
               }
            }
            this.endPos.x = lastPos.posX;
            this.endPos.y = lastPos.posY;
            pathPointCount = int(this.movingPath.length);
            for(i = 0; i < pathPointCount; i++)
            {
               if(i == 0)
               {
                  this.movingPath[i].fixTimeLeft = Math.round(this.movingPath[i].distance / this.totalDistance * totalTimeMs);
                  this.movingPath[i].totalFixTime = Math.round(this.movingPath[i].distance / this.totalDistance * totalTimeMs);
               }
               this.movingPath[i].setTraverTime(Math.round(this.movingPath[i].distance / this.totalDistance * totalTimeMs));
            }
            this.travelPath();
         }
      }
      
      public function update(tpf:Number, lastFrameTime:int) : void
      {
         var pos:MoveEntityVO = this.nextTargetPos;
         if(pos != null)
         {
            this.updateInner(pos,lastFrameTime);
            if(alpha >= 1)
            {
               this.waveTimer += tpf;
               if(this.waveTimer > 50)
               {
                  this.waveTimer -= 50;
                  WaterComponent.getInstance().doWaves(x,y);
               }
            }
         }
      }
      
      public function doAttack(target:EntityVO, typeId:int, ammoId:int, impactSettings:int) : void
      {
         this.doShotline(target.x,target.y);
         ShootingHandler.doAttack(this._graphicsId,this,this._representation.currentFrame,target.x,target.y);
         this.doAmmo(typeId,ammoId,target.entity,impactSettings);
      }
      
      public function added() : void
      {
      }
      
      public function remove(instant:Boolean = false) : void
      {
         mouseChildren = false;
         this._representation.alpha = 1;
         EntityProxy(UnpureFacade.getInstance().retrieveProxy(EntityProxy.NAME)).removeEntity(this.objectId,instant);
         this.removeAllActiveEffects();
         this.removeDebugEntity();
      }
      
      public function destroy() : void
      {
         this.remove();
      }
      
      public function reactivate() : void
      {
         mouseChildren = true;
         this.checkHighDamaged();
         this.scale(CURRENT_SCALE);
         if(this.activateDebugEntityPosition)
         {
            this.addDebugEntity();
         }
      }
      
      public function scale(scale:Number) : void
      {
         CURRENT_SCALE = scale;
         this.entityInfo.scaleX = scale;
         this.entityInfo.scaleY = scale;
         this.entityInfo.visible = !HIDE_NAMES && scale < 3;
         this.entityInfo.x = 0;
         this.positionFlagLayer();
      }
      
      public function positionFlagLayer() : void
      {
         _flagLayer.scaleX = this.entityInfo.scaleX;
         _flagLayer.scaleY = this.entityInfo.scaleY;
         _flagLayer.x = -(_flagLayer.width / 2);
         if(this.entityRankAllTimeBitmap != null)
         {
            _flagLayer.y = this.entityInfo.y - this.entityRankAllTimeBitmap.height * this.entityInfo.scaleY - 25 * this.entityInfo.scaleY;
         }
         else
         {
            _flagLayer.y = -100 - 25 * this.entityInfo.scaleY;
         }
      }
      
      public function hideAllDisplayNames(hide:Boolean) : void
      {
         HIDE_NAMES = hide;
         this.hideDisplayName(hide);
      }
      
      public function isFriendly() : Boolean
      {
         return this._relationState == FRIENDLY;
      }
      
      public function isNeutral() : Boolean
      {
         return this._relationState == NEUTRAL;
      }
      
      public function isHostile() : Boolean
      {
         return this._relationState == HOSTILE;
      }
      
      public function inGuild() : Boolean
      {
         return this._guildTag != null && this._guildTag.length > 0;
      }
      
      public function release() : void
      {
         if(this.fire != null)
         {
            this.releaseFireClip();
         }
         this.discardMovePath();
      }
      
      public function updateDebugPosition(posX:int, posY:int) : void
      {
         if(this.debugEntityPosition != null)
         {
            this.debugEntityPosition.update(posX,posY,x,y);
         }
      }
      
      public function addEffect(effectId:int, priority:int, effect:EntityEffect) : void
      {
         var oldEffect:EntityEffect = this.activeEffects[effectId];
         if(oldEffect == null && this.checkPriority(priority,effect))
         {
            this.activeEffects[effectId] = effect;
            effect.scale(this._highlightMultiplier);
            effect.addToEntity(this);
            this.positionFlagLayer();
         }
      }
      
      public function removeEffect(effectId:int, isForced:Boolean = false) : EntityEffect
      {
         var effect:EntityEffect = this.activeEffects[effectId];
         if(effect != null)
         {
            this.activeEffects[effectId] = null;
            delete this.activeEffects[effectId];
            effect.removeFromEntity(this,isForced);
         }
         return effect;
      }
      
      public function updateUserIndicators(list:Vector.<int>) : void
      {
         this._hasMovIndicator = list.indexOf(InsigniaIds.MEDAL_OF_VALOR) != -1;
         this._hasPvpIndicator = list.indexOf(InsigniaIds.PREMIUM_PVP) != -1;
         this.updateName();
         this._hasTruceIndicator = list.indexOf(InsigniaIds.TRUCE) != -1;
         this.updateTruceIndicator();
      }
      
      public function updateUserInsignias(list:Vector.<int>) : void
      {
         var insigniaVO:InsigniaVO = null;
         this.clearUserInsignias();
         this._userInsignias.length = 0;
         for(var i:int = 0; i < list.length; i++)
         {
            insigniaVO = new InsigniaVO(list[i],i,this.addInsigniaToName);
            this._userInsignias.push(insigniaVO);
         }
      }
      
      public function updateGuildInsignias(list:Vector.<int>) : void
      {
         var insigniaVO:InsigniaVO = null;
         this.clearGuildInsignias();
         this._userInsignias.length = 0;
         for(var i:int = 0; i < list.length; i++)
         {
            insigniaVO = new InsigniaVO(list[i],i,this.addInsigniaToGuild);
            this._guildInsignias.push(insigniaVO);
         }
      }
      
      public function restoreAlpha() : void
      {
         if(this._representation != null)
         {
            this._representation.alpha = this._invisible ? INVISIBILITY_ALPHA : 1;
         }
      }
      
      protected function loadRepresentation(name:String) : void
      {
         this.removeOldRepresentation();
         if(this._representation == null && !AssetLibrary.isAssetLoaded(name))
         {
            this._representation = AssetLibrary.getSWFMovieClip(AssetId.PRESET,this.defaultName);
            this.changeRepresentation(this._representation);
         }
         AssetLibrary.loadAsset(name,this.replaceRepresentation);
      }
      
      protected function removeOldRepresentation() : void
      {
         removeFromEntityLayer(this._representation);
      }
      
      protected function replaceRepresentation(asset:SwfAsset) : void
      {
         var idleClip:MovieClip = asset.getMovieClip(IDLE);
         var startFrame:int = 1;
         if(this._representation != null)
         {
            startFrame = this._representation.currentFrame;
         }
         this.removeOldRepresentation();
         this._representation = idleClip;
         this._representation.cacheAsBitmap = true;
         this.frameAmount = this._representation.framesLoaded;
         this.rotationPercentage = 360 / this.frameAmount;
         this._representation.gotoAndStop(startFrame);
         this.checkRotation();
         this.changeRepresentation(this._representation);
      }
      
      protected function checkRotation() : void
      {
         if(this.nextTargetPos != null)
         {
            this.rotateEntity(this.nextTargetPos.posX,this.nextTargetPos.posY);
         }
      }
      
      protected function changeRepresentation(representation:MovieClip) : void
      {
         addToEntityLayer(representation);
         representation.alpha = this._invisible ? INVISIBILITY_ALPHA : 1;
         this.positionFlagLayer();
      }
      
      protected function rotateEntity(destX:Number, destY:Number) : void
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         if(this._representation != null)
         {
            dx = destX - this.x;
            dy = destY - this.y;
            this._representation.gotoAndStop(this.currentDirection(dx,dy));
         }
      }
      
      protected function currentDirection(dx:Number, dy:Number) : int
      {
         var angle:Number = Math.atan2(dy,dx) * 180 / Math.PI;
         var frame:int = (-angle + 180) / this.rotationPercentage + 1.5;
         if(frame > this.frameAmount)
         {
            frame -= this.frameAmount;
         }
         return frame;
      }
      
      protected function discardMovePath() : void
      {
         this.nextTargetPos = null;
         while(this.movingPath.length > 0)
         {
            (this.movingPath.pop() as MoveEntityVO).release();
         }
      }
      
      protected function travelPath() : Boolean
      {
         var nextPos:MoveEntityVO = null;
         if(this.movingPath.length > 0)
         {
            nextPos = this.movingPath.shift();
            this.rotateEntity(nextPos.posX,nextPos.posY);
            this.nextTargetPos = nextPos;
            return true;
         }
         return false;
      }
      
      protected function doShotline(targetPosX:int, targetPosY:int) : void
      {
         var shotline:DisplayObject = Shotline.shoot(shotlineColor,x,y,targetPosX,targetPosY);
         if(shotline != null)
         {
            worldProxy.addDynamicNonSortObject(shotline);
         }
      }
      
      protected function doAmmo(typeId:int, ammoId:int, target:Entity, impactSettings:int) : void
      {
         var shot:DisplayObject = Shot.shoot(typeId,ammoId,x,y,target,this,impactSettings);
         if(shot != null)
         {
            worldProxy.addDynamicNonSortObject(shot);
         }
      }
      
      protected function removeAllActiveEffects() : void
      {
         var key:String = null;
         for(key in this.activeEffects)
         {
            this.removeEffect(parseInt(key),true);
         }
      }
      
      protected function checkHighDamaged() : void
      {
         var healthness:int = 0;
         if(this.maxHealth > 0)
         {
            healthness = this.currentHealth / this.maxHealth * 100;
            if(healthness > HEALTHNESS_PERCENTAGE_TO_BURN)
            {
               if(this.fire != null)
               {
                  this.releaseFireClip();
               }
            }
            else
            {
               if(this.fire == null)
               {
                  this.fire = FirePool.getFireTimedBitmap();
                  this.fire.scaleX = this._highlightMultiplier;
                  this.fire.scaleY = this._highlightMultiplier;
               }
               addToFireLayer(this.fire);
            }
         }
      }
      
      protected function updateFrozenFilter() : void
      {
         if(this._frozen && this._representation.filters.length == 0)
         {
            this._representation.filters = FROZEN_FILTER;
         }
         else if(!this._frozen)
         {
            this._representation.filters = null;
         }
      }
      
      protected function updateName() : void
      {
         var nameTag:String = null;
         var guildTag:String = null;
         if(this.level < 0)
         {
            return;
         }
         this.removeDisplayName();
         if(this.level == 0)
         {
            nameTag = this.displayName;
         }
         else
         {
            nameTag = LayoutHelper.formatText(LEVEL_STRING.replace(LEVELMARK,this.level),PiratesStrings.SPACE,this.displayName);
         }
         if(this.hideEntityName)
         {
            this.entityNameBitmap = new Bitmap();
         }
         else
         {
            this.entityNameBitmap = EntityTextFactory.getTextBitmap(nameTag,14,CENTER);
         }
         this.entityInfo.addChild(this.entityNameBitmap);
         this.entityNameBitmap.pixelSnapping = PixelSnapping.NEVER;
         this.entityNameBitmap.x = -int(this.entityNameBitmap.width / 2);
         this.entityNameBitmap.y = 0;
         this.entityInfo.y = -100;
         if(this.userInsignias.parent != this.entityInfo)
         {
            this.entityInfo.addChild(this.userInsignias);
         }
         this.userInsignias.x = int(this.entityNameBitmap.width / 2) + 2;
         this.userInsignias.x *= LayoutHelper.SCALE_X;
         this.userInsignias.y = 0;
         if(this.inGuild())
         {
            guildTag = GUILD_STRING.replace(GUILDMARK,this._guildTag);
            this.entityGuildBitmap = EntityTextFactory.getTextBitmap(guildTag,14,CENTER);
            this.entityInfo.addChild(this.entityGuildBitmap);
            this.entityGuildBitmap.pixelSnapping = PixelSnapping.NEVER;
            this.entityGuildBitmap.x = -int(this.entityGuildBitmap.width / 2);
            this.entityGuildBitmap.y = 17;
            this.entityInfo.y = -100;
            if(this.guildInsignias.parent != this.entityInfo)
            {
               this.entityInfo.addChild(this.guildInsignias);
               this.guildInsignias.x = int(this.entityGuildBitmap.width / 2);
               if(LayoutHelper.IS_MIRRORED)
               {
                  this.guildInsignias.x *= -1;
               }
               this.guildInsignias.y = GUILD_OFFSET;
            }
         }
         this.removeRankAllTimeIcon();
         this.removeRankSeasonIcon();
         this.updateRankAllTime();
         this.updateRankSeason();
         this.updateFilter();
         this.updatePvpIndicator();
         this.updateMovIndicator();
         this.scale(CURRENT_SCALE);
      }
      
      protected function removeDisplayName() : void
      {
         if(this.entityNameBitmap != null && this.entityNameBitmap.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.entityNameBitmap);
         }
         if(this.entityGuildBitmap != null && this.entityGuildBitmap.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.entityGuildBitmap);
         }
      }
      
      protected function updateRankAllTime() : void
      {
         if(this.entityNameBitmap != null)
         {
            ImageFromWeb.getImage((this._isHuman ? RANK_IMAGE : ELITE_IMAGE).replace(PiratesStrings.VALUE_PATTERN_UPPERCASE,this._rankAllTime),this.addRankAllTimeToName);
            if(PlayerProxy(UnpureFacade.getInstance().retrieveProxy(PlayerProxy.NAME)).userId == this._objectId)
            {
               UnpureFacade.getInstance().sendNotification(Notice.HUD_UPDATE_ALL_TIME_RANK,this._rankAllTime);
            }
         }
      }
      
      protected function updateRankSeason() : void
      {
         if(this.entityNameBitmap != null)
         {
            ImageFromWeb.getImage(RANK_SEASON_IMAGE.replace(PiratesStrings.VALUE_PATTERN_UPPERCASE,this._rankSeason),this.addRankSeasonToName);
            if(PlayerProxy(UnpureFacade.getInstance().retrieveProxy(PlayerProxy.NAME)).userId == this._objectId)
            {
               UnpureFacade.getInstance().sendNotification(Notice.HUD_UPDATE_SEASON_RANK,this._rankSeason);
            }
         }
      }
      
      protected function removeRankAllTimeIcon() : void
      {
         if(this.entityRankAllTimeBitmap != null && this.entityRankAllTimeBitmap.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.entityRankAllTimeBitmap);
         }
      }
      
      protected function removeRankSeasonIcon() : void
      {
         if(this.entityRankSeasonBitmap != null && this.entityRankSeasonBitmap.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.entityRankSeasonBitmap);
         }
      }
      
      protected function updateHighlighMultiplier(graphicsId:int) : void
      {
         this._highlightMultiplier = EntitySelectedCommand.getHighlightMultiplier(graphicsId);
         if(this.fire != null)
         {
            this.fire.scaleX = this._highlightMultiplier;
            this.fire.scaleY = this._highlightMultiplier;
         }
      }
      
      protected function hideDisplayName(hide:Boolean) : void
      {
         this.entityInfo.visible = !hide;
      }
      
      protected function addDebugEntity() : void
      {
         if(this.debugEntityPosition == null)
         {
            this.debugEntityPosition = new DebugEntityPosition();
         }
         if(this.debugEntityPosition.parent != this)
         {
            WorldProxy(UnpureFacade.getInstance().retrieveProxy(WorldProxy.NAME)).addDynamicNonSortObject(this.debugEntityPosition);
         }
      }
      
      protected function removeDebugEntity() : void
      {
         if(this.debugEntityPosition != null && this.debugEntityPosition.parent != null)
         {
            this.debugEntityPosition.parent.removeChild(this.debugEntityPosition);
         }
      }
      
      protected function removeInsignias() : void
      {
         if(this.userInsignias.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.userInsignias);
         }
         if(this.guildInsignias.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.guildInsignias);
         }
         if(this.pvpIndicator != null && this.pvpIndicator.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.pvpIndicator);
         }
         if(this.movIndicator != null && this.movIndicator.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.movIndicator);
         }
         if(this.truceIndicator != null && this.truceIndicator.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.truceIndicator);
         }
      }
      
      private function updateInner(targetPos:MoveEntityVO, lastFrameTime:int) : void
      {
         var progress:Number = NaN;
         var fixProgress:Number = NaN;
         var moveData:Object = null;
         var timeLeft:int = 0;
         targetPos.travelTimeLeft -= lastFrameTime;
         if(targetPos.travelTimeLeft > 0)
         {
            progress = targetPos.travelTimeLeft / targetPos.totaltravelTime;
            x = targetPos.posX - targetPos.distanceX * progress;
            y = targetPos.posY - targetPos.distanceY * progress;
            if(targetPos.fixTimeLeft > 0)
            {
               targetPos.fixTimeLeft -= lastFrameTime;
               if(targetPos.fixTimeLeft > 0)
               {
                  fixProgress = targetPos.fixTimeLeft / targetPos.totalFixTime;
                  x += targetPos.fixDistanceX * fixProgress;
                  y += targetPos.fixDistanceY * fixProgress;
                  moveData = new Object();
                  moveData.entity = this;
                  UnpureFacade.getInstance().sendNotification(GameNotification.ENTITY_EFFECT,moveData);
               }
            }
         }
         else
         {
            x = targetPos.posX;
            y = targetPos.posY;
            this.nextTargetPos = null;
            if(this.travelPath())
            {
               timeLeft = -targetPos.travelTimeLeft;
               this.updateInner(this.nextTargetPos,timeLeft);
            }
         }
      }
      
      private function releaseFireClip() : void
      {
         if(this.fire.parent != null)
         {
            removeFromFireLayer(this.fire);
         }
         FirePool.releaseFireClip(this.fire);
         this.fire = null;
      }
      
      private function addRankSeasonToName(url:String, image:Bitmap) : void
      {
         if(this._showName)
         {
            if(this.entityRankSeasonBitmap == null)
            {
               this.entityRankSeasonBitmap = new Bitmap();
            }
            if(this.entityRankSeasonBitmap.parent != this.entityInfo)
            {
               this.entityInfo.addChild(this.entityRankSeasonBitmap);
            }
            this.entityRankSeasonBitmap.bitmapData = image.bitmapData;
            this.entityRankSeasonBitmap.x = int(-(this.entityRankSeasonBitmap.width / 2));
            this.entityRankSeasonBitmap.y = -27;
            this.entityRankSeasonBitmap.pixelSnapping = PixelSnapping.NEVER;
            this.positionFlagLayer();
         }
      }
      
      private function addRankAllTimeToName(url:String, image:Bitmap) : void
      {
         if(this._showName)
         {
            if(this.entityRankAllTimeBitmap == null)
            {
               this.entityRankAllTimeBitmap = new Bitmap();
            }
            if(this.entityRankAllTimeBitmap.parent != this.entityInfo)
            {
               this.entityInfo.addChild(this.entityRankAllTimeBitmap);
            }
            this.entityRankAllTimeBitmap.bitmapData = image.bitmapData;
            this.entityRankAllTimeBitmap.x = int(-(this.entityRankAllTimeBitmap.width / 2));
            this.entityRankAllTimeBitmap.y = -image.height;
            this.entityRankAllTimeBitmap.pixelSnapping = PixelSnapping.NEVER;
            this.positionFlagLayer();
         }
      }
      
      private function updateFilter() : void
      {
         var filter:Array = null;
         if(this._relationState == NEUTRAL && !this._isHuman)
         {
            if(this._rankAllTime == 99)
            {
               filter = NEUTRAL_SPECIAL_FILTER;
            }
            else
            {
               filter = null;
            }
         }
         else
         {
            filter = filterList[this._relationState];
         }
         if(this.entityNameBitmap != null)
         {
            this.entityNameBitmap.filters = filter;
         }
         if(this.entityGuildBitmap != null)
         {
            this.entityGuildBitmap.filters = filter;
         }
      }
      
      private function checkPriority(priority:int, effect:EntityEffect) : Boolean
      {
         var entityEffect:EntityEffect = null;
         if(priority == 0)
         {
            return true;
         }
         for each(entityEffect in this.activeEffects)
         {
            if(priority == entityEffect.priority)
            {
               return true;
            }
            if(priority < entityEffect.priority)
            {
               return false;
            }
            if(priority > entityEffect.priority && entityEffect.priority != 0)
            {
               this.removeEffect(entityEffect.effectId,true);
            }
         }
         return true;
      }
      
      private function clearUserInsignias() : void
      {
         while(this.userInsignias.numChildren > 0)
         {
            this.userInsignias.removeChildAt(0);
         }
      }
      
      private function addInsigniaToName(index:int, image:Bitmap) : void
      {
         var insignia:Bitmap = new Bitmap();
         insignia.bitmapData = image.bitmapData;
         this.userInsignias.addChild(insignia);
         insignia.x = INSIGNIA_OFFSET * index;
         insignia.y = 0;
         insignia.x *= LayoutHelper.SCALE_X;
         insignia.scaleX = LayoutHelper.SCALE_X;
         insignia.pixelSnapping = PixelSnapping.NEVER;
      }
      
      private function clearGuildInsignias() : void
      {
         while(this.guildInsignias.numChildren > 0)
         {
            this.guildInsignias.removeChildAt(0);
         }
      }
      
      private function addInsigniaToGuild(index:int, image:Bitmap) : void
      {
         var insignia:Bitmap = new Bitmap();
         insignia.bitmapData = image.bitmapData;
         this.guildInsignias.addChild(insignia);
         insignia.x = INSIGNIA_OFFSET * index;
         insignia.y = 0;
         insignia.x *= LayoutHelper.SCALE_X;
         insignia.scaleX = LayoutHelper.SCALE_X;
         insignia.pixelSnapping = PixelSnapping.NEVER;
      }
      
      private function updateTruceIndicator() : void
      {
         if(this._hasTruceIndicator)
         {
            if(this.truceIndicator == null)
            {
               ImageFromWeb.getImage(TRUCE_INDICATOR_IMAGE,this.truceIndicatorLoaded);
            }
            else
            {
               this.addTruceIndicator();
            }
         }
         else if(this.truceIndicator != null && this.truceIndicator.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.truceIndicator);
         }
      }
      
      private function truceIndicatorLoaded(url:String, image:Bitmap) : void
      {
         this.truceIndicator = new Bitmap();
         this.truceIndicator.bitmapData = image.bitmapData;
         this.truceIndicator.pixelSnapping = PixelSnapping.NEVER;
         this.addTruceIndicator();
      }
      
      private function addTruceIndicator() : void
      {
         if(this.truceIndicator.parent != this.entityInfo)
         {
            this.entityInfo.addChild(this.truceIndicator);
            this.truceIndicator.x = -(int(this.entityGuildBitmap.width / 2) + this.truceIndicator.width);
            this.truceIndicator.y = GUILD_OFFSET;
         }
      }
      
      private function updateMovIndicator() : void
      {
         if(this._hasMovIndicator)
         {
            if(this.movIndicator == null)
            {
               ImageFromWeb.getImage(MOV_INDICATOR_IMAGE,this.movIndicatorLoaded);
            }
            else
            {
               this.addMovIndicator();
            }
         }
         else if(this.movIndicator != null && this.movIndicator.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.movIndicator);
         }
      }
      
      private function movIndicatorLoaded(url:String, image:Bitmap) : void
      {
         if(!this._movIndicatorAdding)
         {
            this._movIndicatorAdding = true;
            this.movIndicator = new Bitmap();
            this.movIndicator.bitmapData = image.bitmapData;
            this.movIndicator.pixelSnapping = PixelSnapping.NEVER;
            this.addMovIndicator();
         }
      }
      
      private function addMovIndicator() : void
      {
         if(this.movIndicator.parent != this.entityInfo && this._showName)
         {
            this.entityInfo.addChild(this.movIndicator);
            this.movIndicator.x = -(int(this.entityNameBitmap.width / 2) + INSIGNIA_OFFSET + (this._hasPvpIndicator ? INSIGNIA_OFFSET : 0)) * LayoutHelper.SCALE_X;
            this.movIndicator.y = 0;
            this.movIndicator.scaleX = LayoutHelper.SCALE_X;
         }
      }
      
      private function updatePvpIndicator() : void
      {
         if(this._hasPvpIndicator)
         {
            if(this.pvpIndicator == null)
            {
               ImageFromWeb.getImage(PVP_INDICATOR_IMAGE,this.pvpIndicatorLoaded);
            }
            else
            {
               this.addPvpIndicator();
            }
         }
         else if(this.pvpIndicator != null && this.pvpIndicator.parent == this.entityInfo)
         {
            this.entityInfo.removeChild(this.pvpIndicator);
         }
      }
      
      private function pvpIndicatorLoaded(url:String, image:Bitmap) : void
      {
         if(!this._pvpIndicatorAdding)
         {
            this._pvpIndicatorAdding = true;
            this.pvpIndicator = new Bitmap();
            this.pvpIndicator.bitmapData = image.bitmapData;
            this.pvpIndicator.pixelSnapping = PixelSnapping.NEVER;
            this.addPvpIndicator();
         }
      }
      
      private function addPvpIndicator() : void
      {
         if(this.pvpIndicator.parent != this.entityInfo)
         {
            this.entityInfo.addChild(this.pvpIndicator);
            this.pvpIndicator.x = -(int(this.entityNameBitmap.width / 2) + INSIGNIA_OFFSET) * LayoutHelper.SCALE_X;
            this.pvpIndicator.y = 0;
            this.pvpIndicator.scaleX = LayoutHelper.SCALE_X;
         }
      }
      
      private function pvpSeasonWonIndicatorLoaded(url:String, image:Bitmap) : void
      {
         if(!this._pvpWonSeasonIndicatorAdding)
         {
            this._pvpWonSeasonIndicatorAdding = true;
            this.pvpWonSeasonIndicator = new Bitmap();
            this.pvpWonSeasonIndicator.bitmapData = image.bitmapData;
            this.pvpWonSeasonIndicator.pixelSnapping = PixelSnapping.NEVER;
            this.addPvpSeasonWonIndicator();
         }
      }
      
      private function addPvpSeasonWonIndicator() : void
      {
         var insigniaOffSet:int = 0;
         if(this.pvpWonSeasonIndicator.parent != this.entityInfo)
         {
            this.entityInfo.addChild(this.pvpWonSeasonIndicator);
            insigniaOffSet = INSIGNIA_OFFSET + (this._hasPvpIndicator ? INSIGNIA_OFFSET : 0) + (this._hasMovIndicator ? INSIGNIA_OFFSET : 0);
            this.pvpWonSeasonIndicator.x = -(int(this.entityNameBitmap.width / 2) + insigniaOffSet) * LayoutHelper.SCALE_X;
            this.pvpWonSeasonIndicator.y = 0;
            this.pvpWonSeasonIndicator.scaleX = LayoutHelper.SCALE_X;
         }
      }
   }
}

