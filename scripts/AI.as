package
{
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AI extends Player
   {
       
      
      var aiX;
      
      var aiY;
      
      public var cardsDealt;
      
      public var passBox;
      
      var whoCalledTrumpTextBox;
      
      var afterPlayCardTimer;
      
      var aiName;
      
      var numSuits2Call = 4;
      
      public function AI(param1:*, param2:*, param3:*, param4:*, param5:*)
      {
         var _loc7_:* = undefined;
         super();
         parent = param1;
         game = param2;
         table = param3;
         deck = param4;
         whoAmI = param5;
         this.aiName = new Array("Jared"," Josh","David"," You");
         this.afterPlayCardTimer = new Timer(timerLength);
         this.afterPlayCardTimer.addEventListener(TimerEvent.TIMER,this.afterPlayCard);
         endOfTrickTimer = new Timer(endOfTrickTimerLength);
         endOfTrickTimer.addEventListener(TimerEvent.TIMER,this.endOfTrick);
         this.whoCalledTrumpTextBox = Game.makeTextBox();
         this.whoCalledTrumpTextBox.x = 0;
         this.whoCalledTrumpTextBox.y = parent.stage.stageHeight - 150;
         this.whoCalledTrumpTextBox.text = "";
         parent.stage.addChild(this.whoCalledTrumpTextBox);
         this.cardsDealt = 0;
         this.aiX = new Array(game.dealerX[1],game.dealerX[2] + 5,game.dealerX[3] + 10);
         this.aiY = new Array(game.dealerY[1] + game.dealerBmp.height + 13,game.dealerY[2] + game.dealerBmp.height,game.dealerY[3] + game.dealerBmp.height + 13);
         hand = new Array(5);
         cardIsPlayable = new Array(5);
         var _loc6_:* = 0;
         while(_loc6_ < 5)
         {
            hand[_loc6_] = null;
            cardIsPlayable[_loc6_] = true;
            _loc6_++;
         }
         emptyHand = new Array(5);
         var _loc8_:* = 0;
         while(_loc8_ < 5)
         {
            if(whoAmI == 0 || whoAmI == 2)
            {
               _loc7_ = new Blank1Bmp();
            }
            else if(whoAmI == 1)
            {
               _loc7_ = new BlankBmp();
            }
            emptyHand[_loc8_] = Game.makeSprite(_loc7_,_loc7_.width,_loc7_.height);
            parent.stage.addChild(emptyHand[_loc8_]);
            _loc8_++;
         }
         this.passBox = Game.makeTextBox();
         this.passBox.width = 50;
         this.passBox.height = 40;
         this.passBox.x = this.aiX[whoAmI];
         this.passBox.y = this.aiY[whoAmI];
         parent.stage.addChild(this.passBox);
      }
      
      public function PlayCard() : *
      {
         var _loc5_:* = undefined;
         var _loc1_:* = false;
         clickedCard = null;
         var _loc2_:* = 0;
         while(_loc2_ < 5)
         {
            if(hand[_loc2_] != null)
            {
               if(hand[_loc2_].suit == table.leadCardSuit)
               {
                  _loc1_ = true;
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(hand[_loc2_] != null)
            {
               if(table.leadCardSuit == -1 || table.leadCardSuit == hand[_loc2_].suit || _loc1_ == false)
               {
                  cardIsPlayable[_loc2_] = true;
               }
               else
               {
                  cardIsPlayable[_loc2_] = false;
               }
            }
            _loc2_++;
         }
         while(clickedCard == null)
         {
            _loc5_ = Math.floor(Math.random() * 5);
            if(cardIsPlayable[_loc5_])
            {
               clickedCard = _loc5_;
            }
         }
         cardIsPlayable[clickedCard] = false;
         var _loc3_:* = new Array(game.topCardX - 90,game.topCardX,game.topCardX + 90);
         var _loc4_:* = new Array(game.topCardY,game.topCardY - 63,game.topCardY);
         table.playCardCount++;
         if(table.whoGoesFirst == 0)
         {
            if(whoAmI == 0)
            {
               table.stack[1] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[1].sprite.x = _loc3_[whoAmI];
               table.stack[1].sprite.y = _loc4_[whoAmI];
               table.stack[1].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[1].suit;
               }
            }
            else if(whoAmI == 1)
            {
               table.stack[2] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[2].sprite.x = _loc3_[whoAmI];
               table.stack[2].sprite.y = _loc4_[whoAmI];
               table.stack[2].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[2].suit;
               }
            }
            else if(whoAmI == 2)
            {
               table.stack[3] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[3].sprite.x = _loc3_[whoAmI];
               table.stack[3].sprite.y = _loc4_[whoAmI];
               table.stack[3].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[3].suit;
               }
            }
         }
         else if(table.whoGoesFirst == 1)
         {
            if(whoAmI == 0)
            {
               table.stack[0] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[0].sprite.x = _loc3_[whoAmI];
               table.stack[0].sprite.y = _loc4_[whoAmI];
               table.stack[0].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[0].suit;
               }
            }
            else if(whoAmI == 1)
            {
               table.stack[1] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[1].sprite.x = _loc3_[whoAmI];
               table.stack[1].sprite.y = _loc4_[whoAmI];
               table.stack[1].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[1].suit;
               }
            }
            else if(whoAmI == 2)
            {
               table.stack[2] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[2].sprite.x = _loc3_[whoAmI];
               table.stack[2].sprite.y = _loc4_[whoAmI];
               table.stack[2].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[2].suit;
               }
            }
         }
         else if(table.whoGoesFirst == 2)
         {
            if(whoAmI == 0)
            {
               table.stack[3] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[3].sprite.x = _loc3_[whoAmI];
               table.stack[3].sprite.y = _loc4_[whoAmI];
               table.stack[3].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[3].suit;
               }
            }
            else if(whoAmI == 1)
            {
               table.stack[0] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[0].sprite.x = _loc3_[whoAmI];
               table.stack[0].sprite.y = _loc4_[whoAmI];
               table.stack[0].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[0].suit;
               }
            }
            else if(whoAmI == 2)
            {
               table.stack[1] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[1].sprite.x = _loc3_[whoAmI];
               table.stack[1].sprite.y = _loc4_[whoAmI];
               table.stack[1].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[1].suit;
               }
            }
         }
         else if(table.whoGoesFirst == 3)
         {
            if(whoAmI == 0)
            {
               table.stack[2] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[2].sprite.x = _loc3_[whoAmI];
               table.stack[2].sprite.y = _loc4_[whoAmI];
               table.stack[2].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[2].suit;
               }
            }
            else if(whoAmI == 1)
            {
               table.stack[3] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[3].sprite.x = _loc3_[whoAmI];
               table.stack[3].sprite.y = _loc4_[whoAmI];
               table.stack[3].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[3].suit;
               }
            }
            else if(whoAmI == 2)
            {
               table.stack[0] = hand[clickedCard];
               hand[clickedCard] = null;
               table.stack[0].sprite.x = _loc3_[whoAmI];
               table.stack[0].sprite.y = _loc4_[whoAmI];
               table.stack[0].sprite.visible = true;
               if(table.leadCardSuit == -1)
               {
                  table.leadCardSuit = table.stack[0].suit;
               }
            }
         }
         emptyHand[clickedCard].visible = false;
         if(table.leadCardSuit == -1)
         {
            table.leadCardSuit = hand[clickedCard].suit;
         }
         hand[clickedCard] = null;
         if(whoAmI != 2 || whoAmI == 2 && table.whoGoesFirst == 0)
         {
            this.afterPlayCardTimer.start();
         }
         else
         {
            game.Human.PlayCard();
         }
      }
      
      function afterPlayCard(param1:TimerEvent) : *
      {
         this.afterPlayCardTimer.stop();
         if(whoAmI == 0)
         {
            if(table.whoGoesFirst == 0 || table.whoGoesFirst == 1 || table.whoGoesFirst == 3)
            {
               game.AI2.PlayCard();
            }
            else
            {
               endOfTrickTimer.start();
            }
         }
         else if(whoAmI == 1)
         {
            if(table.whoGoesFirst == 0 || table.whoGoesFirst == 1 || table.whoGoesFirst == 2)
            {
               game.AI3.PlayCard();
            }
            else
            {
               endOfTrickTimer.start();
            }
         }
         else if(whoAmI == 2)
         {
            if(table.whoGoesFirst == 1 || table.whoGoesFirst == 2 || table.whoGoesFirst == 3)
            {
               game.Human.PlayCard();
            }
            else
            {
               endOfTrickTimer.start();
            }
         }
      }
      
      public function tradeCard() : *
      {
         var _loc4_:* = undefined;
         clickedCard = null;
         if(game.DetermineTrumpTurn == 1)
         {
            game.DetermineTrumpTrumpCalled = game.topCard.suit;
         }
         var _loc1_:* = 0;
         while(_loc1_ < 5)
         {
            if(hand[_loc1_] != null)
            {
               cardIsPlayable[_loc1_] = true;
            }
            else
            {
               cardIsPlayable[_loc1_] = false;
            }
            _loc1_++;
         }
         while(clickedCard == null)
         {
            _loc4_ = Math.floor(Math.random() * 5);
            if(cardIsPlayable[_loc4_])
            {
               clickedCard = _loc4_;
            }
         }
         var _loc2_:* = hand[clickedCard].sprite.x;
         var _loc3_:* = hand[clickedCard].sprite.y;
         parent.stage.removeChild(hand[clickedCard].sprite);
         hand[clickedCard] = game.topCard;
         hand[clickedCard].sprite.visible = false;
         game.topCard = null;
         hand[clickedCard].sprite.x = _loc2_;
         hand[clickedCard].sprite.y = _loc3_;
         game.WasTrumpCalled();
      }
      
      public function CallTrump1() : *
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         while(_loc2_ < 5)
         {
            if(hand[_loc2_] != null)
            {
               if(hand[_loc2_].suit == game.topCard.suit)
               {
                  _loc1_++;
               }
            }
            _loc2_++;
         }
         if(_loc1_ >= this.numSuits2Call)
         {
            if(game.dealer - 1 == whoAmI)
            {
               this.tradeCard();
            }
            else if(game.dealer == 0)
            {
               this.passBox.text = "Call";
               game.DetermineTrumpTrumpCalled = game.topCard.suit;
               _loc2_ = 0;
               while(_loc2_ < 5)
               {
                  game.Human.hand[_loc2_].sprite.addEventListener(MouseEvent.CLICK,game.Human.swapTrumpCard);
                  _loc2_++;
               }
            }
            else if(game.dealer == 1)
            {
               game.AI1.tradeCard();
            }
            else if(game.dealer == 2)
            {
               game.AI2.tradeCard();
            }
            else if(game.dealer == 3)
            {
               game.AI3.tradeCard();
            }
            this.whoCalledTrumpTextBox.text = "\t   " + this.aiName[whoAmI] + " called.";
         }
         else
         {
            this.passBox.text = "Pass";
            this.passBox.visible = true;
            game.DetermineTrumpTrumpCalled = -1;
            game.WasTrumpCalled();
         }
      }
      
      public function CallTrump2() : *
      {
         var _loc1_:* = -1;
         var _loc2_:* = new Array(4);
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         while(_loc5_ < 4)
         {
            _loc2_[_loc5_] = 0;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            if(hand[_loc5_] != null)
            {
               _loc2_[hand[_loc5_].suit]++;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            if(_loc2_[_loc5_] > _loc4_)
            {
               _loc3_ = _loc5_;
               _loc4_ = _loc2_[_loc5_];
            }
            _loc5_++;
         }
         if(_loc4_ >= 3 || whoAmI == game.dealer)
         {
            _loc1_ = _loc3_;
         }
         if(_loc1_ == -1)
         {
            this.passBox.text = "Pass";
            this.passBox.visible = true;
         }
         else
         {
            this.whoCalledTrumpTextBox.text = "\t   " + this.aiName[whoAmI] + " called.";
         }
         game.DetermineTrumpTrumpCalled = _loc1_;
         game.WasTrumpCalled();
      }
      
      function endOfTrick(param1:TimerEvent) : *
      {
         endOfTrickTimer.stop();
         table.DetermineWinningCard();
      }
   }
}
