package net.bigpoint.deprecated.game.view.components.worldobjects
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.EffectBuff;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.EffectDebuff;
   import net.bigpoint.deprecated.game.view.components.worldobjects.effects.EntityEffect;
   
   public class EntityBase extends Sprite
   {
      
      protected var _deathLayer:Sprite;
      
      protected var _flagLayer:Sprite;
      
      protected var _infoLayer:Sprite;
      
      protected var _upperEffectLayer:Sprite;
      
      protected var _hitLayer:Sprite;
      
      protected var _fireLayer:Sprite;
      
      protected var _entityLayer:Sprite;
      
      protected var _selectionRingLayer:Sprite;
      
      protected var _lowerEffectLayer:Sprite;
      
      protected var _buffRingLayer:Sprite;
      
      public function EntityBase()
      {
         super();
         this._deathLayer = new Sprite();
         this._flagLayer = new Sprite();
         this._infoLayer = new Sprite();
         this._upperEffectLayer = new Sprite();
         this._hitLayer = new Sprite();
         this._fireLayer = new Sprite();
         this._entityLayer = new Sprite();
         this._selectionRingLayer = new Sprite();
         this._lowerEffectLayer = new Sprite();
         this._buffRingLayer = new Sprite();
         this._deathLayer.mouseEnabled = false;
         this._flagLayer.mouseEnabled = false;
         this._infoLayer.mouseEnabled = false;
         this._upperEffectLayer.mouseEnabled = false;
         this._hitLayer.mouseEnabled = false;
         this._fireLayer.mouseEnabled = false;
         this._selectionRingLayer.mouseEnabled = false;
         this._lowerEffectLayer.mouseEnabled = false;
         this._buffRingLayer.mouseEnabled = false;
         super.addChild(this._buffRingLayer);
         super.addChild(this._lowerEffectLayer);
         super.addChild(this._selectionRingLayer);
         super.addChild(this._entityLayer);
         super.addChild(this._fireLayer);
         super.addChild(this._hitLayer);
         super.addChild(this._upperEffectLayer);
         super.addChild(this._infoLayer);
         super.addChild(this._flagLayer);
         super.addChild(this._deathLayer);
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         throw new IllegalOperationError("addChild cannot be performed on EntityBase class! Use provided methods to add DisplayObjects to defined layers of the entity!");
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         throw new IllegalOperationError("addChildAt cannot be performed on EntityBase class! Use provided methods to add DisplayObjects to defined layers of the entity!");
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         throw new IllegalOperationError("removeChild cannot be performed on EntityBase class! Use provided methods to add DisplayObjects to defined layers of the entity!");
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         throw new IllegalOperationError("removeChildAt cannot be performed on EntityBase class! Use provided methods to add DisplayObjects to defined layers of the entity!");
      }
      
      private function removeFromLayer(layer:Sprite, child:DisplayObject) : void
      {
         if(child != null && child.parent == layer)
         {
            layer.removeChild(child);
         }
      }
      
      public function addToDeathLayer(child:DisplayObject) : void
      {
         this._deathLayer.addChild(child);
      }
      
      public function removeFromDeathLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._deathLayer,child);
      }
      
      public function addToFlagLayer(child:DisplayObject) : void
      {
         this._flagLayer.addChild(child);
      }
      
      public function removeFromFlagLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._flagLayer,child);
      }
      
      public function addToInfoLayer(child:DisplayObject) : void
      {
         this._infoLayer.addChild(child);
      }
      
      public function removeFromInfoLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._infoLayer,child);
      }
      
      public function addToUpperEffectLayer(child:DisplayObject) : void
      {
         this._upperEffectLayer.addChild(child);
      }
      
      public function removeFromUpperEffectLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._upperEffectLayer,child);
      }
      
      public function addToHitLayer(child:DisplayObject) : void
      {
         this._hitLayer.addChild(child);
      }
      
      public function removeFromHitLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._hitLayer,child);
      }
      
      public function addToFireLayer(child:DisplayObject) : void
      {
         this._fireLayer.addChild(child);
      }
      
      public function removeFromFireLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._fireLayer,child);
      }
      
      public function addToEntityLayer(child:DisplayObject) : void
      {
         this._entityLayer.addChild(child);
      }
      
      public function removeFromEntityLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._entityLayer,child);
      }
      
      public function addToSelectionRingLayer(child:DisplayObject) : void
      {
         this._selectionRingLayer.addChild(child);
      }
      
      public function removeFromSelectionRingLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._selectionRingLayer,child);
      }
      
      public function addToLowerEffectLayer(child:DisplayObject) : void
      {
         this._lowerEffectLayer.addChild(child);
      }
      
      public function removeFromLowerEffectLayer(child:DisplayObject) : void
      {
         this.removeFromLayer(this._lowerEffectLayer,child);
      }
      
      public function addToBuffRingLayer(child:EntityEffect) : void
      {
         if(child is EffectBuff)
         {
            this._buffRingLayer.addChildAt(child,0);
         }
         else if(child is EffectDebuff)
         {
            this._buffRingLayer.addChild(child);
         }
      }
      
      public function removeFromBuffRingLayer(child:EntityEffect) : void
      {
         this.removeFromLayer(this._buffRingLayer,child);
      }
      
      public function addToEntityLayerBottom(child:DisplayObject) : void
      {
         this._entityLayer.addChildAt(child,0);
      }
   }
}

