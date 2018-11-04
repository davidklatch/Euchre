package
{
   public class Deck
   {
       
      
      public var stack;
      
      var currentSize;
      
      const SIZE = 24;
      
      var cardBmps;
      
      public var cardSprites;
      
      var theParent;
      
      public function Deck(param1:*)
      {
         super();
         this.theParent = param1;
         this.stack = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < 24)
         {
            this.stack[_loc2_] = new Card();
            _loc2_++;
         }
         this.currentSize = 24;
         this.cardBmps = new Array();
         this.cardSprites = new Array();
         this.fillCardSprites();
      }
      
      public function CreateDeck() : *
      {
         var _loc1_:* = new Array(this.SIZE);
         var _loc2_:* = new Array(this.SIZE);
         var _loc3_:* = 9;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         while(_loc5_ < this.SIZE)
         {
            if(_loc5_ % 6 == 0)
            {
               _loc4_++;
               _loc3_ = 9;
            }
            _loc1_[_loc5_] = _loc4_ - 1;
            _loc2_[_loc5_] = _loc3_;
            _loc3_++;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.SIZE)
         {
            this.stack[_loc5_].suit = _loc1_[_loc5_];
            this.stack[_loc5_].value = _loc2_[_loc5_];
            this.stack[_loc5_].priority = _loc2_[_loc5_];
            this.stack[_loc5_].sprite = this.cardSprites[_loc5_];
            _loc5_++;
         }
      }
      
      public function ShuffleDeck() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         this.currentSize = this.SIZE;
         var _loc3_:* = 0;
         while(_loc3_ < this.SIZE)
         {
            _loc1_ = Math.floor(Math.random() * 23);
            _loc2_ = this.stack[_loc3_];
            this.stack[_loc3_] = this.stack[_loc1_];
            this.stack[_loc1_] = _loc2_;
            _loc3_++;
         }
      }
      
      public function GiveTopCard() : *
      {
         var _loc1_:* = new Card();
         if(this.currentSize != 0)
         {
            _loc1_ = this.stack[this.currentSize - 1];
            this.currentSize--;
            return _loc1_;
         }
      }
      
      public function DealCards(param1:*, param2:*, param3:*, param4:*) : *
      {
         var _loc5_:* = new Card();
         _loc5_ = this.GiveTopCard();
         param2.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param2.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param2.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param3.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param3.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param4.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param4.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param4.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param1.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param1.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param2.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param2.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param3.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param3.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param3.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param4.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param4.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param1.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param1.GetCard(_loc5_);
         _loc5_ = this.GiveTopCard();
         param1.GetCard(_loc5_);
      }
      
      function fillCardSprites() : *
      {
         this.cardBmps[0] = new C9Bmp();
         this.cardSprites[0] = Game.makeSprite(this.cardBmps[0],this.cardBmps[0].width,this.cardBmps[0].height);
         this.theParent.stage.addChild(this.cardSprites[0]);
         this.cardBmps[1] = new C10Bmp();
         this.cardSprites[1] = Game.makeSprite(this.cardBmps[1],this.cardBmps[1].width,this.cardBmps[1].height);
         this.theParent.stage.addChild(this.cardSprites[1]);
         this.cardBmps[2] = new C11Bmp();
         this.cardSprites[2] = Game.makeSprite(this.cardBmps[2],this.cardBmps[2].width,this.cardBmps[2].height);
         this.theParent.stage.addChild(this.cardSprites[2]);
         this.cardBmps[3] = new C12Bmp();
         this.cardSprites[3] = Game.makeSprite(this.cardBmps[3],this.cardBmps[3].width,this.cardBmps[3].height);
         this.theParent.stage.addChild(this.cardSprites[3]);
         this.cardBmps[4] = new C13Bmp();
         this.cardSprites[4] = Game.makeSprite(this.cardBmps[4],this.cardBmps[4].width,this.cardBmps[4].height);
         this.theParent.stage.addChild(this.cardSprites[4]);
         this.cardBmps[5] = new C14Bmp();
         this.cardSprites[5] = Game.makeSprite(this.cardBmps[5],this.cardBmps[5].width,this.cardBmps[5].height);
         this.theParent.stage.addChild(this.cardSprites[5]);
         this.cardBmps[6] = new D9Bmp();
         this.cardSprites[6] = Game.makeSprite(this.cardBmps[6],this.cardBmps[6].width,this.cardBmps[6].height);
         this.theParent.stage.addChild(this.cardSprites[6]);
         this.cardBmps[7] = new D10Bmp();
         this.cardSprites[7] = Game.makeSprite(this.cardBmps[7],this.cardBmps[7].width,this.cardBmps[7].height);
         this.theParent.stage.addChild(this.cardSprites[7]);
         this.cardBmps[8] = new D11Bmp();
         this.cardSprites[8] = Game.makeSprite(this.cardBmps[8],this.cardBmps[8].width,this.cardBmps[8].height);
         this.theParent.stage.addChild(this.cardSprites[8]);
         this.cardBmps[9] = new D12Bmp();
         this.cardSprites[9] = Game.makeSprite(this.cardBmps[9],this.cardBmps[9].width,this.cardBmps[9].height);
         this.theParent.stage.addChild(this.cardSprites[9]);
         this.cardBmps[10] = new D13Bmp();
         this.cardSprites[10] = Game.makeSprite(this.cardBmps[10],this.cardBmps[10].width,this.cardBmps[10].height);
         this.theParent.stage.addChild(this.cardSprites[10]);
         this.cardBmps[11] = new D14Bmp();
         this.cardSprites[11] = Game.makeSprite(this.cardBmps[11],this.cardBmps[11].width,this.cardBmps[11].height);
         this.theParent.stage.addChild(this.cardSprites[11]);
         this.cardBmps[12] = new H9Bmp();
         this.cardSprites[12] = Game.makeSprite(this.cardBmps[12],this.cardBmps[12].width,this.cardBmps[12].height);
         this.theParent.stage.addChild(this.cardSprites[12]);
         this.cardBmps[13] = new H10Bmp();
         this.cardSprites[13] = Game.makeSprite(this.cardBmps[13],this.cardBmps[13].width,this.cardBmps[13].height);
         this.theParent.stage.addChild(this.cardSprites[13]);
         this.cardBmps[14] = new H11Bmp();
         this.cardSprites[14] = Game.makeSprite(this.cardBmps[14],this.cardBmps[14].width,this.cardBmps[14].height);
         this.theParent.stage.addChild(this.cardSprites[14]);
         this.cardBmps[15] = new H12Bmp();
         this.cardSprites[15] = Game.makeSprite(this.cardBmps[15],this.cardBmps[15].width,this.cardBmps[15].height);
         this.theParent.stage.addChild(this.cardSprites[15]);
         this.cardBmps[16] = new H13Bmp();
         this.cardSprites[16] = Game.makeSprite(this.cardBmps[16],this.cardBmps[16].width,this.cardBmps[16].height);
         this.theParent.stage.addChild(this.cardSprites[16]);
         this.cardBmps[17] = new H14Bmp();
         this.cardSprites[17] = Game.makeSprite(this.cardBmps[17],this.cardBmps[17].width,this.cardBmps[17].height);
         this.theParent.stage.addChild(this.cardSprites[17]);
         this.cardBmps[18] = new S9Bmp();
         this.cardSprites[18] = Game.makeSprite(this.cardBmps[18],this.cardBmps[18].width,this.cardBmps[18].height);
         this.theParent.stage.addChild(this.cardSprites[18]);
         this.cardBmps[19] = new S10Bmp();
         this.cardSprites[19] = Game.makeSprite(this.cardBmps[19],this.cardBmps[19].width,this.cardBmps[19].height);
         this.theParent.stage.addChild(this.cardSprites[19]);
         this.cardBmps[20] = new S11Bmp();
         this.cardSprites[20] = Game.makeSprite(this.cardBmps[20],this.cardBmps[20].width,this.cardBmps[20].height);
         this.theParent.stage.addChild(this.cardSprites[20]);
         this.cardBmps[21] = new S12Bmp();
         this.cardSprites[21] = Game.makeSprite(this.cardBmps[21],this.cardBmps[21].width,this.cardBmps[21].height);
         this.theParent.stage.addChild(this.cardSprites[21]);
         this.cardBmps[22] = new S13Bmp();
         this.cardSprites[22] = Game.makeSprite(this.cardBmps[22],this.cardBmps[22].width,this.cardBmps[22].height);
         this.theParent.stage.addChild(this.cardSprites[22]);
         this.cardBmps[23] = new S14Bmp();
         this.cardSprites[23] = Game.makeSprite(this.cardBmps[23],this.cardBmps[23].width,this.cardBmps[23].height);
         this.theParent.stage.addChild(this.cardSprites[23]);
      }
   }
}
