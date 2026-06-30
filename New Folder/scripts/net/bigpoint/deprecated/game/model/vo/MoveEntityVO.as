package net.bigpoint.deprecated.game.model.vo
{
   public class MoveEntityVO
   {
      
      private static const pool:Vector.<MoveEntityVO> = new Vector.<MoveEntityVO>();
      
      public var posX:int;
      
      public var posY:int;
      
      public var distance:Number;
      
      public var totaltravelTime:int;
      
      public var travelTimeLeft:int;
      
      public var distanceX:Number;
      
      public var distanceY:Number;
      
      public var totalFixTime:int;
      
      public var fixTimeLeft:int;
      
      public var fixDistanceX:Number;
      
      public var fixDistanceY:Number;
      
      public function MoveEntityVO()
      {
         super();
      }
      
      public static function getValueObject() : MoveEntityVO
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new MoveEntityVO();
      }
      
      public function setValues(posX:int, posY:int, distance:Number, distanceX:Number, distanceY:Number, fixDistanceX:Number = 0, fixDistanceY:Number = 0, fixTime:int = 0) : void
      {
         this.posX = posX;
         this.posY = posY;
         this.distance = distance;
         this.distanceX = distanceX;
         this.distanceY = distanceY;
         this.fixDistanceX = fixDistanceX;
         this.fixDistanceY = fixDistanceY;
         this.totalFixTime = fixTime;
         this.fixTimeLeft = fixTime;
      }
      
      public function setTraverTime(travelTime:int) : void
      {
         this.totaltravelTime = travelTime;
         this.travelTimeLeft = travelTime;
         if(travelTime < this.fixTimeLeft)
         {
            this.totalFixTime = travelTime;
            this.fixTimeLeft = travelTime;
         }
      }
      
      public function release() : void
      {
         pool.push(this);
      }
   }
}

