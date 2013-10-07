//
//  BoundEditorButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.geom.ColorTransform;

import manaGearz.utils.ColorUtils;
import manaGearz.button.SpriteButton;
import manaGearz.button.ButtonState;

class BoundEditorButton extends SpriteButton
{
	var bound:Bound;
	public var type:BoundType;
	public var horizontal:Bool;
	public var posX:Int;
	public var posY:Int;
	public var boundButton:BoundButton;
	
	var upCT:ColorTransform;
	var overCT:ColorTransform;
	var downCT:ColorTransform;
	var disabledCT:ColorTransform;
	
	public function new(horizontal:Bool, type:BoundType)
	{
		upCT = new ColorTransform();
		overCT = ColorUtils.tintCT(0xFFFFFF, 0.3);
		downCT = ColorUtils.tintCT(0x000000, 0.3);
		disabledCT = ColorUtils.tintCT(0x888888, 0.5);
		
		super({});
		
		bound = new Bound(horizontal, type);
		sprite.addChild(bound);
		
		init(horizontal, type);
	}
	
	public function init(horizontal:Bool, type:BoundType)
	{
		this.horizontal = horizontal;
		this.type = type;
		
		bound.init(horizontal, type);
		
		if(horizontal)
		{
			setWH(Bound.size, Bound.size/4);
		} else
		{
			setWH(Bound.size/4, Bound.size);
		}
	}
	
	public function changeType(type:BoundType)
	{
		this.type = type;
		init(horizontal, type);
	}
	
	public override function setWidth(width:Float)
	{
		this.width = width;
		redraw();
	}
	
	public override function setHeight(height:Float)
	{
		this.height = height;
		redraw();
	}
	
	public override function setWH(width:Float, height:Float)
	{
		this.width = width;
		this.height = height;
		redraw();
	}
	
	private override function changeUp()
	{
		super.changeUp();
		redraw();
		sprite.transform.colorTransform = upCT;
	}
	
	private override function changeOver()
	{
		super.changeOver();
		redraw();
		sprite.transform.colorTransform = overCT;
	}
	
	private override function changeDown()
	{
		super.changeDown();
		redraw();
		sprite.transform.colorTransform = downCT;
	}
	
	private override function changeDisabled()
	{
		super.changeDisabled();
		redraw();
		sprite.transform.colorTransform = disabledCT;
	}
	
	function redraw()
	{
		var g = sprite.graphics;
		g.clear();
		g.beginFill(0x008888, 0.5);
		/*switch(state)
		{
			case ButtonState.UP: g.beginFill(0x00FFFF, 0.1);
			case ButtonState.OVER: g.beginFill(0x00FFFF, 0.5);
			case ButtonState.DOWN: g.beginFill(0x009999, 0.5);
			case ButtonState.DISABLED: g.beginFill(0xCCCCCC, 0.5);
		}*/
		if(horizontal)
		{
			g.drawRect(0, -height/2, width, height);
		} else
		{
			g.drawRect(-width/2,0,width,height);
		}
	}
}