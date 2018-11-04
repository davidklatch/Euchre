package
{
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Human extends Player
   {
       
      
      var callButton;
      
      var passButton;
      
      var afterPlayCardTimer;
      
      public function Human(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*)
      {
         super();
         parent = param1;
         game = param2;
         table = param3;
         deck = param4;
         this.callButton = param5;
         this.passButton = param6;
         whoAmI = 3;
         hand = new Array(5);
         cardIsPlayable = new Array(5);
         var _loc7_:* = 0;
         while(_loc7_ < 5)
         {
            hand[_loc7_] = null;
            cardIsPlayable[_loc7_] = true;
            _loc7_++;
         }
         this.afterPlayCardTimer = new Timer(timerLength);
         this.afterPlayCardTimer.addEventListener(TimerEvent.TIMER,this.afterPlayCard);
      }
      
      public function PlayCard() : *
      {
         var _loc1_:* = false;
         var _loc2_:* = 0;
         while(_loc2_ < 5)
         {
            if(hand[_loc2_] != null)
            {
               if(hand[_loc2_].suit == table.leadCardSuit)
               {
                  _loc1_ = true;
                  break;
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
                  hand[_loc2_].sprite.addEventListener(MouseEvent.CLICK,this.PlaceCardOnTable);
               }
               else
               {
                  cardIsPlayable[_loc2_] = false;
               }
            }
            _loc2_++;
         }
      }
      
      function PlaceCardOnTable(param1:MouseEvent) : *
      {
         var _loc2_:* = -1;
         var _loc3_:* = 0;
         while(_loc3_ < 5)
         {
            if(hand[_loc3_] != null)
            {
               if(param1.target.name != hand[_loc3_].sprite.name)
               {
                  hand[_loc3_].sprite.removeEventListener(MouseEvent.CLICK,this.PlaceCardOnTable);
               }
               else
               {
                  _loc2_ = _loc3_;
               }
            }
            _loc3_++;
         }
         if(hand[_loc2_] != null)
         {
            if(param1.target.name == hand[_loc2_].sprite.name)
            {
               hand[_loc2_].sprite.removeEventListener(MouseEvent.CLICK,this.PlaceCardOnTable);
               table.playCardCount++;
               if(table.whoGoesFirst == 0)
               {
                  table.stack[0] = hand[_loc2_];
                  hand[_loc2_] = null;
                  table.stack[0].sprite.x = game.topCardX;
                  table.stack[0].sprite.y = game.topCardY + 63;
                  if(table.leadCardSuit == -1)
                  {
                     table.leadCardSuit = table.stack[0].suit;
                  }
               }
               else if(table.whoGoesFirst == 1)
               {
                  table.stack[3] = hand[_loc2_];
                  hand[_loc2_] = null;
                  table.stack[3].sprite.x = game.topCardX;
                  table.stack[3].sprite.y = game.topCardY + 63;
                  if(table.leadCardSuit == -1)
                  {
                     table.leadCardSuit = table.stack[3].suit;
                  }
               }
               else if(table.whoGoesFirst == 2)
               {
                  table.stack[2] = hand[_loc2_];
                  hand[_loc2_] = null;
                  table.stack[2].sprite.x = game.topCardX;
                  table.stack[2].sprite.y = game.topCardY + 63;
                  if(table.leadCardSuit == -1)
                  {
                     table.leadCardSuit = table.stack[2].suit;
                  }
               }
               else if(table.whoGoesFirst == 3)
               {
                  table.stack[1] = hand[_loc2_];
                  hand[_loc2_] = null;
                  table.stack[1].sprite.x = game.topCardX;
                  table.stack[1].sprite.y = game.topCardY + 63;
                  if(table.leadCardSuit == -1)
                  {
                     table.leadCardSuit = table.stack[1].suit;
                  }
               }
               this.afterPlayCardTimer.start();
            }
         }
      }
      
      function afterPlayCard(param1:TimerEvent) : *
      {
         this.afterPlayCardTimer.stop();
         if(table.whoGoesFirst != 1)
         {
            game.AI1.PlayCard();
         }
         else
         {
            table.DetermineWinningCard();
         }
      }
      
      public function tradeCard(param1:Card) : *
      {
         var _loc2_:* = param1;
         var _loc3_:* = 0;
         while(_loc3_ < 5)
         {
            if(hand[_loc3_] != null)
            {
               cardIsPlayable[_loc3_] = true;
            }
            else
            {
               cardIsPlayable[_loc3_] = false;
            }
            _loc3_++;
         }
         param1 = hand[clickedCard];
         hand[clickedCard] = _loc2_;
      }
      
      public function CallTrump1() : *
      {
         this.callButton.visible = true;
         this.passButton.visible = true;
      }
      
      public function CallTrump2() : *
      {
         var _loc1_:* = undefined;
         if(game.dealer != 0)
         {
            this.callButton.visible = true;
            this.passButton.visible = true;
         }
         else
         {
            _loc1_ = game.topCard.suit;
            game.cSuitSprite.visible = true;
            game.dSuitSprite.visible = true;
            game.hSuitSprite.visible = true;
            game.sSuitSprite.visible = true;
            switch(_loc1_)
            {
               case 0:
                  game.cSuitSprite.visible = false;
                  break;
               case 1:
                  game.dSuitSprite.visible = false;
                  break;
               case 2:
                  game.hSuitSprite.visible = false;
                  break;
               case 3:
                  game.sSuitSprite.visible = false;
            }
         }
      }
      
      public function clickedCall(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         this.callButton.visible = false;
         this.passButton.visible = false;
         game.AI1.whoCalledTrumpTextBox.text = "\t    You called.";
         if(game.DetermineTrumpTurn == 1)
         {
            game.DetermineTrumpTrumpCalled = game.topCard.suit;
            game.AI1.passBox.text = "";
            game.AI2.passBox.text = "";
            game.AI3.passBox.text = "";
            if(game.dealer == 0)
            {
               _loc2_ = 0;
               while(_loc2_ < 5)
               {
                  hand[_loc2_].sprite.addEventListener(MouseEvent.CLICK,this.swapTrumpCard);
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
         }
         else
         {
            _loc3_ = game.topCard.suit;
            game.cSuitSprite.visible = true;
            game.dSuitSprite.visible = true;
            game.hSuitSprite.visible = true;
            game.sSuitSprite.visible = true;
            switch(_loc3_)
            {
               case 0:
                  game.cSuitSprite.visible = false;
                  break;
               case 1:
                  game.dSuitSprite.visible = false;
                  break;
               case 2:
                  game.hSuitSprite.visible = false;
                  break;
               case 3:
                  game.sSuitSprite.visible = false;
            }
         }
      }
      
      public function swapTrumpCard(param1:MouseEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:* = param1.target.name;
         var _loc5_:* = 0;
         while(_loc5_ < 5)
         {
            if(hand[_loc5_].sprite.name == _loc2_)
            {
               _loc3_ = hand[_loc5_].sprite.x;
               _loc4_ = hand[_loc5_].sprite.y;
               parent.stage.removeChild(hand[_loc5_].sprite);
               hand[_loc5_] = game.topCard;
               game.topCard = null;
               hand[_loc5_].sprite.x = _loc3_;
               hand[_loc5_].sprite.y = _loc4_;
            }
            hand[_loc5_].sprite.removeEventListener(MouseEvent.CLICK,this.swapTrumpCard);
            _loc5_++;
         }
         game.WasTrumpCalled();
      }
      
      public function clickedPass(param1:MouseEvent) : *
      {
         this.callButton.visible = false;
         this.passButton.visible = false;
         game.WasTrumpCalled();
      }
      
      public function clubTrump(param1:MouseEvent) : *
      {
         this.removeSuits();
         game.DetermineTrumpTrumpCalled = 0;
         game.WasTrumpCalled();
      }
      
      public function diamondTrump(param1:MouseEvent) : *
      {
         this.removeSuits();
         game.DetermineTrumpTrumpCalled = 1;
         game.WasTrumpCalled();
      }
      
      public function heartTrump(param1:MouseEvent) : *
      {
         this.removeSuits();
         game.DetermineTrumpTrumpCalled = 2;
         game.WasTrumpCalled();
      }
      
      public function spadeTrump(param1:MouseEvent) : *
      {
         this.removeSuits();
         game.DetermineTrumpTrumpCalled = 3;
         game.WasTrumpCalled();
      }
      
      function removeSuits() : *
      {
         game.cSuitSprite.visible = false;
         game.dSuitSprite.visible = false;
         game.hSuitSprite.visible = false;
         game.sSuitSprite.visible = false;
      }
      
      public function clickCard() : *
      {
      }
      
      public function click(param1:MouseEvent) : *
      {
         if("clicked on a card in player\'s hand && card[index].clickable == true && card[index].played == false")
         {
            clickedCard = "clicked card\'s index";
         }
      }
   }
}
