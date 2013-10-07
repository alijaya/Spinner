//
//  OptionState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Bitmap;
import flash.display.StageQuality;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.graphic.S9G;
import manaGearz.utils.BitmapUtils;

class OptionState extends SpinnerState
{
	var prevState:String;
	
	var optionBack:S9G;
	var optionText:SpinnerText;
	var graphicBack:S9G;
	var graphicText:SpinnerText;
	
	var lowButton:SpinnerButton;
	var medButton:SpinnerButton;
	var hiButton:SpinnerButton;
	
	var bgmButton:SoundButton;
	var sfxButton:SoundButton;
	var returnButton:SpinnerButton;
	
	var curGraphic:SpinnerButton;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		optionBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		optionBack.setXYWH(0,0,250,50);
		
		optionText = new SpinnerText();
		optionText.text = "OPTION";
		optionText.x = 0;
		optionText.y = 8;
		optionText.width = optionBack.width;
		optionText.height = optionBack.height;
		
		graphicBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		graphicBack.setXYWH(0,50,250,50);
		
		graphicText = new SpinnerText();
		graphicText.text = "Graphic Quality";
		graphicText.x = 0;
		graphicText.y = 58;
		graphicText.width = graphicBack.width;
		graphicText.height = graphicBack.height;
		
		lowButton = new SpinnerButton("low");
		lowButton.setXYWH(0,100,250,50);
		lowButton.setToggleable(true);
		lowButton.click = callback(graphicButtonClick, lowButton);
		addButton(lowButton);
		
		medButton = new SpinnerButton("medium");
		medButton.setXYWH(0,150,250,50);
		medButton.setToggleable(true);
		medButton.click = callback(graphicButtonClick, medButton);
		addButton(medButton);
		
		hiButton = new SpinnerButton("high");
		hiButton.setXYWH(0,200,250,50);
		hiButton.setToggleable(true);
		hiButton.click = callback(graphicButtonClick, hiButton);
		addButton(hiButton);
		
		returnButton = new SpinnerButton("RETURN");
		returnButton.setXYWH(0,0,250,50);
		returnButton.click = returnClick;
		addButton(returnButton);
		
		bgmButton = new SoundButton("Back. Music");
		bgmButton.setXYWH(0,0,250,50);
		bgmButton.click = bgmButtonClick;
		addButton(bgmButton);
		
		sfxButton = new SoundButton("Sound Effect");
		sfxButton.setXYWH(0,0,250,50);
		sfxButton.click = sfxButtonClick;
		addButton(sfxButton);
		
		curGraphic = hiButton;
		curGraphic.setToggled(true);
		curGraphic.setToggleable(false);
		
		mainBox.addChild(optionBack.sprite);
		mainBox.addChild(optionText);
		mainBox.addChild(graphicBack.sprite);
		mainBox.addChild(graphicText);
		mainBox.addChild(lowButton.sprite);
		mainBox.addChild(medButton.sprite);
		mainBox.addChild(hiButton.sprite);
		firstBox.addChild(bgmButton.sprite);
		secondBox.addChild(sfxButton.sprite);
		thirdBox.addChild(returnButton.sprite);
	}
	
	function graphicButtonClick(b:SpinnerButton)
	{
		curGraphic.setToggleable(true);
		curGraphic.setToggled(false);
		curGraphic = b;
		curGraphic.setToggled(true);
		curGraphic.setToggleable(false);
		var s = flash.Lib.current.stage;
		switch(curGraphic)
		{
			case lowButton: s.quality = StageQuality.LOW;
			case medButton: s.quality = StageQuality.MEDIUM;
			case hiButton: s.quality = StageQuality.HIGH;
		}
	}
	
	function bgmButtonClick()
	{
		Manager.sound.setBGMMute(bgmButton.soundDisabled);
	}
	
	function sfxButtonClick()
	{
		Manager.sound.setSFXMute(sfxButton.soundDisabled);
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

class SoundButton extends SpinnerButton
{
	public var soundDisabled(default, null):Bool;
	
	var soundD:Bitmap;
	var soundE:Bitmap;
	var curSound:Bitmap;
	
	public function new(label:String)
	{
		super(label);
		soundDisabled = false;
		soundD = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","SoundDisabled"]));
		soundD.smoothing = true;
		soundD.x = 6;
		soundD.y = 6;
		soundE = BitmapUtils.copyBitmap(Manager.data.get(["Spinner","SoundEnabled"]));
		soundE.smoothing = true;
		soundE.x = 6;
		soundE.y = 6;
		
		var tf = textField.defaultTextFormat;
		tf.align = flash.text.TextFormatAlign.LEFT;
		textField.defaultTextFormat = tf;
		textField.x = 56;
		
		curSound = soundE;
		sprite.addChild(curSound);
	}
	
	override function clickInternal()
	{
		soundDisabled = !soundDisabled;
		sprite.removeChild(curSound);
		curSound = soundDisabled?soundD:soundE;
		sprite.addChild(curSound);
		super.clickInternal();
	}
	
	override function alignText()
	{
		var tf = textField.defaultTextFormat;
		tf.align = flash.text.TextFormatAlign.LEFT;
		textField.defaultTextFormat = tf;
		textField.x = 56;
		textField.y = 8;
		textField.width = width-56;
		textField.height = height;
	}
}