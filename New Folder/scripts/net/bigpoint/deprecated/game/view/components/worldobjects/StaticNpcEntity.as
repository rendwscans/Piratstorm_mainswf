package net.bigpoint.deprecated.game.view.components.worldobjects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mindscriptact.assetLibrary.assets.SwfAsset;
   import net.bigpoint.deprecated.game.model.vo.EntityVO;
   import net.bigpoint.deprecated.game.view.components.worldobjects.Shoot.StaticShootingHandler;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.EntityEffect;
   import net.bigpoint.deprecated.network.commands.AddObjectMessageCommand;
   
   public class StaticNpcEntity extends Entity
   {
      
      private static const DEFAULT_NAME:String = "defaultBuilding";
      
      private static const avatarIdMapping:Dictionary = initAvatarMapping();
      
      private static const highlightSizes:Dictionary = initHighlightSizes();
      
      public function StaticNpcEntity()
      {
         super();
         _animationType = AddObjectMessageCommand.TYPES[3];
         defaultName = DEFAULT_NAME;
      }
      
      private static function initAvatarMapping() : Dictionary
      {
         var i:int = 0;
         var map:Dictionary = new Dictionary();
         for(i = 1; i <= 5; i++)
         {
            map[i] = 1;
         }
         for(i = 6; i <= 35; i++)
         {
            map[i] = 2;
         }
         for(i = 36; i <= 40; i++)
         {
            map[i] = 1;
         }
         map[102] = 1;
         map[105] = 1;
         map[140] = 1;
         map[107] = 2;
         map[110] = 2;
         map[113] = 2;
         map[117] = 2;
         map[120] = 2;
         map[123] = 2;
         map[127] = 2;
         map[130] = 2;
         map[133] = 2;
         map[304] = 1;
         map[311] = 2;
         map[321] = 2;
         map[331] = 2;
         map[400] = 2;
         return map;
      }
      
      private static function initHighlightSizes() : Dictionary
      {
         var i:int = 0;
         var dict:Dictionary = new Dictionary();
         for(i = 1; i <= 5; i++)
         {
            dict[i] = 1;
         }
         for(i = 6; i <= 35; i++)
         {
            dict[i] = 0.6;
         }
         for(i = 36; i <= 40; i++)
         {
            dict[i] = 1;
         }
         dict[102] = 1;
         dict[105] = 1;
         dict[140] = 1;
         dict[107] = 0.6;
         dict[110] = 0.6;
         dict[113] = 0.6;
         dict[117] = 0.6;
         dict[120] = 0.6;
         dict[123] = 0.6;
         dict[127] = 0.6;
         dict[130] = 0.6;
         dict[133] = 0.6;
         dict[304] = 1;
         dict[311] = 0.6;
         dict[321] = 0.6;
         dict[331] = 0.6;
         dict[400] = 0.6;
         return dict;
      }
      
      override protected function replaceRepresentation(asset:SwfAsset) : void
      {
         var idleClip:MovieClip = asset.getMovieClip(IDLE);
         var startFrame:int = 1;
         removeOldRepresentation();
         _representation = idleClip;
         _representation.cacheAsBitmap = true;
         _representation.gotoAndStop(startFrame);
         this.changeRepresentation(_representation);
      }
      
      override protected function updateName() : void
      {
         var boundingBox:Rectangle = null;
         super.updateName();
         if(_representation != null)
         {
            boundingBox = _representation.getBounds(this);
            entityInfo.y = boundingBox.top - entityInfo.height;
         }
      }
      
      override protected function changeRepresentation(representation:MovieClip) : void
      {
         var boundingBox:Rectangle = null;
         super.changeRepresentation(representation);
         if(representation != null)
         {
            boundingBox = representation.getBounds(this);
            entityInfo.y = boundingBox.top - entityInfo.height;
         }
      }
      
      override protected function checkHighDamaged() : void
      {
      }
      
      override protected function updateHighlighMultiplier(graphicsId:int) : void
      {
         _highlightMultiplier = highlightSizes[graphicsId];
      }
      
      override public function doAttack(target:EntityVO, typeId:int, ammoId:int, impactSettings:int) : void
      {
         doShotline(target.x,target.y);
         StaticShootingHandler.doAttack(_graphicsId,this,target.x,target.y);
         doAmmo(typeId,ammoId,target.entity,impactSettings);
      }
      
      override public function get avatarId() : int
      {
         return avatarIdMapping[_avatarId];
      }
      
      override protected function rotateEntity(destX:Number, destY:Number) : void
      {
      }
      
      override public function update(tpf:Number, lastFrameTime:int) : void
      {
      }
      
      override public function added() : void
      {
      }
      
      override public function addEffect(effectId:int, priority:int, effect:EntityEffect) : void
      {
      }
      
      override public function removeEffect(effectId:int, isForced:Boolean = false) : EntityEffect
      {
         return null;
      }
   }
}

