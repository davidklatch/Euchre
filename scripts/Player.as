package
{
   public class Player
   {
       
      
      public var hand;
      
      public var clickedCard = null;
      
      public var cardIsPlayable;
      
      var parent;
      
      var game;
      
      var table;
      
      var deck;
      
      public var whoAmI;
      
      var emptyHand;
      
      var timerLength;
      
      var endOfTrickTimer;
      
      public var endOfTrickTimerLength;
      
      public function Player()
      {
         super();
         this.timerLength = 1500;
         this.endOfTrickTimerLength = 1000;
      }
      
      public function setPriority() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < 5)
         {
            if(this.cardIsPlayable[_loc1_] && this.hand[_loc1_] != null)
            {
               this.hand[_loc1_].priority = this.hand[_loc1_].value;
               if(this.game.GiveTrumpSuit() == this.hand[_loc1_].suit)
               {
                  this.hand[_loc1_].priority = this.hand[_loc1_].priority + 10;
                  if(this.hand[_loc1_].value == 11)
                  {
                     this.hand[_loc1_].priority = 26;
                  }
               }
               if((this.game.GiveTrumpSuit() == 3 - this.hand[_loc1_].suit || 3 - this.game.GiveTrumpSuit() == this.hand[_loc1_].suit) && this.hand[_loc1_].value == 11)
               {
                  this.hand[_loc1_].suit = this.game.GiveTrumpSuit();
                  this.hand[_loc1_].priority = 25;
               }
            }
            _loc1_++;
         }
      }
      
      public function GetCard(param1:Card) : *
      {
         var _loc2_:* = new Array(300,this.parent.stage.stageWidth / 2 - 105,this.parent.stage.stageWidth - 190);
         var _loc3_:* = new Array(this.parent.stage.stageHeight / 2 - 225,5,this.parent.stage.stageHeight / 2 - 225);
         var _loc4_:* = this.parent.stage.stageWidth / 2 - 105;
         var _loc5_:* = this.parent.stage.stageHeight - 130;
         var _loc6_:* = -1;
         var _loc7_:* = 4;
         while(_loc7_ >= 0)
         {
            if(this.hand[_loc7_] == null)
            {
               _loc6_ = _loc7_;
               break;
            }
            _loc7_--;
         }
         if(_loc6_ != -1)
         {
            this.hand[_loc6_] = param1;
            if(this.whoAmI == 0)
            {
               if(this.game.debug)
               {
                  this.hand[_loc6_].sprite.x = _loc2_[0];
                  this.hand[_loc6_].sprite.y = _loc3_[0] + _loc7_ * 126;
               }
               else
               {
                  this.emptyHand[_loc6_].x = _loc2_[0];
                  this.emptyHand[_loc6_].y = _loc3_[0] + _loc7_ * 90;
               }
            }
            if(this.whoAmI == 1)
            {
               if(this.game.debug)
               {
                  this.hand[_loc6_].sprite.x = _loc2_[1] + _loc7_ * 90;
                  this.hand[_loc6_].sprite.y = _loc3_[1];
               }
               else
               {
                  this.emptyHand[_loc6_].x = _loc2_[1] + _loc7_ * 90;
                  this.emptyHand[_loc6_].y = _loc3_[1];
               }
            }
            if(this.whoAmI == 2)
            {
               if(this.game.debug)
               {
                  this.hand[_loc6_].sprite.x = _loc2_[2];
                  this.hand[_loc6_].sprite.y = _loc3_[2] + _loc7_ * 126;
               }
               else
               {
                  this.emptyHand[_loc6_].x = _loc2_[2];
                  this.emptyHand[_loc6_].y = _loc3_[2] + _loc7_ * 90;
               }
            }
            if(this.whoAmI == 3)
            {
               this.hand[_loc6_].sprite.x = _loc4_ + _loc7_ * 90;
               this.hand[_loc6_].sprite.y = _loc5_;
            }
            if(this.game.debug || this.whoAmI == 3)
            {
               this.hand[_loc6_].sprite.visible = true;
            }
            else
            {
               this.emptyHand[_loc6_].visible = true;
            }
         }
      }
   }
}
