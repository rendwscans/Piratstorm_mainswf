package net.bigpoint.deprecated.game.controller.game.profile.postbox
{
   import mvcexpress.extensions.unpuremvc.patterns.command.UnpureSimpleCommand;
   import mvcexpress.extensions.unpuremvc.patterns.facade.UnpureFacade;
   import mvcexpress.extensions.unpuremvc.patterns.observer.UnpureNotification;
   import net.bigpoint.deprecated.game.model.LocaleProxy;
   import net.bigpoint.deprecated.game.model.PlayerProxy;
   import net.bigpoint.deprecated.game.model.WebProxy;
   import net.bigpoint.deprecated.gui.model.services.json.JSON_REQUEST;
   import net.bigpoint.deprecated.gui.model.services.json.JsonRequestOut;
   import net.bigpoint.deprecated.gui.model.vo.ArrayPool;
   import net.bigpoint.pirateStorm.notifications.Notice;
   
   public class PostBoxSendMessageCommand extends UnpureSimpleCommand
   {
      
      private static const webProxy:WebProxy = UnpureFacade.getInstance().retrieveProxy(WebProxy.NAME) as WebProxy;
      
      private static const playerProxy:PlayerProxy = UnpureFacade.getInstance().retrieveProxy(PlayerProxy.NAME) as PlayerProxy;
      
      private static const ERROR_STRING:String = "profile.messages.error.";
      
      public function PostBoxSendMessageCommand()
      {
         super();
      }
      
      override public function execute(note:UnpureNotification) : void
      {
         var receiver:String = null;
         var subject:String = null;
         var content:String = null;
         var apply:Boolean = false;
         var messageArray:Array = note.getBody() as Array;
         var guildId:int = playerProxy.guildId;
         if(messageArray != null)
         {
            receiver = messageArray[0];
            subject = messageArray[1];
            content = messageArray[2];
            if(messageArray.length == 3)
            {
               webProxy.postboxSendMessage(receiver,subject,content,this.onSendComplete,guildId);
            }
            else if(messageArray.length == 4)
            {
               apply = messageArray[3] as Boolean;
               webProxy.postboxSendMessage(receiver,subject,content,this.onSendComplete,guildId,apply ? 1 : 0);
            }
            ArrayPool.release(messageArray);
         }
      }
      
      private function onSendComplete(request:JsonRequestOut) : void
      {
         var error:String = null;
         var result:Object = request.data[JSON_REQUEST.RESULT];
         var data:Object = result[JSON_REQUEST.OK];
         if(data != null)
         {
            facade.sendNotification(Notice.POST_BOX_SEND_MESSAGE_DONE);
         }
         else
         {
            data = result[JSON_REQUEST.ERROR];
            error = data[0];
            if(error == null || error.length <= 0)
            {
               error = JSON_REQUEST.POSTBOX_ERROR_MESSAGESENDFAILED;
            }
            error = LocaleProxy.getText(ERROR_STRING + error);
            facade.sendNotification(Notice.POST_BOX_SEND_MESSAGE_ERROR,error);
         }
      }
   }
}

