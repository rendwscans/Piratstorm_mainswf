package net.bigpoint.deprecated.game.view.components.worldobjects
{
   import mindscriptact.assetLibrary.AssetLibrary;
   import mindscriptact.assetLibrary.assets.SwfAsset;
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import net.bigpoint.deprecated.game.controller.game.EntitySelectedCommand;
   import net.bigpoint.deprecated.game.model.EntityProxy;
   import net.bigpoint.deprecated.network.commands.AddObjectMessageCommand;
   
   public class MineEntity extends Entity
   {
      
      private static const DEFAULT_NAME:String = "defaultMine";
      
      public function MineEntity()
      {
         super();
         defaultName = DEFAULT_NAME;
         _animationType = AddObjectMessageCommand.TYPES[5];
         hideEntityName = true;
      }
      
      override public function set relationState(relationState:int) : void
      {
         relationState = relationState;
         if(relationState == 0)
         {
         }
      }
      
      override public function remove(instant:Boolean = false) : void
      {
         mouseChildren = false;
         _representation.alpha = 0;
         EntityProxy(UnpureFacade.getInstance().retrieveProxy(EntityProxy.NAME)).removeEntity(objectId,true);
         removeAllActiveEffects();
         removeDebugEntity();
      }
      
      override protected function loadRepresentation(name:String) : void
      {
         AssetLibrary.loadAsset(name,this.replaceRepresentation);
      }
      
      override protected function replaceRepresentation(asset:SwfAsset) : void
      {
         super.replaceRepresentation(asset);
         var randomFrame:int = Math.round(Math.random()) + 1;
         _representation.gotoAndStop(randomFrame);
      }
      
      override protected function updateHighlighMultiplier(graphicsId:int) : void
      {
         _highlightMultiplier = EntitySelectedCommand.getHighlightMultiplierMines(graphicsId);
      }
   }
}

