//
//  Sequence.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.geom.ColorTransform;
import flash.display.Sprite;
import flash.display.Bitmap;

import manaGearz.graphic.S9G;
import manaGearz.utils.BitmapUtils;
import manaGearz.utils.ColorUtils;
import manaGearz.manager.Manager;

class Sequence extends Sprite
{
	var complete:Bool;
	var type:SequenceType;
	
	var blankCT:ColorTransform;
	var tintCT:ColorTransform;
	var background:S9G;
	var curBitmap:Bitmap;
	
	public function new(complete:Bool, type:SequenceType)
	{
		super();
		blankCT = new ColorTransform();
		tintCT = ColorUtils.tintCT(0, 0.3);
		
		background = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		background.setWH(25, 25);
		addChild(background.sprite);
		init(complete, type);
	}
	
	public function init(complete:Bool, type:SequenceType)
	{
		this.complete = complete;
		this.type = type;
		
		if(curBitmap!=null) removeChild(curBitmap);
		
		switch(type)
		{
			case CW:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","SequenceCW"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
			case CCW:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","SequenceCCW"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
			case Flip:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","SequenceFlip"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
		}
		
		if(complete) transform.colorTransform = tintCT else transform.colorTransform = blankCT;
				
		curBitmap.scaleX = curBitmap.scaleY = 13/25;
		curBitmap.x = 6;
		curBitmap.y = 6;
	}
	
	public function setComplete(complete:Bool)
	{
		init(complete, this.type);
	}
}