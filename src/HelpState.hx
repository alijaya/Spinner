//
//  HelpState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.graphic.S9G;

class HelpState extends SpinnerState
{
	var returnButton:SpinnerButton;
	
	var prevState:String;
	
	var backText:S9G;
	var helps:SpinnerText;
	
	var helpBack:S9G;
	var helpText:SpinnerText;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		returnButton = new SpinnerButton("RETURN");
		returnButton.setXYWH(0,0,250,50);
		returnButton.click = returnClick;
		addButton(returnButton);
		
		backText = new S9G(Manager.data.get(["Spinner", "Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		backText.setXYWH(0,0,250,250);
		
		helps = new SpinnerText(10);
		helps.autoSize = flash.text.TextFieldAutoSize.NONE;
		helps.wordWrap = true;
		var tf = helps.defaultTextFormat;
		tf.align = flash.text.TextFormatAlign.LEFT;
		helps.defaultTextFormat = tf;
		helps.x = 6;
		helps.y = 6;
		helps.width = 238;
		helps.height = 238;
		helps.text = "The objective of this game is to bring the ball to the goal (the cyan square). You are given some sequence that will spin your board. And you must use the available bound to create a way to finish the game. There are 4 type of the bound. First is the normal one, the ball will stop if it touchs this  bound. Second is one way bound, the ball will pass from one side, and stop from another side. Third is hollow bound, the bound can be passed one time, after that, the bound become normal bound. And the last is count bound, the bound can't be passed before the ball hit the bound for x times (the x refer to dot on the bound).";
		
		helpBack = new S9G(Manager.data.get(["Spinner", "Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		helpBack.setXYWH(0,0,250,100);
		
		helpText = new SpinnerText();
		helpText.text = "HELP";
		helpText.x = 0;
		helpText.y = 25 + 8;
		helpText.width = helpBack.width;
		helpText.height = helpBack.height;
		
		mainBox.addChild(backText.sprite);
		mainBox.addChild(helps);
		firstBox.addChild(helpBack.sprite);
		firstBox.addChild(helpText);
		thirdBox.addChild(returnButton.sprite);
	}
	
	function returnClick()
	{
		Manager.gameState.setState(prevState, "spinner");
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		if(d==null) return;
		prevState = d.prevState;
	}
}