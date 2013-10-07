//
//  Ball.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;
import flash.display.Bitmap;

import manaGearz.manager.Manager;
import manaGearz.utils.BitmapUtils;

class Ball extends Sprite
{
	public function new()
	{
		super();
		var b = BitmapUtils.copyBitmap(Manager.data.get(["Spinner", "Ball"]));
		b.smoothing = true;
		addChild(b);
	}
}