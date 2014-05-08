package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.sensors.Accelerometer;
	import flash.text.*;
	import flash.utils.Timer;
	
	import flashx.textLayout.accessibility.TextAccImpl;
	
	
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	public class Pong extends Sprite
	{
		trace(0);
		trace(1);
		trace("Hallo");
		public var player:Sprite = new Sprite()
		public var enemy:Sprite = new Sprite()
		public var circle:Sprite = new Sprite()
		public var positionX:Number = 15;
		public var positionY:Number = 15;
		public var directionX:Number = 1;
		public var directionY:Number = 1;
		public var speed:Number = 5;
		public var playerPositionY:Number = 50;
		public var scorePlayer1:Number = 0;
		public var scorePlayer2:Number = 0;
		public var score1:TextField = new TextField;
		public var score2:TextField = new TextField;
		public var endscreen:TextField = new TextField;
		public var yPos:Number = stage.stageHeight / 2 - enemy.height /2;
		
		public function Pong()
		{
			
			stage.color = 0x000000;
			
			var myTimer:Timer = new Timer(1,0);
			score1.x = stage.stageWidth / 2 - 100;
			score1.y = 10;
			
			score2.x = stage.stageWidth / 2 + 100;
			score2.y = 10;
			
			addChild(score1);
			addChild(score2);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			myTimer.start();
			player.hitArea = circle;
			enemy.hitArea = circle;
			
			trace(player.hitArea);
			trace(circle.hitArea);
			
		}
		
		public function timerHandler(event:TimerEvent):void
		{
			kollision();
			drawCircle(positionX,positionY);
			//drawPlayer(playerPositionY);
			positionX = speed * directionX + positionX;
			positionY = speed * directionY + positionY;
			trace(stage.stageHeight);
			drawEnemy(directionY);
			
			var format:TextFormat = new TextFormat(); 
			format.color = 0xFFFFFF; 
			format.size = 48; 
			format.font = "OCR A Std";
			
			score1.defaultTextFormat = format;
			score2.defaultTextFormat = format;
			
			if (scorePlayer1 < 1)
			{
				score1.text = scorePlayer1.toString();
			}	
			else
			{
				endscreen.defaultTextFormat = format;
				endscreen.width = 900;
				endscreen.height = 50;
				endscreen.x = stage.stageWidth / 2 - 50;
				endscreen.y = stage.stageHeight / 2 - 50;
				endscreen.text = "PLAYER 1 WINS";
				addChild(endscreen);
			}
				
			if (scorePlayer2 < 1)
			{
				score2.text = scorePlayer2.toString();
			}
			else
			{
				endscreen.defaultTextFormat = format;
				endscreen.width = 900;
				endscreen.height = 50;
				endscreen.x = stage.stageWidth / 2 - 50;
				endscreen.y = stage.stageHeight / 2 - 50;
				endscreen.text = "PLAYER 2 WINS";
				addChild(endscreen);
			}
			
			
		}
		
		public function kollision():void
		{
			if ((positionX + circle.height / 2)>= stage.stageWidth)
			{
				scorePlayer1++;
				circle.graphics.clear();
				enemy.graphics.clear();
				removeChild(circle);
				removeChild(enemy);
				positionX = 30;
				positionY = 30;
				directionX = 1;
				directionY = 1;
				yPos = stage.stageHeight / 2 - enemy.height /2;
			}
			if (player.hitTestObject(circle))
			{
				directionX = 1;
			}
			if (positionX < circle.height / 2)
			{
				scorePlayer2++;
				circle.graphics.clear();
				enemy.graphics.clear();
				removeChild(circle);
				removeChild(enemy);
				positionX = 30;
				positionY = 30;
				directionX = 1;
				directionY = 1;
				yPos = stage.stageHeight / 2 - enemy.height /2;
			}
			if (enemy.hitTestObject(circle))
			{
				directionX = -1
			}
			if ((positionY + circle.height / 2)>= stage.stageHeight)
			{
				directionY = -1;
			}
			if (positionY < circle.height / 2)
			{
				directionY = 1;
			} 
		}
		
		public function onMouseMove(move:MouseEvent): void
		{
			drawPlayer(move.localY);
		}
		
		public function drawCircle(x:Number, y:Number):void
		{
			circle.graphics.clear();
			circle.graphics.lineStyle(0);
			circle.graphics.beginFill(0xFFFFFF,1);
			circle.graphics.drawCircle(x,y,15);
			circle.graphics.endFill();
			addChild(circle);
		}
		
		public function drawPlayer(y:Number):void
		{
			player.graphics.clear();
			player.graphics.lineStyle(0);
			player.graphics.beginFill(0xFFFFFF,1);
			if ((y + 50) >= stage.stageHeight)
			{
				y = stage.stageHeight - 50;
			}
			player.graphics.drawRect(10,y, 10,50);
			player.graphics.endFill();
			addChild(player);
		}
		
		public function drawEnemy(y:Number):void
		{
			
			enemy.graphics.clear();
			enemy.graphics.lineStyle(0);
			enemy.graphics.beginFill(0xFFFFFF,1);
			if ((y == 1) && ((yPos + 50) <= stage.stageHeight) )
			{
				if (positionX < stage.stageWidth / 2)
					{
						yPos = yPos+2;
					}
				if (positionX < stage.stageWidth / 3)
					{
						yPos = yPos+1;
					}
				else
					{
						yPos = yPos+4;	
					}
			}
			if((y == -1) && (yPos >=0))
			{	
				if (positionX < stage.stageWidth / 2)
					{
						yPos = yPos-2;
					}
				if (positionX < stage.stageWidth / 3)
					{
						yPos = yPos-1;
					}
				else
					{
						yPos = yPos-4;
					}
				
			}	
			
			enemy.graphics.drawRect(stage.stageWidth - 10, yPos  , -10, 50);
			enemy.graphics.endFill();
			addChild(enemy);
		}
	}
}