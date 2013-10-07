//
//  BoundButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.text.TextField;

import manaGearz.manager.Manager;
import manaGearz.button.TintButton;
import manaGearz.button.ButtonState;

class BoundButton extends TintButton
{
	public var type:BoundType;
	public var count:Int;
	var bound:Bound;
	var textField:SpinnerText;
	
	public function new(type:BoundType, count:Int)
	{
		bound = new Bound(false, type);
		bound.x = Bound.size/2;
		bound.y = 6;
		bound.scaleX = bound.scaleY = 38/50;
		
		textField = new SpinnerText(10);
		textField.x = Bound.size*1/2;
		textField.y = Bound.size*1/3 + 8;
		textField.width = Bound.size-textField.x;
		textField.height = Bound.size-textField.y - 8;
		
		super(Manager.data.get(["Spinner","Button"]));
		
		toggleable = true;
		
		sprite.addChild(bound);
		sprite.addChild(textField);
		
		init(type, count);
		setWH(Bound.size, Bound.size);
	}
	
	public function init(type:BoundType, count:Int)
	{
		this.type = type;
		this.count = count;
		
		bound.init(false, type);
		textField.text = count+"";
	}
	
	public function setCount(count:Int)
	{
		this.count = count;
		textField.text = count+"";
	}
}