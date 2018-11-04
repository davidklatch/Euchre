package
{
   import flash.events.TimerEvent;
   import flash.system.System;
   import flash.utils.Timer;
   
   public class Table
   {
       
      
      var team0TrickScore;
      
      var team1TrickScore;
      
      var trickCount;
      
      var trumpSuit;
      
      public var whoCalledTrump;
      
      public var whoGoesFirst;
      
      var winningPlayer;
      
      public var stack;
      
      public var leadCardSuit;
      
      public var playCardCount;
      
      public var numTricks;
      
      var theGame;
      
      var delayFirstPlayTimer;
      
      var winningCard:Card;
      
      public function Table()
      {
         super();
         this.numTricks = 0;
         this.playCardCount = 0;
         this.team0TrickScore = 0;
         this.team1TrickScore = 0;
         this.trickCount = 0;
         this.trumpSuit = 0;
         this.whoCalledTrump = 0;
         this.whoGoesFirst = 1;
         this.winningPlayer = 0;
         this.stack = new Array(4);
         this.leadCardSuit = -1;
         this.delayFirstPlayTimer = new Timer(1000);
         this.delayFirstPlayTimer.addEventListener(TimerEvent.TIMER,this.delayFirstPlay);
      }
      
      public function getGameRef(param1:*) : *
      {
         this.theGame = param1;
      }
      
      public function ReceiveTrumpSuit(param1:*) : *
      {
         this.trumpSuit = param1;
      }
      
      public function ReceiveTrumpPlayer(param1:*) : *
      {
         this.whoCalledTrump = param1;
      }
      
      public function PlayTricks(param1:*, param2:*, param3:*, param4:*) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(this.numTricks < 5)
         {
            this.playCardCount = 0;
            this.GetCards(param1,param2,param3,param4);
         }
         else
         {
            _loc5_ = new Array();
            _loc5_ = this.ReturnScores();
            this.theGame.team1Score = this.theGame.team1Score + _loc5_[0];
            this.theGame.team2Score = this.theGame.team2Score + _loc5_[1];
            this.theGame.handScoreBox.text = "Hand Score\nTeam 1: " + this.theGame.team1Score + "    Team 2: " + this.theGame.team2Score;
            this.ResetTrickScores();
            this.theGame.UpdateNoWinner();
            this.theGame.MoveDealer();
            this.theGame.AI1.whoCalledTrumpTextBox.text = "";
            this.theGame.AI2.whoCalledTrumpTextBox.text = "";
            this.theGame.AI3.whoCalledTrumpTextBox.text = "";
            this.theGame.AI1.hand = null;
            this.theGame.AI1.hand = new Array(5);
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               this.theGame.AI1.hand[_loc6_] = null;
               this.theGame.AI1.cardIsPlayable[_loc6_] = true;
               _loc6_++;
            }
            this.theGame.AI2.hand = null;
            this.theGame.AI2.hand = new Array(5);
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               this.theGame.AI2.hand[_loc6_] = null;
               this.theGame.AI2.cardIsPlayable[_loc6_] = true;
               _loc6_++;
            }
            this.theGame.AI3.hand = null;
            this.theGame.AI3.hand = new Array(5);
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               this.theGame.AI3.hand[_loc6_] = null;
               this.theGame.AI3.cardIsPlayable[_loc6_] = true;
               _loc6_++;
            }
            this.theGame.Human.hand = null;
            this.theGame.Human.hand = new Array(5);
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               this.theGame.Human.hand[_loc6_] = null;
               this.theGame.Human.cardIsPlayable[_loc6_] = true;
               _loc6_++;
            }
            this.theGame.topCard = null;
            this.theGame.topCard = new Card();
            this.stack = null;
            this.stack = new Array(4);
            this.theGame.trumpBox.text = "";
            this.theGame.DetermineTrumpNumFunCalls = 1;
            this.theGame.DetermineTrumpTrumpCalled = -1;
            this.theGame.DetermineTrumpCount = 0;
            this.theGame.DetermineTrumpTurn = 1;
            this.theGame.theDeck = null;
            this.theGame.theDeck = new Deck(this.theGame.theParent);
            this.theGame.theDeck.CreateDeck();
            System.gc();
            this.theGame.PlayGame();
         }
      }
      
      public function GetCards(param1:*, param2:*, param3:*, param4:*) : *
      {
         this.leadCardSuit = -1;
         trace("in getCards wgf = " + this.whoGoesFirst);
         if(this.whoGoesFirst == 0)
         {
            param1.PlayCard();
         }
         else if(this.whoGoesFirst == 1)
         {
            param2.PlayCard();
         }
         else if(this.whoGoesFirst == 2)
         {
            param3.PlayCard();
         }
         else if(this.whoGoesFirst == 3)
         {
            param4.PlayCard();
         }
      }
      
      public function DetermineWinningCard() : *
      {
         this.winningCard = this.stack[0];
         this.winningPlayer = 0;
         var _loc1_:* = 1;
         while(_loc1_ < 4)
         {
            if(this.winningCard.suit == this.stack[_loc1_].suit)
            {
               if(this.stack[_loc1_].priority > this.winningCard.priority)
               {
                  this.winningCard = this.stack[_loc1_];
                  this.winningPlayer = _loc1_;
               }
            }
            else if(this.stack[_loc1_].suit == this.trumpSuit)
            {
               this.winningCard = this.stack[_loc1_];
               this.winningPlayer = _loc1_;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.stack[_loc1_].sprite.visible = false;
            _loc1_++;
         }
         this.DetermineWinningPlayer();
      }
      
      public function DetermineWinningPlayer() : *
      {
         var _loc1_:* = undefined;
         switch(this.whoGoesFirst)
         {
            case 1:
               if(this.winningPlayer == 3)
               {
                  this.winningPlayer = 0;
               }
               else
               {
                  this.winningPlayer = this.winningPlayer + 1;
               }
               break;
            case 2:
               if(this.winningPlayer == 0 || this.winningPlayer == 1)
               {
                  this.winningPlayer = this.winningPlayer + 2;
               }
               else
               {
                  this.winningPlayer = this.winningPlayer - 2;
               }
               break;
            case 3:
               if(this.winningPlayer == 0)
               {
                  this.winningPlayer = 3;
               }
               else
               {
                  this.winningPlayer = this.winningPlayer - 1;
               }
         }
         if(this.winningPlayer != 0)
         {
            _loc1_ = this.winningPlayer - 1;
         }
         else
         {
            _loc1_ = 3;
         }
         this.theGame.AI1.whoCalledTrumpTextBox.text = "";
         this.theGame.AI2.whoCalledTrumpTextBox.text = "";
         this.theGame.AI3.whoCalledTrumpTextBox.text = "";
         this.theGame.AI1.whoCalledTrumpTextBox.text = "   " + this.theGame.AI1.aiName[_loc1_] + " won the trick.";
         this.UpdateTrickScore();
      }
      
      public function UpdateTrickScore() : *
      {
         if(this.winningPlayer == 0 || this.winningPlayer == 2)
         {
            this.team0TrickScore++;
         }
         else if(this.winningPlayer == 1 || this.winningPlayer == 3)
         {
            this.team1TrickScore++;
         }
         this.theGame.trickScoreBox.text = "Trick Score\nTeam 1: " + this.team0TrickScore + "    Team 2: " + this.team1TrickScore;
         this.numTricks++;
         this.whoGoesFirst = this.winningPlayer;
         trace("in update trick scores wgf= " + this.whoGoesFirst);
         if(this.whoGoesFirst != 0)
         {
            this.delayFirstPlayTimer.start();
         }
         else
         {
            this.PlayTricks(this.theGame.Human,this.theGame.AI1,this.theGame.AI2,this.theGame.AI3);
         }
      }
      
      function delayFirstPlay(param1:TimerEvent) : *
      {
         this.delayFirstPlayTimer.stop();
         this.PlayTricks(this.theGame.Human,this.theGame.AI1,this.theGame.AI2,this.theGame.AI3);
      }
      
      public function ResetTrickScores() : *
      {
         this.team0TrickScore = 0;
         this.team1TrickScore = 0;
         this.theGame.trickScoreBox.text = "Trick Score\nTeam 1: " + this.team0TrickScore + "    Team 2: " + this.team1TrickScore;
      }
      
      public function ReturnScores() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:* = new Array();
         if(this.whoCalledTrump == 0 || this.whoCalledTrump == 2)
         {
            if(this.team0TrickScore == 5)
            {
               _loc2_ = 2;
               _loc3_ = 0;
            }
            else if(this.team0TrickScore == 4)
            {
               _loc2_ = 1;
               _loc3_ = 0;
            }
            else if(this.team0TrickScore == 3)
            {
               _loc2_ = 1;
               _loc3_ = 0;
            }
            else
            {
               _loc2_ = 0;
               _loc3_ = 2;
            }
            _loc1_[0] = _loc2_;
            _loc1_[1] = _loc3_;
            return _loc1_;
         }
         if(this.whoCalledTrump == 1 || this.whoCalledTrump == 3)
         {
            if(this.team1TrickScore == 5)
            {
               _loc2_ = 0;
               _loc3_ = 2;
            }
            else if(this.team1TrickScore == 4)
            {
               _loc2_ = 0;
               _loc3_ = 1;
            }
            else if(this.team1TrickScore == 3)
            {
               _loc2_ = 0;
               _loc3_ = 1;
            }
            else
            {
               _loc2_ = 2;
               _loc3_ = 0;
            }
            _loc1_[0] = _loc2_;
            _loc1_[1] = _loc3_;
            return _loc1_;
         }
      }
   }
}
