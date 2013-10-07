//
//  SpinnerButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.text.TextField;
import flash.events.MouseEvent;

import manaGearz.manager.Manager;
import manaGearz.button.TintButton;
import manaGearz.button.ButtonState;

class SpinnerButton extends TintButton
{
	public var label(default, null):String;
	
	var textField:SpinnerText;
	
	public function new(label:String)
	{
		textField = new SpinnerText();
		
		super(Manager.data.get(["Spinner","Button"]));
		
		sprite.addChild(textField);
		
		setLabel(label);
	}
	
	public override function setWidth(width:Float)
	{
		super.setWidth(width);
		alignText();
	}
	
	public override function setHeight(height:Float)
	{
		super.setHeight(height);
		alignText();
	}
	
	public override function setWH(width:Float, height:Float)
	{
		super.setWH(width, height);
		alignText();
	}
	
	public function setLabel(label:String)
	{
		this.label = label;
		textField.text = label;
		alignText();
	}
	
	function alignText()
	{
		textField.x = 0;
		textField.y = 8;
		textField.width = width;
		textField.height = height;
	}
	
	private override function clickInternal()
	{
		Manager.sound.playSFX("tap");
		super.clickInternal();
	}
}