package net.bigpoint.deprecated.game.view.components.worldobjects
{
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mindscriptact.assetLibrary.assets.SwfAsset;
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import net.bigpoint.deprecated.game.model.ConnectionProxy;
   import net.bigpoint.deprecated.game.model.WorldProxy;
   import net.bigpoint.deprecated.game.model.services.Type;
   import net.bigpoint.deprecated.game.model.vo.EntityVO;
   import net.bigpoint.deprecated.gui.model.services.LayoutHelper;
   import net.bigpoint.deprecated.gui.model.services.PiratesStrings;
   import net.bigpoint.deprecated.gui.view.components.text.IndicatorTextFactory;
   import net.bigpoint.network.messages.MessageList;
   import net.bigpoint.network.messages.MoveRequestMessage;
   import net.bigpoint.pirateStorm.view.mainScreen.MainScreenMediator;
   
   public class PlayerShip extends Entity
   {
      
      public static const CAMERA_MODE_BIND:int = 0;
      
      public static const CAMERA_MODE_FREE:int = 1;
      
      public static const CAMERA_MODE_PAN:int = 2;
      
      private var _currentXp:int = 2147483647;
      
      private var _maxXp:int;
      
      private var _reloadTime:Dictionary = new Dictionary();
      
      private var klickIndicator:KlickIndicator;
      
      private var _cameraMode:int = 0;
      
      private var worldProxy:WorldProxy;
      
      private var mainScreen:MainScreenMediator;
      
      private var moveRequestMessage:MoveRequestMessage = new MoveRequestMessage();
      
      private var moveCallback:Function;
      
      private const shotline:Shotline = new Shotline(52224,false);
      
      public function PlayerShip()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.mainScreen = UnpureFacade.getInstance().retrieveMediator(MainScreenMediator.NAME) as MainScreenMediator;
         this.klickIndicator = new KlickIndicator();
         _isHuman = true;
         _displayName = "player";
         this.worldProxy = UnpureFacade.getInstance().retrieveProxy(WorldProxy.NAME) as WorldProxy;
         this._reloadTime[Type.AMMO_CANNON] = 1000;
         this._reloadTime[Type.AMMO_HARPOONLAUNCHER] = 1000;
      }
      
      override protected function updateName() : void
      {
         if(_showName)
         {
            super.updateName();
         }
      }
      
      override protected function replaceRepresentation(asset:SwfAsset) : void
      {
         super.replaceRepresentation(asset);
      }
      
      public function handleMoveByMouseEvent(event:MouseEvent) : void
      {
         var zoomFactor:int = this.worldProxy.zoomFactor;
         if(zoomFactor > 3)
         {
            zoomFactor = 3;
         }
         var posX:Number = event.stageX * zoomFactor - this.worldProxy.getWorld().x;
         var posY:Number = event.stageY * zoomFactor - this.worldProxy.getWorld().y;
         this.handleMoveByPosition(posX,posY);
      }
      
      public function handleMoveByPosition(posX:Number, posY:Number) : void
      {
         var connection:ConnectionProxy = null;
         if(posX >= 0 && posX <= this.worldProxy.maxX && posY >= 0 && posY <= this.worldProxy.maxY)
         {
            connection = UnpureFacade.getInstance().retrieveProxy(ConnectionProxy.NAME) as ConnectionProxy;
            if(connection.isConnected())
            {
               this.moveRequestMessage.posX = posX;
               this.moveRequestMessage.posY = posY;
               connection.send(this.moveRequestMessage);
            }
            else if(this.moveCallback != null)
            {
               this.moveCallback(posX,posY);
            }
         }
      }
      
      override public function movePath(moveList:MessageList, time:int) : void
      {
         super.movePath(moveList,time);
         this.klickIndicator.show(endPos.x,endPos.y);
      }
      
      override public function stop(destX:int, destY:int) : void
      {
         super.stop(destX,destY);
         this.klickIndicator.hide();
      }
      
      override protected function travelPath() : Boolean
      {
         if(!super.travelPath())
         {
            this.klickIndicator.hide();
            return false;
         }
         return true;
      }
      
      override public function remove(instant:Boolean = false) : void
      {
         this.visible = false;
      }
      
      override public function set level(level:int) : void
      {
         super.level = level;
         this.mainScreen.setMyLevel(level);
      }
      
      override public function set currentHealth(currentHealth:int) : void
      {
         var healthGain:int = 0;
         if(_currentHealth < currentHealth)
         {
            healthGain = currentHealth - _currentHealth;
            IndicatorTextFactory.showBitmapText(LayoutHelper.formatText(PiratesStrings.PLUS,healthGain),this,IndicatorTextFactory.HEALTH);
         }
         super.currentHealth = currentHealth;
         this.mainScreen.updateMyHealth(currentHealth);
      }
      
      override public function set maxHealth(maxHealth:int) : void
      {
         super.maxHealth = maxHealth;
         this.mainScreen.setMyMaxHealth(maxHealth);
      }
      
      public function get currentXp() : int
      {
         return this._currentXp;
      }
      
      public function set currentXp(currentXp:int) : void
      {
         this._currentXp = currentXp;
         this.mainScreen.updateMyXp(currentXp);
      }
      
      public function get maxXp() : int
      {
         return this._maxXp;
      }
      
      public function updateXp(prevXp:int, maxXp:int) : void
      {
         this._maxXp = maxXp;
         this.mainScreen.updateMyXpValues(prevXp,maxXp);
      }
      
      override public function set avatarId(avatarId:int) : void
      {
         super.avatarId = avatarId;
         this.mainScreen.updateAvatarId(avatarId);
      }
      
      override public function doAttack(target:EntityVO, typeId:int, ammoId:int, impactSettings:int) : void
      {
         super.doAttack(target,typeId,ammoId,impactSettings);
         this.mainScreen.showReloadAnim(this._reloadTime[typeId],typeId);
      }
      
      override protected function doShotline(targetPosX:int, targetPosY:int) : void
      {
         this.shotline.shoot(x,y,targetPosX,targetPosY);
         this.worldProxy.addDynamicNonSortObject(this.shotline.representation);
      }
      
      public function setReloadTime(weaponType:int, reloadTime:int) : void
      {
         this._reloadTime[weaponType] = reloadTime;
      }
      
      public function setPosition(posX:int, posY:int) : void
      {
         x = posX;
         y = posY;
      }
      
      public function get cameraMode() : int
      {
         return this._cameraMode;
      }
      
      public function set cameraMode(cameraMode:int) : void
      {
         this._cameraMode = cameraMode;
      }
      
      public function set offlineMoveCallback(moveCallback:Function) : void
      {
         this.moveCallback = moveCallback;
      }
      
      public function get showName() : Boolean
      {
         return _showName;
      }
      
      public function set showName(showName:Boolean) : void
      {
         _showName = showName;
         if(_showName)
         {
            this.updateName();
         }
         else
         {
            removeDisplayName();
            removeRankAllTimeIcon();
            removeRankSeasonIcon();
            removeInsignias();
         }
      }
   }
}

