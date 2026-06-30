package net.bigpoint.deprecated.game.controller.game
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mindscriptact.assetLibrary.AssetLibrary;
   import mvcexpress.extensions.unpuremvc.patterns.command.UnpureSimpleCommand;
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import mvcexpress.extensions.unpuremvc.patterns.observer.UnpureNotification;
   import net.bigpoint.deprecated.game.debug.DebugView;
   import net.bigpoint.deprecated.game.model.ConnectionProxy;
   import net.bigpoint.deprecated.game.model.DynamicEffectHandler;
   import net.bigpoint.deprecated.game.model.UpdateHandler;
   import net.bigpoint.deprecated.game.model.services.SoundManager;
   import net.bigpoint.deprecated.game.view.components.worldobjects.Entity;
   import net.bigpoint.deprecated.game.view.components.worldobjects.StaticDestroyableAssetEntity;
   import net.bigpoint.deprecated.game.view.components.worldobjects.StaticNpcEntity;
   import net.bigpoint.network.messages.SelectMessage;
   import net.bigpoint.pirateStorm.constants.AssetId;
   import net.bigpoint.pirateStorm.notifications.Notice;
   
   public class EntitySelectedCommand extends UnpureSimpleCommand
   {
      
      private static var container:Sprite;
      
      private static var containerBig:Sprite;
      
      private static const connectionProxy:ConnectionProxy = UnpureFacade.getInstance().retrieveProxy(ConnectionProxy.NAME) as ConnectionProxy;
      
      public static var lastTarget:Entity = null;
      
      private static var highlight:Sprite = null;
      
      private static var highlightBig:Sprite = null;
      
      private static const INITIAL_WIDTH:int = 200;
      
      private static const INITIAL_BIG_WIDTH:int = 670;
      
      private static const frameCounter:DebugView = DebugView.getInstance();
      
      private static const selectionGlare:Bitmap = new Bitmap();
      
      private static const selectionBigGlare:Bitmap = new Bitmap();
      
      private static const highlightSizes:Dictionary = initHighlightSizes();
      
      private static const highlightSizesMines:Dictionary = initHighlightSizesMines();
      
      private static var activated:Boolean = true;
      
      private static var animationTime:int = 0;
      
      public function EntitySelectedCommand()
      {
         super();
      }
      
      private static function initHighlightSizes() : Dictionary
      {
         var dict:Dictionary = new Dictionary();
         dict[1] = 0.5;
         dict[14] = 0.5;
         dict[15] = 0.5;
         dict[16] = 0.5;
         dict[17] = 0.5;
         dict[19] = 0.5;
         dict[26] = 0.5;
         dict[27] = 0.5;
         dict[28] = 0.5;
         dict[29] = 0.5;
         dict[2] = 0.65;
         dict[10] = 0.65;
         dict[11] = 0.65;
         dict[12] = 0.65;
         dict[13] = 0.65;
         dict[3] = 0.7;
         dict[4] = 0.8;
         dict[20] = 0.8;
         dict[23] = 0.8;
         dict[57] = 0.75;
         dict[56] = 1.1;
         return dict;
      }
      
      private static function initHighlightSizesMines() : Dictionary
      {
         var dict:Dictionary = new Dictionary();
         dict[1] = 0.75;
         dict[2] = 0.7;
         dict[3] = 0.8;
         dict[4] = 0.8;
         return dict;
      }
      
      public static function activate(enable:Boolean) : void
      {
         activated = enable;
         if(!enable)
         {
            doHighlight(false,null);
         }
      }
      
      public static function doHighlight(enable:Boolean, target:Entity = null) : void
      {
         if(!enable)
         {
            if(target == lastTarget || target == null)
            {
               hideTarget();
            }
         }
         else if(highlight != null)
         {
            lastTarget = target;
            if(highlight.parent != null)
            {
               highlight.parent.removeChild(highlight);
            }
            if(highlightBig.parent != null)
            {
               highlightBig.parent.removeChild(highlightBig);
            }
            if(target is StaticNpcEntity || target is StaticDestroyableAssetEntity)
            {
               containerBig.rotation = 0;
               highlightBig.width = INITIAL_BIG_WIDTH * target.highlightMultiplier;
               highlightBig.height = highlightBig.width / 2;
               target.addToSelectionRingLayer(highlightBig);
            }
            else
            {
               container.rotation = 0;
               highlight.width = INITIAL_WIDTH * target.highlightMultiplier;
               highlight.height = highlight.width / 2;
               target.addToSelectionRingLayer(highlight);
            }
            if(DynamicEffectHandler.getInstance().isActive(DynamicEffectHandler.EFFECT_TARGET_RING))
            {
               animate(true);
            }
            update();
            SoundManager.playSoundEffect(SoundManager.SELECT,target);
         }
      }
      
      public static function hideById(objectId:int) : void
      {
         if(lastTarget != null && lastTarget.objectId == objectId)
         {
            hideTarget();
         }
      }
      
      private static function animate(animate:Boolean) : void
      {
         if(animate)
         {
            container.visible = true;
            containerBig.visible = true;
            UpdateHandler.addCallbackIfNotExists(rotateHighlight);
         }
         else
         {
            container.visible = false;
            containerBig.visible = false;
            UpdateHandler.removeCallback(rotateHighlight);
         }
      }
      
      private static function rotateHighlight() : void
      {
         var tpf:Number = frameCounter.getAverageTimePerFrame();
         container.rotation += tpf / 5;
         containerBig.rotation += tpf / 5;
         animationTime += tpf;
         if(animationTime > 1000)
         {
            animationTime = 0;
            if(!DynamicEffectHandler.getInstance().isActive(DynamicEffectHandler.EFFECT_TARGET_RING))
            {
               animate(false);
            }
         }
      }
      
      public static function updateTarget(entity:Entity) : void
      {
         if(entity != lastTarget)
         {
            return;
         }
         update();
      }
      
      private static function update() : void
      {
         if(lastTarget != null)
         {
            if(lastTarget.currentHealth <= 0)
            {
               hideTarget();
            }
            else
            {
               UnpureFacade.getInstance().sendNotification(Notice.TARGET_HEALTH_UPDATE,lastTarget);
            }
         }
      }
      
      private static function hideTarget() : void
      {
         if(highlight == null || highlightBig == null || lastTarget == null)
         {
            return;
         }
         lastTarget = null;
         if(highlight.parent != null)
         {
            highlight.parent.removeChild(highlight);
         }
         if(highlightBig.parent != null)
         {
            highlightBig.parent.removeChild(highlightBig);
         }
         UnpureFacade.getInstance().sendNotification(Notice.TARGET_HEALTH_HIDE);
         animate(false);
      }
      
      public static function getHighlightMultiplier(graphicsId:int) : Number
      {
         var value:Number = Number(highlightSizes[graphicsId]);
         if(isNaN(value))
         {
            return 1;
         }
         return value;
      }
      
      public static function getHighlightMultiplierMines(graphicsId:int) : Number
      {
         var value:Number = Number(highlightSizesMines[graphicsId]);
         if(isNaN(value))
         {
            return 1;
         }
         return value;
      }
      
      override public function execute(note:UnpureNotification) : void
      {
         var target:Entity = null;
         var message:SelectMessage = null;
         if(activated)
         {
            if(highlight == null)
            {
               this.initHighlight();
            }
            if(highlightBig == null)
            {
               this.initHighlightBig();
            }
            target = note.getBody() as Entity;
            if(target == lastTarget)
            {
               return;
            }
            message = new SelectMessage();
            if(target == null)
            {
               lastTarget = null;
               message.objectId = -1;
               doHighlight(false,lastTarget);
            }
            else
            {
               message.objectId = target.objectId;
               doHighlight(true,target);
            }
            connectionProxy.send(message);
         }
      }
      
      private function initHighlight() : void
      {
         var selectionData:BitmapData = AssetLibrary.getSWFBitmapData(AssetId.PRESET,"selection_ring",true);
         var selectionGlareData:BitmapData = AssetLibrary.getSWFBitmapData(AssetId.PRESET,"selection_ring_glare",true);
         container = new Sprite();
         container.visible = false;
         var selection:Bitmap = new Bitmap(selectionData);
         selection.x = -100;
         selection.y = -100;
         selectionGlare.bitmapData = selectionGlareData;
         selectionGlare.x = -100;
         selectionGlare.y = -100;
         container.addChild(selectionGlare);
         highlight = new Sprite();
         highlight.y = 5;
         highlight.addChild(selection);
         highlight.addChild(container);
         highlight.width = INITIAL_WIDTH;
         highlight.height = highlight.width / 2;
         highlight.mouseEnabled = false;
         highlight.mouseChildren = false;
      }
      
      private function initHighlightBig() : void
      {
         var selection:Bitmap = null;
         var selectionData:BitmapData = AssetLibrary.getSWFBitmapData(AssetId.PRESET,"selection_ring_big",true);
         var selectionGlareData:BitmapData = AssetLibrary.getSWFBitmapData(AssetId.PRESET,"selection_ring_big_glare",true);
         containerBig = new Sprite();
         containerBig.visible = false;
         selection = new Bitmap(selectionData);
         selection.x = -335;
         selection.y = -335;
         selectionBigGlare.bitmapData = selectionGlareData;
         selectionBigGlare.x = -335;
         selectionBigGlare.y = -335;
         containerBig.addChild(selectionBigGlare);
         highlightBig = new Sprite();
         highlightBig.y = 5;
         highlightBig.addChild(selection);
         highlightBig.addChild(containerBig);
         highlightBig.width = INITIAL_BIG_WIDTH;
         highlightBig.height = highlightBig.width / 2;
         highlightBig.mouseEnabled = false;
         highlightBig.mouseChildren = false;
      }
   }
}

