//
//  Border.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/6/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;
import flash.display.Bitmap;

import manaGearz.manager.Manager;
import manaGearz.utils.BitmapUtils;

class Border extends Sprite
{
	var direction:Int; // 0=left,1=up,2=right,3=down
	
	var curBitmap:Bitmap;
	
	public function new(direction:Int)
	{
		super();
		init(direction);
	}
	
	public function init(direction:Int)
	{
		this.direction = direction;
		
		if(curBitmap!=null) removeChild(curBitmap);
		
		switch(direction)
		{
			case 0: 
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner", "BorderLeftUp"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
			case 1:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner", "BorderLeftUp"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
				b.rotation=90;
				b.x=50;
			case 2:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner", "BorderRightDown"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
				b.x=-6;
			case 3:
				var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner", "BorderRightDown"]));
				b.smoothing = true;
				addChild(b);
				curBitmap = b;
				b.rotation=90;
				b.x=50;
				b.y=-6;
		}
	}
}