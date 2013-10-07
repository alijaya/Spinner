//
//  SpinnerState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/15/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;

import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.button.Button;

class SpinnerState extends SpriteState
{
	public var mainBox:Sprite;
	public var firstBox:Sprite;
	public var secondBox:Sprite;
	public var thirdBox:Sprite;

	public var buttons:Array<Button>;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		mainBox = new Sprite();
		firstBox = new Sprite();
		secondBox = new Sprite();
		thirdBox = new Sprite();

		buttons = [];
		
		sprite.addChild(mainBox);
		sprite.addChild(firstBox);
		sprite.addChild(secondBox);
		sprite.addChild(thirdBox);
	}

	public function addButton(b:Button)
	{
		buttons.push(b);
	}

	public function removeButton(b:Button)
	{
		buttons.remove(b);
	}
	
	public override function enter()
	{
		super.enter();
		
		mainBox.x = 0;
		mainBox.y = 0;
		
		firstBox.x = 0;
		firstBox.y = 250;
		
		secondBox.x = 0;
		secondBox.y = 300;
		
		thirdBox.x = 0;
		thirdBox.y = 350;
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		
		mainBox.x = 0;
		mainBox.y = -250;
		
		firstBox.x = -250;
		firstBox.y = 250;
		
		secondBox.x = 250;
		secondBox.y = 300;
		
		thirdBox.x = -250;
		thirdBox.y = 350;
		
	}

	public override function execute()
	{
		if(!active) return;
		super.execute();

		for(b in buttons)
		{
			b.update();
		}
	}
}