package net.bigpoint.deprecated.game.model
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.bigpoint.deprecated.game.controller.game.EntitySelectedCommand;
   import net.bigpoint.deprecated.game.debug.DebugView;
   import net.bigpoint.deprecated.game.model.vo.EntityVO;
   import net.bigpoint.deprecated.game.view.components.worldobjects.PlayerShip;
   
   public class EntityProxy extends LoadableProxy
   {
      
      public static const NAME:String = "EntityProxy";
      
      public static const LOAD_SUCCESSFUL:String = NAME + "loadSuccessful";
      
      private var entities:Dictionary = new Dictionary();
      
      private var objectsStage:Sprite;
      
      private var _playerShip:PlayerShip;
      
      private var _hideNames:Boolean;
      
      private var debugPosition:Boolean = false;
      
      public function EntityProxy(data:Object = null)
      {
         super(NAME,data);
      }
      
      override public function load() : void
      {
         this.objectsStage = WorldProxy(facade.retrieveProxy(WorldProxy.NAME)).getObjectsSortStage();
         loadingEnd(LOAD_SUCCESSFUL);
      }
      
      public function sortZOrder() : void
      {
         var current:DisplayObject = null;
         var next:DisplayObject = null;
         for(var index:uint = 1; index < this.objectsStage.numChildren; index++)
         {
            current = this.objectsStage.getChildAt(index - 1);
            next = this.objectsStage.getChildAt(index);
            if(current.y > next.y)
            {
               this.objectsStage.swapChildrenAt(index - 1,index);
            }
         }
      }
      
      public function addEntity(entityVO:EntityVO) : void
      {
         DebugView.getInstance().entityChange(true);
         this.entities[entityVO.userId] = entityVO;
         var worldProxy:WorldProxy = facade.retrieveProxy(WorldProxy.NAME) as WorldProxy;
         worldProxy.addDynamicObject(entityVO.entity);
         entityVO.fadeIn();
         if(this.debugPosition)
         {
            entityVO.entity.debugPosition = this.debugPosition;
         }
      }
      
      public function removeEntity(userId:int, instant:Boolean = false) : void
      {
         var entityVO:EntityVO = this.entities[userId];
         if(entityVO != null)
         {
            entityVO.remove = true;
            if(instant)
            {
               this.doRemove(entityVO);
            }
            else
            {
               entityVO.fadeOut(this.doRemove);
            }
         }
      }
      
      private function doRemove(entityVO:EntityVO) : void
      {
         if(entityVO.remove)
         {
            DebugView.getInstance().entityChange(false);
            WorldProxy(facade.retrieveProxy(WorldProxy.NAME)).removeDynamicObject(entityVO.entity);
            delete this.entities[entityVO.userId];
            entityVO.entity.release();
         }
         else
         {
            entityVO.entity.reactivate();
         }
      }
      
      public function reset() : void
      {
         var entityVO:EntityVO = null;
         EntitySelectedCommand.doHighlight(false);
         for each(entityVO in this.entities)
         {
            if(entityVO != null && entityVO.entity != this._playerShip)
            {
               entityVO.entity.remove(true);
            }
         }
         DebugView.getInstance().resetEntityCount(1);
      }
      
      public function getEntity(userId:int) : EntityVO
      {
         return this.entities[userId];
      }
      
      public function set playerShip(playerShip:PlayerShip) : void
      {
         this._playerShip = playerShip;
         this.addPlayerShip();
      }
      
      public function get playerShip() : PlayerShip
      {
         return this._playerShip;
      }
      
      public function updateEntities(tpf:Number, lastFrameTime:int) : void
      {
         var entityVO:EntityVO = null;
         for each(entityVO in this.entities)
         {
            if(entityVO != null)
            {
               entityVO.update(tpf,lastFrameTime);
            }
         }
      }
      
      public function scaleEntities(scale:Number) : void
      {
         var entityVO:EntityVO = null;
         for each(entityVO in this.entities)
         {
            if(entityVO != null)
            {
               entityVO.entity.scale(scale);
            }
         }
      }
      
      public function togglePlayerNames() : void
      {
         var entityVO:EntityVO = null;
         this._hideNames = !this._hideNames;
         for each(entityVO in this.entities)
         {
            if(entityVO != null)
            {
               entityVO.entity.hideAllDisplayNames(this._hideNames);
            }
         }
      }
      
      public function get hideNames() : Boolean
      {
         return this._hideNames;
      }
      
      public function get allEntities() : Dictionary
      {
         return this.entities;
      }
      
      public function togglePositionDebug() : Boolean
      {
         var entityVO:EntityVO = null;
         this.debugPosition = !this.debugPosition;
         for each(entityVO in this.entities)
         {
            if(entityVO != null)
            {
               entityVO.entity.debugPosition = this.debugPosition;
            }
         }
         return this.debugPosition;
      }
      
      public function addPlayerShip() : void
      {
         if(this.entities[this._playerShip.objectId] == null)
         {
            this.addEntity(new EntityVO(this._playerShip.objectId,this._playerShip));
         }
      }
      
      public function removePlayerShip() : void
      {
         this.removeEntity(this._playerShip.objectId,true);
      }
   }
}

