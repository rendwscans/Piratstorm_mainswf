package net.bigpoint.deprecated.game.model.vo
{
   import net.bigpoint.deprecated.game.view.components.worldobjects.Entity;
   
   public class EntityVO
   {
      
      public var userId:int;
      
      public var entity:Entity;
      
      private var _remove:Boolean = false;
      
      private var fade:Boolean;
      
      private var alphaMultiplier:Number;
      
      private var callback:Function;
      
      public function EntityVO(userId:int, entity:Entity)
      {
         super();
         this.userId = userId;
         this.entity = entity;
      }
      
      public function get x() : Number
      {
         return this.entity.x;
      }
      
      public function get y() : Number
      {
         return this.entity.y;
      }
      
      public function fadeIn(callback:Function = null) : void
      {
         this.callback = callback;
         this.alphaMultiplier = 0.001;
         this.fade = true;
      }
      
      public function fadeOut(callback:Function = null) : void
      {
         this.callback = callback;
         this.alphaMultiplier = -0.001;
         this.fade = true;
      }
      
      public function update(tpf:Number, lastFrameTime:int) : void
      {
         this.updateAlpha(tpf);
         this.entity.update(tpf,lastFrameTime);
      }
      
      private function updateAlpha(tpf:Number) : void
      {
         if(this.fade)
         {
            this.entity.alpha += this.alphaMultiplier * tpf;
            if(this.alphaMultiplier > 0)
            {
               if(this.entity.alpha >= 1)
               {
                  this.stopFading(1);
               }
            }
            else if(this.entity.alpha <= 0)
            {
               this.stopFading(0);
               if(this.callback != null)
               {
                  this.callback(this);
                  this.callback = null;
               }
            }
         }
      }
      
      private function stopFading(alpha:int) : void
      {
         this.fade = false;
         this.alphaMultiplier = 0;
         this.entity.alpha = alpha;
      }
      
      public function get remove() : Boolean
      {
         return this._remove;
      }
      
      public function set remove(remove:Boolean) : void
      {
         this._remove = remove;
         if(!remove)
         {
            this.fadeIn();
         }
      }
   }
}

