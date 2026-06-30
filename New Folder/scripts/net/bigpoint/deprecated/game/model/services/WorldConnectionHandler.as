package net.bigpoint.deprecated.game.model.services
{
   import flash.utils.Dictionary;
   import net.bigpoint.deprecated.game.model.vo.WorldConnectionVO;
   
   public class WorldConnectionHandler
   {
      
      private const _connections:Dictionary = new Dictionary();
      
      private const _themes:Dictionary = new Dictionary();
      
      private const _portals:Dictionary = new Dictionary();
      
      public function WorldConnectionHandler()
      {
         super();
      }
      
      public function addWorld(mapId:int, themeId:int, north:int = -1, east:int = -1, south:int = -1, west:int = -1) : void
      {
         this._connections[mapId] = new WorldConnectionVO(mapId,north,east,south,west);
         this._themes[mapId] = themeId - 1;
      }
      
      public function getConnections(mapId:int) : WorldConnectionVO
      {
         return this._connections[mapId];
      }
      
      public function get connections() : Dictionary
      {
         return this._connections;
      }
      
      public function getThemeByMapId(mapId:int) : int
      {
         return this._themes[mapId];
      }
      
      public function addPortal(destinationMapId:int, costs:int) : void
      {
         this._portals[destinationMapId] = costs;
      }
      
      public function hasPortal(destinationMapId:int) : Boolean
      {
         return this._portals[destinationMapId] !== undefined;
      }
      
      public function portalCosts(destinationMapId:int) : int
      {
         return int(this._portals[destinationMapId]);
      }
   }
}

