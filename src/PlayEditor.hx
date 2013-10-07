//
//  PlayEditor.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;

import BoundType;

class PlayEditor extends Sprite
{
	var data:Dynamic;
	var w:Int;
	var h:Int;
	public var mapH:Array<Int>;
	public var mapV:Array<Int>;
	var startX:Int;
	var startY:Int;
	var goalX:Int;
	var goalY:Int;
	var borderSprite:Array<Border>;
	var bounds:Array<Bound>;
	var beButtons:Array<BoundEditorButton>;
	var ball:Ball;
	var goal:Goal;
	public var curBB:BoundButton;

	var s : SpinnerState;
	
	public function new(s:SpinnerState)
	{
		super();
		this.s = s;
		curBB = null;
		borderSprite = [];
		bounds = [];
		beButtons = [];
		ball = new Ball();
		goal = new Goal();
		addChild(ball);
		addChild(goal);
	}
	
	public function init(data:Dynamic)
	{
		this.data = data;
		this.w = data.width;
		this.h = data.height;
		this.mapH = data.mapH.copy();
		this.mapV = data.mapV.copy();
		this.startX = data.startX;
		this.startY = data.startY;
		this.goalX = data.goalX;
		this.goalY = data.goalY;
		
		goal.x = Bound.size*goalX;
		goal.y = Bound.size*goalY;
		
		ball.x = Bound.size*startX;
		ball.y = Bound.size*startY;
		
		var wf = Bound.size*w;
		var hf = Bound.size*h;
		var g = graphics;
		g.clear();
		for(i in 0...w-1)
		{
			var x = Bound.size*(i+1);
			g.lineStyle(1, 0xbbbbbb);
			g.moveTo(x, 0);
			g.lineTo(x, hf);
		}
		for(j in 0...h-1)
		{
			var y = Bound.size*(j+1);
			g.lineStyle(1, 0xbbbbbb);
			g.moveTo(0, y);
			g.lineTo(wf, y);
		}
		
		var beCount = 0;
		for(n in mapH)
		{
			if(n==0) beCount++;
		}
		for(n in mapV)
		{
			if(n==0) beCount++;
		}
		
		var border:Border;
		var borderCount = 2*(w+h);
		if(borderSprite.length < borderCount)
		{
			for(n in 0...borderCount-borderSprite.length)
			{
				border = new Border(0);
				addChild(border);
				borderSprite.push(border);
			}
		} else if(borderSprite.length > borderCount)
		{
			for(n in 0...borderSprite.length-borderCount)
			{
				border = borderSprite.pop();
				removeChild(border);
			}
		}
		
		var beButton:BoundEditorButton;
		if(beButtons.length < beCount)
		{
			for(n in 0...beCount-beButtons.length)
			{
				beButton = new BoundEditorButton(true, None);
				beButton.click = callback(beButtonClick, beButton);
				addChild(beButton.sprite);
				beButtons.push(beButton);
				s.addButton(beButton);
			}
		} else if(beButtons.length > beCount)
		{
			for(n in 0...beButtons.length-beCount)
			{
				beButton = beButtons.pop();
				beButton.click = null;
				removeChild(beButton.sprite);
				s.removeButton(beButton);
			}
		}
		
		var bCount = mapH.length+mapV.length-beCount;
		var bound:Bound;
		if(bounds.length < bCount)
		{
			for(n in 0...bCount-bounds.length)
			{
				bound = new Bound(true, None);
				addChild(bound);
				bounds.push(bound);
			}
		} else if(bounds.length > bCount)
		{
			for(n in 0...bounds.length-bCount)
			{
				bound = bounds.pop();
				removeChild(bound);
			}
		}
		
		var borderIndex = 0;
		for(n in 0...w)
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
		for(n in 0...h)
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
		
		var bIndex = 0;
		var beIndex = 0;
		for(j in 0...h)
		{
			for(i in 0...w)
			{
				if(i < w-1)
				{
					var t = mapV[j*(w-1)+i];
					if(t==0)
					{
						var be = beButtons[beIndex++];
						be.init(false, None);
						be.setXY(Bound.size*(1+i), Bound.size*j);
						be.posX = i;
						be.posY = j;
						be.boundButton = null;
					} else
					{
						var b = bounds[bIndex++];
						switch(t)
						{
							case 0: b.init(false, None); // not possible
							case 1: b.init(false, Normal);
							case 2: b.init(false, OneSide(true));
							case 3: b.init(false, OneSide(false));
							case 4: b.init(false, Hollow);
							default: b.init(false, Count(t-4));
						}
						b.x = Bound.size*(1+i);
						b.y = Bound.size*j;
					}
				}
				
				if(j < h-1)
				{
					var t = mapH[j*w+i];
					if(t==0)
					{
						var be = beButtons[beIndex++];
						be.init(true, None);
						be.setXY(Bound.size*i, Bound.size*(1+j));
						be.posX = i;
						be.posY = j;
						be.boundButton = null;
					} else
					{
						var b = bounds[bIndex++];
						switch(t)
						{
							case 0: b.init(true, None); // not possible
							case 1: b.init(true, Normal);
							case 2: b.init(true, OneSide(true));
							case 3: b.init(true, OneSide(false));
							case 4: b.init(true, Hollow);
							default: b.init(true, Count(t-4));
						}
						b.x = Bound.size*i;
						b.y = Bound.size*(1+j);
					}
				}
			}
		}
	}
	
	function beButtonClick(beButton:BoundEditorButton)
	{
		var old:Int = 0;
		var cur:Int = 0;
		switch(beButton.type)
		{
			case None: old = 0;
			case Normal: old = 1;
			case OneSide(leftUp): old = (leftUp)?2:3;
			case Hollow: old = 4;
			case Count(count): old = count+4;
		}
		if(curBB!=null)
		{
			switch(curBB.type)
			{
				case None:
				case Normal: cur = 1;
				case OneSide(leftUp): cur = (old!=2)?2:3;
				case Hollow: cur = 4;
				case Count(count): cur = count+4;
			}
		} else cur = 0;
		
		if(!((old==2&&cur==3)||(old==3&&cur==2)))
		{
			if(curBB==beButton.boundButton) return;
			if(curBB!=null&&curBB.count==0) return;
		}
		
		switch(cur)
		{
			case 0: beButton.changeType(None); 
			case 1: beButton.changeType(Normal);
			case 2: beButton.changeType(OneSide(true));
			case 3: beButton.changeType(OneSide(false));
			case 4: beButton.changeType(Hollow);
			default: beButton.changeType(Count(cur-4));
		}
		
		if((old!=2&&cur!=3)||(old!=3&&cur!=2))
		{
			var bb = beButton.boundButton;
			if(bb!=null) bb.setCount(bb.count+1);
			if(curBB!=null) curBB.setCount(curBB.count-1);
			beButton.boundButton = curBB;
		}
		
		if(beButton.horizontal)
		{
			mapH[beButton.posY*w+beButton.posX] = cur;
		} else
		{
			mapV[beButton.posY*(w-1)+beButton.posX] = cur;
		}
	}
}