//
//  Bound.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;
import flash.display.Bitmap;

import manaGearz.utils.BitmapUtils;
import manaGearz.manager.Manager;

class Bound extends Sprite
{
	public static var size:Float = 50;
	
	var horizontal:Bool;
	var type:BoundType;
	
	var displays:Array<Bitmap>;
	
	public function new(horizontal:Bool, type:BoundType)
	{
		super();
		displays = [];
		init(horizontal, type);
	}
	
	public function init(horizontal:Bool, type:BoundType)
	{
		this.horizontal = horizontal;
		this.type = type;
		
		for(n in displays)
		{
			removeChild(n);
		}
		displays = [];
		
		switch(type)
		{
			case None: 
			case Normal: 
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","BoundNormal"]));
				b.smoothing = true;
				addChild(b);
				displays.push(b);
				if(horizontal)
				{
					b.rotation=90;
					b.x=50;
					b.y=-6;
				} else
				{
					b.x=-6;
				}
			case OneSide(leftUp):
				var b:Bitmap;
				if(leftUp)
				{
					b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","BoundOneSideLeftUp"]));
				} else
				{
					b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","BoundOneSideRightDown"]));
				}
				b.smoothing = true;
				addChild(b);
				displays.push(b);
				if(horizontal)
				{
					b.rotation=90;
					b.x=50;
					b.y=-6;
				} else
				{
					b.x=-6;
				}
			case Hollow:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","BoundHollow"]));
				b.smoothing = true;
				addChild(b);
				displays.push(b);
				if(horizontal)
				{
					b.rotation=90;
					b.x=50;
					b.y=-6;
				} else
				{
					b.x=-6;
				}
			case Count(count):
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","BoundNormal"]));
				b.smoothing = true;
				var cc = Manager.data.get(["Spinner","BoundCountCounter"]);
				addChild(b);
				displays.push(b);
				if(horizontal)
				{
					b.rotation=90;
					b.x=50;
					b.y=-6;
					for(n in 0...count)
					{
						var c = BitmapUtils.copyBitmap(cc);
						cc.smoothing = true;
						addChild(c);
						displays.push(c);
						c.x = Bound.size*(n+1)/(count+1) - 4;
						c.y = -4;
					}
				} else
				{
					b.x=-6;
					for(n in 0...count)
					{
						var c = BitmapUtils.copyBitmap(cc);
						cc.smoothing = true;
						addChild(c);
						displays.push(c);
						c.x = -4;
						c.y = Bound.size*(n+1)/(count+1) - 4;
					}
				}
		}
	}
}