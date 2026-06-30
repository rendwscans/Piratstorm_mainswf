package net.bigpoint.deprecated.game.view.components.worldobjects
{
   import mindscriptact.assetLibrary.assets.SwfAsset;
   import net.bigpoint.deprecated.game.controller.game.EntitySelectedCommand;
   import net.bigpoint.deprecated.game.model.vo.EntityVO;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.EntityEffect;
   import net.bigpoint.deprecated.network.commands.AddObjectMessageCommand;
   
   public class DestroyableAssetEntity extends Entity
   {
      
      private static const DEFAULT_NAME:String = "defaultDestroyable";
      
      private var destructionInterval:Number;
      
      public function DestroyableAssetEntity()
      {
         super();
         defaultName = DEFAULT_NAME;
         _animationType = AddObjectMessageCommand.TYPES[2];
      }
      
      override protected function replaceRepresentation(asset:SwfAsset) : void
      {
         super.replaceRepresentation(asset);
         this.destructionInterval = 1 / (_representation.framesLoaded - 1);
      }
      
      override protected function checkHighDamaged() : void
      {
         var healthness:Number = currentHealth / maxHealth;
         var healthStatFrame:int = 1 + (1 - healthness) / this.destructionInterval;
         _representation.gotoAndStop(healthStatFrame);
         if(healthness <= 0)
         {
            EntitySelectedCommand.doHighlight(false);
            mouseChildren = false;
            mouseEnabled = false;
         }
      }
      
      override protected function updateHighlighMultiplier(graphicsId:int) : void
      {
         _highlightMultiplier = 1;
      }
      
      override public function doAttack(target:EntityVO, typeId:int, ammoId:int, impactSettings:int) : void
      {
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

