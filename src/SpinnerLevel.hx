//
//  SpinnerLevel.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/14/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;

import manaGearz.graphic.S9G;
import manaGearz.button.SpriteButton;
import manaGearz.button.ButtonState;
import manaGearz.state.SpriteState;
import manaGearz.fsm.FSM;
import manaGearz.manager.Manager;
import manaGearz.math.MathEx;

import SequenceType;
import BoundType;

class SpinnerLevel extends SpinnerState
{
	public static inline var step:Int = 30;
	public static inline var ballStep:Int = 5;
	
	var data:Dynamic;
	
	var name:String;
	var author:String;
	var description:String;
	var width:Int;
	var height:Int;
	var startX:Int;
	var startY:Int;
	var goalX:Int;
	var goalY:Int;
	var mapH:Array<Int>;
	var mapV:Array<Int>;
	var sequence:Array<Int>;
	var bound:Array<Int>;
	
	var wf:Float;
	var hf:Float;
	var display:Sprite;
	var rotator:Sprite;
	var scalator:Sprite;
	var fitter:Sprite;
	var startButton:SpinnerButton;
	var resetButton:SpinnerButton;
	var pauseButton:SpinnerButton;
	var borderSprite:Array<Border>;
	var mapHSprite:Array<Bound>;
	var mapVSprite:Array<Bound>;
	var sequenceSprite:Array<Sequence>;
	var boundButton:Array<BoundButton>;
	var ball:Ball;
	var goal:Goal;
	var editor:PlayEditor;
	var editorFitter:Sprite;
	var background:S9G;
	
	var size:Float;
	
	var isPlaying:Bool;
	var ballMoving:Bool;
	var curSeq:Int;
	var curStep:Int;
	var curBallStep:Int;
	var state:Int;
	var flip:Bool;
	var lastHollow:Bool;
	var playSwoosh:Bool;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		size = Bound.size;
		borderSprite = [];
		mapHSprite = [];
		mapVSprite = [];
		sequenceSprite = [];
		boundButton = [];
		wf = 0;
		hf = 0;
		
		editor = new PlayEditor(this);
		editorFitter = new Sprite();
		editorFitter.addChild(editor);
		
		goal = new Goal();
		ball = new Ball();
		
		display = new Sprite();
		display.addChild(goal);
		display.addChild(ball);
		
		rotator = new Sprite();
		rotator.addChild(display);
		
		scalator = new Sprite();
		scalator.addChild(rotator);
		
		fitter = new Sprite();
		fitter.addChild(scalator);
		
		startButton = new SpinnerButton("START");
		startButton.setXYWH(0,0,100,50);
		startButton.click = startClick;
		addButton(startButton);
		
		pauseButton = new SpinnerButton("||");
		pauseButton.setXYWH(100,0,50,50);
		pauseButton.click = pauseClick;
		addButton(pauseButton);
		
		resetButton = new SpinnerButton("RESET");
		resetButton.setXYWH(150,0,100,50);
		resetButton.click = resetClick;
		addButton(resetButton);
		
		background = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		background.setXYWH(0,0,250,250);
		
		mainBox.addChild(background.sprite);
		mainBox.addChild(fitter);
		mainBox.addChild(editorFitter);
		thirdBox.addChild(startButton.sprite);
		thirdBox.addChild(pauseButton.sprite);
		thirdBox.addChild(resetButton.sprite);
	}
	
	public function startClick()
	{
		//Manager.sound.playSFX("tap");
		start();
	}
	
	public function pauseClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState("pause", "spinner", {execFirst:false, execSecond:false, nextInit:{prevState:Manager.gameState.curStateName}});
	}
	
	public function resetClick()
	{
		//Manager.sound.playSFX("tap");
		reset();
	}
	
	public function nextClick()
	{
		//Manager.sound.playSFX("tap");
		LevelManager.instance.nextLevel();
	}
	
	public function start()
	{
		mapH = editor.mapH.copy();
		mapV = editor.mapV.copy();
		
		isPlaying = true;
		startButton.setDisabled(true);
		resetButton.setDisabled(false);
		for(n in boundButton)
		{
			n.setToggled(false);
			n.setDisabled(true);
		}
		editor.curBB = null;
		
		editorFitter.visible = false;
		fitter.visible = true;
		
		for(j in 0...height)
		{
			for(i in 0...width)
			{
				if(i < width-1)
				{
					var t = mapV[j*(width-1)+i];
					var s = mapVSprite[j*(width-1)+i];
					switch(t)
					{
						case 0: s.init(false, None);
						case 1: s.init(false, Normal);
						case 2: s.init(false, OneSide(true));
						case 3: s.init(false, OneSide(false));
						case 4: s.init(false, Hollow);
						default: s.init(false, Count(t-4));
					}
					s.x = size*(1+i);
					s.y = size*j;
				}
				
				if(j < height-1)
				{
					var t = mapH[j*width+i];
					var s = mapHSprite[j*width+i];
					switch(t)
					{
						case 0: s.init(true, None);
						case 1: s.init(true, Normal);
						case 2: s.init(true, OneSide(true));
						case 3: s.init(true, OneSide(false));
						case 4: s.init(true, Hollow);
						default: s.init(true, Count(t-4));
					}
					s.x = size*i;
					s.y = size*(1+j);
				}
			}
		}
	}
	
	public function reset()
	{
		isPlaying = false;
		ballMoving = true;
		curSeq = 0;
		curStep = 0;
		curBallStep = 0;
		state = 0;
		flip = false;
		lastHollow = false;
		
		startX = data.startX;
		startY = data.startY;
		goalX = data.goalX;
		goalY = data.goalY;
		
		rotator.rotation = 0;
		scalator.scaleY = 1;
		
		goal.x = size*goalX;
		goal.y = size*goalY;
		
		ball.x = size*startX;
		ball.y = size*startY;
		
		startButton.setDisabled(false);
		resetButton.setDisabled(true);
		for(n in boundButton)
		{
			n.setDisabled(false);
		}
		
		for(n in sequenceSprite)
		{
			n.setComplete(false);
		}
		
		editorFitter.visible = true;
		fitter.visible = false;
	}
	
	public function complete()
	{
		//trace("complete");
		isPlaying = false;
		resetButton.setDisabled(false);
		resetButton.setLabel("NEXT");
		resetButton.click = nextClick;
	}
	
	public function stuck()
	{
		isPlaying = false;
		resetButton.setDisabled(false);
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		if(d==null) return;
		
		data = d;
		name = d.name;
		author = d.author;
		description = d.description;
		width = d.width;
		height = d.height;
		bound = data.bound.copy();
		sequence = data.sequence.copy();
		
		resetButton.setLabel("RESET");
		resetButton.click = reset;
		
		wf = size*width;
		hf = size*height;
		var longest = MathEx.sqrt(wf*wf+hf*hf);
		display.x = editor.x = wf*-0.5;
		display.y = editor.y = hf*-0.5;
		fitter.x = editorFitter.x = 125;
		fitter.y = editorFitter.y = 125;
		fitter.scaleX = editorFitter.scaleX = 238/longest;
		fitter.scaleY = editorFitter.scaleY = 238/longest;
		
		editor.init(d);
		
		var g = display.graphics;
		g.clear();
		for(i in 0...width-1)
		{
			var x = size*(i+1);
			g.lineStyle(1, 0xbbbbbb);
			g.moveTo(x, 0);
			g.lineTo(x, hf);
		}
		for(j in 0...height-1)
		{
			var y = size*(j+1);
			g.lineStyle(1, 0xbbbbbb);
			g.moveTo(0, y);
			g.lineTo(wf, y);
		}
		
		var border:Border;
		var borderCount = 2*(width+height);
		if(borderSprite.length < borderCount)
		{
			for(n in 0...borderCount-borderSprite.length)
			{
				border = new Border(0);
				display.addChild(border);
				borderSprite.push(border);
			}
		} else if(borderSprite.length > borderCount)
		{
			for(n in 0...borderSprite.length-borderCount)
			{
				border = borderSprite.pop();
				display.removeChild(border);
			}
		}
		
		var b:Bound;
		var countV = (width-1)*height;
		if(mapVSprite.length < countV)
		{
			for(n in 0...countV-mapVSprite.length)
			{
				b = new Bound(true, None);
				display.addChild(b);
				mapVSprite.push(b); // add needed bound
			}
		} else if(mapVSprite.length > countV)
		{
			for(n in 0...mapVSprite.length-countV)
			{
				b = mapVSprite.pop(); // remove unused bound
				display.removeChild(b);
			}
		}
		
		var countH = width*(height-1);
		if(mapHSprite.length < countH)
		{
			for(n in 0...countH-mapHSprite.length)
			{
				b = new Bound(true, None);
				display.addChild(b);
				mapHSprite.push(b); // add needed bound
			}
		} else if(mapHSprite.length > countH)
		{
			for(n in 0...mapHSprite.length-countH)
			{
				b = mapHSprite.pop(); // remove unused bound
				display.removeChild(b);
			}
		}
		
		var s:Sequence;
		var countSequence = d.sequence.length;
		if(sequenceSprite.length < countSequence)
		{
			for(n in 0...countSequence-sequenceSprite.length)
			{
				s = new Sequence(false, CW);
				firstBox.addChild(s);
				sequenceSprite.push(s);
			}
		} else if(sequenceSprite.length > countSequence)
		{
			for(n in 0...sequenceSprite.length-countSequence)
			{
				s = sequenceSprite.pop();
				firstBox.removeChild(s);
			}
		}
		
		var bb:BoundButton;
		var bbC = Std.int(d.bound.length/2);
		if(boundButton.length < bbC)
		{
			for(n in 0...bbC-boundButton.length)
			{
				bb = new BoundButton(None, 0);
				bb.click = callback(boundButtonClick, bb);
				secondBox.addChild(bb.sprite);
				boundButton.push(bb);
				addButton(bb);
			}
		} else if(boundButton.length > bbC)
		{
			for(n in 0...boundButton.length-bbC)
			{
				bb = boundButton.pop();
				bb.click = null;
				secondBox.removeChild(bb.sprite);
				removeButton(bb);
			}
		}
		
		var borderIndex = 0;
		for(n in 0...width)
		{
			border = borderSprite[borderIndex++];
			border.init(1);
			border.x = n*Bound.size;
			border.y = 0;
			border = borderSprite[borderIndex++];
			border.init(3);
			border.x = n*Bound.size;
			border.y = hf;
		}
		for(n in 0...height)
		{
			border = borderSprite[borderIndex++];
			border.init(0);
			border.x = 0;
			border.y = n*Bound.size;
			border = borderSprite[borderIndex++];
			border.init(2);
			border.x = wf;
			border.y = n*Bound.size;
		}
		
		for(n in 0...Std.int(bound.length/2))
		{
			var c = bound[n*2];
			var t = bound[n*2+1];
			var b = boundButton[n];
			switch(t)
			{
				case 0: throw("Gak bisa yang type None/0");
				case 1: b.init(Normal, c);
				case 2: b.init(OneSide(true), c);
				case 3: throw("Harus pake type OneSide(true)/2 bukan OneSide(false)/3");
				case 4: b.init(Hollow, c);
				default: b.init(Count(t-4), c);
			}
			b.setX(n*50);
		}
			
		for(n in 0...sequence.length)
		{
			var t = sequence[n];
			var s = sequenceSprite[n];
			switch(t)
			{
				case 0: s.init(false, CW);
				case 1: s.init(false, CCW);
				case 2: s.init(false, Flip);
			}
			s.x = (n%10)*25;
			s.y = Std.int(n/10)*25;
		}
		
		reset();
	}
	
	function boundButtonClick(bb:BoundButton)
	{
		Manager.sound.playSFX("tap");
		if(!bb.toggled)
		{
			editor.curBB = null;
		} else
		{
			for(n in boundButton)
			{
				if(n==bb)
				{
					editor.curBB = n;
					continue;
				}
				n.setToggled(false);
			}
		}
	}
	
	public override function execute()
	{
		super.execute();
		if(!isPlaying) return;
		if(curSeq >= sequence.length && !ballMoving)
		{
			if(startX==goalX && startY==goalY) complete() else stuck();
			return;
		}
		if(!ballMoving) // change state
		{
			if(playSwoosh)
			{
				Manager.sound.playSFX("swoosh");
				playSwoosh = false;
			}
			curStep++;
			switch(sequence[curSeq])
			{
				case 0: rotator.rotation = state*90 + (flip? -curStep/step*90 : curStep/step*90);
				case 1: rotator.rotation = state*90 + (flip? curStep/step*90 : -curStep/step*90);
				case 2: scalator.scaleY = (flip)? curStep/step*2-1 : 1-curStep/step*2;
			}
			
			if(curStep == step)
			{
				switch(sequence[curSeq])
				{
					case 0:
						state = if(!flip) (state==3)? 0 : state+1 else (state==0)? 3 : state-1;
						sequenceSprite[curSeq].init(true, CW);
					case 1:
						state = if(!flip) (state==0)? 3 : state-1 else (state==3)? 0 : state+1;
						sequenceSprite[curSeq].init(true, CCW);
					case 2:
						flip = !flip;
						sequenceSprite[curSeq].init(true, Flip);
				}
				curStep = 0;
				curSeq++;
				ballMoving = true;
			}
		} else // move Ball
		{
			var s = state+(flip?4:0);
			var h:Bool = true;
			var n:Null<Int> = null;
			switch(s) // check can move or not
			{
				case 0,6:
					if(startY==height-1)
					{
						ballMoving = false;
						Manager.sound.playSFX("tap");
						playSwoosh = true;
					}else
					{
						n = startY*width+startX;
						h = true;
					}
				case 1,7:
					if(startX==width-1)
					{
						ballMoving = false;
						Manager.sound.playSFX("tap");
						playSwoosh = true;
					}else
					{
						n = startY*(width-1)+startX;
						h = false;
					}
				case 2,4:
					if(startY==0)
					{
						ballMoving = false;
						Manager.sound.playSFX("tap");
						playSwoosh = true;
					}else
					{
						n = (startY-1)*width+startX;
						h = true;
					}
				case 3,5:
					if(startX==0)
					{
						ballMoving = false;
						Manager.sound.playSFX("tap");
						playSwoosh = true;
					}else
					{
						n = startY*(width-1)+startX-1;
						h = false;
					}
			}
			if(n!=null)
			{
				var b:Int = h?mapH[n]:mapV[n];
				switch(b)
				{
					case 0:
					case 1: ballMoving = false; Manager.sound.playSFX("tap"); playSwoosh = true;
					case 2: if(s==2||s==4||s==3||s==5) ballMoving = false;
					case 3: if(s==0||s==6||s==1||s==7) ballMoving = false;
					case 4: lastHollow = true;
					default:
						var disappear = (b-1==4);
						if(h)
						{
							if(disappear)
							{
								mapH[n] = 0;
								mapHSprite[n].init(true, None);
							} else
							{
								mapH[n] = b-1;
								mapHSprite[n].init(true, Count(b-5));
							}
						}else
						{
							if(disappear)
							{
								mapV[n] = 0;
								mapVSprite[n].init(false, None);
							} else
							{
								mapV[n] = b-1;
								mapVSprite[n].init(false, Count(b-5));
							}
						}
						ballMoving = false;
						Manager.sound.playSFX("tap");
						playSwoosh = true;
				}
			}
			if(!ballMoving) return;
			curBallStep++;
			switch(s)
			{
				case 0,6: ball.y = (startY + curBallStep/ballStep)*size;
				case 1,7: ball.x = (startX + curBallStep/ballStep)*size;
				case 2,4: ball.y = (startY - curBallStep/ballStep)*size;
				case 3,5: ball.x = (startX - curBallStep/ballStep)*size;
			}
			
			if(curBallStep == ballStep)
			{
				if(lastHollow)
				{
					if(h)
					{
						mapH[n] = 1;
						mapHSprite[n].init(true, Normal);
					}else
					{
						mapV[n] = 1;
						mapVSprite[n].init(false, Normal);
					}
					lastHollow = false;
				}
				switch(s)
				{
					case 0,6: startY++;
					case 1,7: startX++;
					case 2,4: startY--;
					case 3,5: startX--;
				}
				curBallStep = 0;
			}
		}
	}
}