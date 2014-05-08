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
		public var neustart:TextField = new TextField;
		public var format:TextFormat = new TextFormat();
		public var yPos:Number = stage.stageHeight / 2 - enemy.height /2;
		public var random:Number=0;
		
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
			
		}
		
		public function timerHandler(event:TimerEvent):void
		{
			kollision();
			drawCircle(positionX,positionY);
			//drawPlayer(playerPositionY);
			positionX = speed * directionX + positionX;
			positionY = speed * directionY + positionY;
			//trace(stage.stageHeight);
			drawEnemy(positionY,directionY);
			
			format.color = 0xFFFFFF; 
			format.size = 48; 
			format.font = "OCR A Std";
			
			score1.defaultTextFormat = format;
			score2.defaultTextFormat = format;
			
			if (scorePlayer1 < 7)
			{
				score1.text = scorePlayer1.toString();
			}	
			else
			{
				endscreen.defaultTextFormat = format;
				endscreen.width = 900;
				endscreen.height = 50;
				endscreen.x = stage.stageWidth / 2 - 200;
				endscreen.y = stage.stageHeight / 2 - 50;
				endscreen.text = "PLAYER 1 WINS";
				addChild(endscreen);
				spielAnhalten();
			}
				
			if (scorePlayer2 < 7)
			{
				score2.text = scorePlayer2.toString();
			}
			else
			{
				endscreen.defaultTextFormat = format;
				endscreen.width = 900;
				endscreen.height = 50;
				endscreen.x = stage.stageWidth / 2 - 200;
				endscreen.y = stage.stageHeight / 2 - 50;
				endscreen.text = "PLAYER 2 WINS";
				addChild(endscreen);
				spielAnhalten();
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
				positionY = Math.floor(Math.random() * 599 + 1);
				directionX = 1;
				directionY = 1;
				yPos = stage.stageHeight / 2 - enemy.height /2;
				random = 0;
				trace(0);
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
				positionY = Math.floor(Math.random() * 599 + 1);;
				directionX = 1;
				directionY = 1;
				yPos = stage.stageHeight / 2 - enemy.height /2;
				random = 0;
			}
			if (enemy.hitTestObject(circle))
			{
				directionX = -1
				random += Math.random() * directionY * 5;
				trace(random);
				
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
		
		public function spielAnhalten(): void {
			directionX = 0;
			directionY = 0;
			circle.visible = false;
			neustart.defaultTextFormat = format;
			neustart.width = 900;
			neustart.height = 50;
			neustart.x = stage.stageWidth / 2 - 80;
			neustart.y = stage.stageHeight / 2;
			neustart.text = "AGAIN?";
			addChild(neustart);
			neustart.addEventListener(MouseEvent.CLICK, spielNeustarten);
		}
		
		public function spielNeustarten(event:MouseEvent): void {
			event.target.removeEventListener(MouseEvent.CLICK, spielNeustarten);
			directionX = 1;
			directionY = 1;
			circle.visible = true;
			removeChild(endscreen);
			removeChild(neustart);
			scorePlayer1 = 0;
			scorePlayer2 = 0;
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
		
		public function drawEnemy(posisionY:Number, directionY:Number):void
		{
			
			enemy.graphics.clear();
			enemy.graphics.lineStyle(0);
			enemy.graphics.beginFill(0xFFFFFF,1);			
			enemy.graphics.drawRect(stage.stageWidth - 10, yPos  , -10, 50);
			yPos = (positionY - (enemy.height / 2)) + random;
			if (yPos <= 0)
			{
				yPos = 0;
			}
			if (yPos + enemy.height >= stage.stageHeight)
			{
				yPos = yPos + enemy.height;
			}
			//trace(enemy.height);
			enemy.graphics.endFill();
			addChild(enemy);
		}
	}
}