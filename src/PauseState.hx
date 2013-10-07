//
//  PauseState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.text.TextField;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.graphic.S9G;

class PauseState extends SpinnerState
{
	var background:S9G;
	var pauseLabel:SpinnerText;
	var optionButton:SpinnerButton;
	var menuButton:SpinnerButton;
	var resumeButton:SpinnerButton;
	
	var prevState:String;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		background = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		background.setXYWH(0,0,250,250);
		
		pauseLabel = new SpinnerText();
		pauseLabel.text = "PAUSE";
		pauseLabel.x = (250-pauseLabel.width)/2;
		pauseLabel.y = (250-pauseLabel.height)/2;
		
		optionButton = new SpinnerButton("OPTION");
		optionButton.setXYWH(0,0,250,50);
		optionButton.click = optionClick;
		addButton(optionButton);
		
		menuButton = new SpinnerButton("MENU");
		menuButton.setXYWH(0,0,250,50);
		menuButton.click = menuClick;
		addButton(menuButton);
		
		resumeButton = new SpinnerButton("RESUME");
		resumeButton.setXYWH(0,0,250,50);
		resumeButton.click = resumeClick;
		addButton(resumeButton);
		
		mainBox.addChild(background.sprite);
		mainBox.addChild(pauseLabel);
		firstBox.addChild(optionButton.sprite);
		secondBox.addChild(menuButton.sprite);
		thirdBox.addChild(resumeButton.sprite);
	}
	
	function optionClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState("option", "spinner", {execFirst:false, execSecond:false, nextInit:{prevState:"pause"}});
	}
	
	function menuClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState("menu", "spinner", {execFirst:false, execSecond:false});
	}
	
	function resumeClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState(prevState, "spinner", {execFirst:false, execSecond:false});
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		if(d==null) return;
		prevState = d.prevState;
	}
}