package net.bigpoint.deprecated.network.commands.deepseadiver
{
   import net.bigpoint.deprecated.network.BaseMessageCommand;
   import net.bigpoint.network.messages.DeepseaDiverLootMessage;
   import net.bigpoint.pirateStorm.notifications.Notice;
   
   public class DeepseaDiverLootMessageCommand extends BaseMessageCommand
   {
      
      public function DeepseaDiverLootMessageCommand()
      {
         super();
      }
      
      public static function run(message:DeepseaDiverLootMessage) : void
      {
         facade.sendNotification(Notice.DEAP_SEA_DIVER_SET_LOOT,message);
      }
   }
}

