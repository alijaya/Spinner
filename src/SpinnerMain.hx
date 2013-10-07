//
//  SpinnerMain.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/13/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.BitmapData;
import flash.media.Sound;
import flash.utils.ByteArray;
import flash.display.Shape;

import flash.display.Bitmap;
import flash.Lib;

import hxjson2.JSON;

import manaGearz.manager.Manager;
import manaGearz.transition.DirectTransition;

class SpinnerMain 
{
	public function new()
	{
		//trace("loading");
		//Manager.loader.load("../src/assets.json", complete);
		// Manager.embed.load("libswf", "assets", complete);
		// Manager.gameState.root.x = (Lib.current.stage.stageWidth-250)/2;
		// Manager.gameState.root.y = (Lib.current.stage.stageHeight-400)/2;

		var s = new Shape();
		s.graphics.beginFill(0);
		s.graphics.drawRect(0,0,250,400);
		s.x = Manager.gameState.root.x;
		s.y = Manager.gameState.root.y;

		Manager.gameState.root.parent.addChild(s);
		Manager.gameState.root.mask = s;
		complete();
	}
	
	public function complete()
	{
		var b = [	"Ball",
					"BorderLeftUp",
					"BorderRightDown",
					"BoundCountCounter",
					"BoundHollow",
					"BoundNormal",
					"BoundOneSideLeftUp",
					"BoundOneSideRightDown",
					"Box",
					"SequenceCCW",
					"SequenceCW",
					"SequenceFlip",
					"SoundDisabled",
					"SoundEnabled",
					"Title"];
		for(i in b) getB(i);

		var s = [	"BGM",
					"Knock",
					"Swoosh",
					"Tap"];
		for(i in s) getS(i);

		for(i in 1...21) getL("Level"+i);

		#if android
		getF("Monaco");
		#end
		
		Manager.data.set(["Spinner","Button"], {bd:Manager.data.get(["Spinner","Box"]).bitmapData, bdT:Manager.data.get(["Spinner","Box"]).bitmapData, rect:{x:6.0,y:6.0,width:38.0,height:38.0}, over:{color:0xFFFFFF, value:0.3}, down:{color:0x000000, value:0.3}, disabled:{color:0x888888, value:0.5}, upT:{color:0xFFFF00, value:0.3}, overT:{color:0xFFFF88, value:0.3}, downT:{color:0x888800, value:0.3}, disabledT:{color:0x888800, value:0.5}});
		
		// Manager.sound.addBGM("BGM", Manager.data.get(["Spinner","BGM"]), 2.0);
		// Manager.sound.addSFX("knock", Manager.data.get(["Spinner","Knock"]), 0.5);
		// Manager.sound.addSFX("swoosh", Manager.data.get(["Spinner","Swoosh"]), 0.7);
		// Manager.sound.addSFX("tap", Manager.data.get(["Spinner","Tap"]), 0.5);
		
		Manager.gameState.addState("menu", MenuState);
		Manager.gameState.addState("select", LevelSelect);
		Manager.gameState.addState("levelA", SpinnerLevel);
		Manager.gameState.addState("levelB", SpinnerLevel);
		Manager.gameState.addState("option", OptionState);
		Manager.gameState.addState("pause", PauseState);
		Manager.gameState.addState("credit", CreditState);
		Manager.gameState.addState("help", HelpState);
		Manager.gameState.addTransition("direct", DirectTransition);
		Manager.gameState.addTransition("spinner", SpinnerTransition);
		//Manager.timer.setDelay(100);
		Manager.timer.addLoop(Manager.gameState.step);

		// Manager.sound.setBGMMute(true);
		// Manager.sound.setSFXMute(true);
		
		//Manager.keyInput.addInput(",", (cast Manager.gameState.states.get("test")).reset);
		//Manager.keyInput.addInput(".", (cast Manager.gameState.states.get("test")).start);
		
		Manager.gameState.setState("menu", "direct");
		
		Manager.sound.setBGM("BGM", true);
		
		Lib.current.stage.quality = flash.display.StageQuality.HIGH;

		// trace("test");
		// Lib.current.stage.align = flash.display.StageAlign.TOP;
		
		/* var cm = new flash.ui.ContextMenu();
		cm.hideBuiltInItems();
		Lib.current.contextMenu = cm; */
	}

	function getB(id:String)
	{
		Manager.data.set(["Spinner",id], new Bitmap(ApplicationMain.getAsset("assets/Spinner/"+id+".png")));
	}

	function getS(id:String)
	{
		Manager.data.set(["Spinner",id], ApplicationMain.getAsset("assets/Spinner/"+id+".mp3"));
	}

	function getF(id:String)
	{
		Manager.data.set(["Spinner",id], ApplicationMain.getAsset("assets/Spinner/"+id+".ttf"));
	}

	function getL(id:String)
	{
		Manager.data.set(["level",id], parseJSON(ApplicationMain.getAsset("assets/level/"+id+".json")));
	}

	function parseJSON(s:String) : Dynamic
	{
		return JSON.decode(s);
	}
	
	static function main()
	{
		new SpinnerMain();
	}
}