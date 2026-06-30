package net.bigpoint.deprecated.network.commands.battlegrounds
{
   import net.bigpoint.deprecated.network.BaseMessageCommand;
   import net.bigpoint.network.messages.LastmanStandingPlayercountMessage;
   import net.bigpoint.pirateStorm.notifications.Notice;
   
   public class LastmanStandingPlayercountMessageCommand extends BaseMessageCommand
   {
      
      public function LastmanStandingPlayercountMessageCommand()
      {
         super();
      }
      
      public static function run(message:LastmanStandingPlayercountMessage) : void
      {
         facade.sendNotification(Notice.SINGLESCORE_INFOBANNER_SET_COUNTER,message.playerCount);
      }
   }
}

