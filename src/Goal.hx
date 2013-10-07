//
//  Goal.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;

class Goal extends Sprite
{
	public function new()
	{
		super();
		graphics.beginFill(0x00FFFF, 0.3);
		graphics.drawRect(0,0,Bound.size,Bound.size);
	}
}