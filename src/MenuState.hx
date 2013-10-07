//
//  MenuState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/15/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Bitmap;
import flash.display.Sprite;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.graphic.S9G;
import manaGearz.utils.BitmapUtils;

class MenuState extends SpinnerState
{
	var titleBack:S9G;
	var title:Bitmap;
	var playButton:SpinnerButton;
	var optionButton:SpinnerButton;
	var helpButton:SpinnerButton;
	var creditButton:SpinnerButton;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		titleBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		titleBack.setXYWH(0,0,250,250);
		
		title = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","Title"]));
		title.smoothing = true;
		title.scaleX = title.scaleY = 0.6;
		title.x = (250-title.width)/2;
		title.y = (250-title.height)/2;
		
		playButton = new SpinnerButton("PLAY");
		playButton.setXYWH(0,0,250,50);
		playButton.click = playClick;
		addButton(playButton);
		
		optionButton = new SpinnerButton("OPTION");
		optionButton.setXYWH(0,0,150,50);
		optionButton.click = optionClick;
		addButton(optionButton);
		
		helpButton = new SpinnerButton("HELP");
		helpButton.setXYWH(150,0,100,50);
		helpButton.click = helpClick;
		addButton(helpButton);
		
		creditButton = new SpinnerButton("CREDIT");
		creditButton.setXYWH(0,0,250,50);
		creditButton.click = creditClick;
		addButton(creditButton);
		
		mainBox.addChild(titleBack.sprite);
		mainBox.addChild(title);
		firstBox.addChild(playButton.sprite);
		secondBox.addChild(optionButton.sprite);
		secondBox.addChild(helpButton.sprite);
		thirdBox.addChild(creditButton.sprite);
	}
	
	function playClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState("select", "spinner", {execFirst:false, execSecond:false});
	}
	
	function optionClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState("option", "spinner", {nextInit:{prevState:"menu"}});
	}
	
	function helpClick()
	{
		Manager.gameState.setState("help", "spinner", {nextInit:{prevState:"menu"}});
	}
	
	function creditClick()
	{
		Manager.gameState.setState("credit", "spinner", {nextInit:{prevState:"menu"}});
	}
}