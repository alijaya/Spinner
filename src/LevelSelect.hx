//
//  LevelSelect.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/18/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import flash.display.Sprite;
import flash.text.TextField;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.graphic.S9G;
import manaGearz.math.MathEx;

class LevelSelect extends SpinnerState
{
	var labelBack:S9G;
	var levelLabel:SpinnerText;
	var pageBack:S9G;
	var pageLabel:SpinnerText;
	
	var levels:Array<Dynamic>; // redirect from LevelManager
	
	var levelListA:Array<LevelButton>;
	var levelListB:Array<LevelButton>;
	var containerA:Sprite;
	var containerB:Sprite;
	var flag:Bool;
	var page:Int;
	var maxPage:Int;
	var prevButton:SpinnerButton;
	var nextButton:SpinnerButton;
	var playButton:SpinnerButton;
	var menuButton:SpinnerButton;
	
	var curButton:LevelButton;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		levels = LevelManager.instance.levels;
		
		labelBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		labelBack.setXYWH(0,0,250,50);
		
		levelLabel = new SpinnerText();
		levelLabel.text = "LEVEL SELECT";
		levelLabel.x = 0;
		levelLabel.y = 8;
		levelLabel.width = labelBack.width;
		levelLabel.height = labelBack.height;
		
		pageBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		pageBack.setXYWH(50,0,150,50);
		
		pageLabel = new SpinnerText();
		pageLabel.text = "PAGE 0/0";
		pageLabel.x = 50;
		pageLabel.y = 8;
		pageLabel.width = pageBack.width;
		pageLabel.height = pageBack.height;
		
		prevButton = new SpinnerButton("<");
		prevButton.setXYWH(0,0,50,50);
		addButton(prevButton);
		
		nextButton = new SpinnerButton(">");
		nextButton.setXYWH(200,0,50,50);
		addButton(nextButton);
		
		playButton = new SpinnerButton("PLAY");
		playButton.setXYWH(0,0,250,50);
		playButton.click = playButtonClick;
		addButton(playButton);
		
		menuButton = new SpinnerButton("MENU");
		menuButton.setXYWH(0,0,250,50);
		menuButton.click = menuButtonClick;
		addButton(menuButton);
		
		levelListA = [];
		levelListB = [];
		containerA = new Sprite();
		containerA.y = 50;
		containerB = new Sprite();
		containerB.y = 50;
		flag = false;
		page = 0;
		maxPage = MathEx.ceil(levels.length/20)-1;
		var b:LevelButton;
		for(n in 0...20)
		{
			b = new LevelButton(0);
			b.setXYWH((n%5)*50,Std.int(n/5)*50,50,50);
			b.setToggleable(true);
			b.click = callback(levelButtonClick, b);
			levelListA.push(b);
			containerA.addChild(b.sprite);
			
			b = new LevelButton(0);
			b.setXYWH((n%5)*50,Std.int(n/5)*50,50,50);
			b.setToggleable(true);
			b.click = callback(levelButtonClick, b);
			levelListB.push(b);
			containerB.addChild(b.sprite);
		}
		
		preparePage();
		
		mainBox.addChild(labelBack.sprite);
		mainBox.addChild(levelLabel);
		mainBox.addChild(containerA);
		firstBox.addChild(prevButton.sprite);
		firstBox.addChild(pageBack.sprite);
		firstBox.addChild(pageLabel);
		firstBox.addChild(nextButton.sprite);
		secondBox.addChild(playButton.sprite);
		thirdBox.addChild(menuButton.sprite);
	}
	
	function preparePage()
	{
		prevButton.setDisabled(page==0);
		nextButton.setDisabled(page==maxPage);
		pageLabel.text = "PAGE "+(page+1)+"/"+(maxPage+1);
		pageLabel.x = (250-pageLabel.width)/2;
		var base = page*20;
		var maxLevel = levels.length;
		var lb:LevelButton;
		if(!flag) // A
		{
			for(n in 0...20)
			{
				lb = levelListA[n];
				if(base+n<maxLevel)
				{
					lb.setIndex(base+n+1);
					lb.setDisabled(false);
				} else
				{
					lb.setIndex(0);
					lb.setDisabled(true);
				}
				addButton(levelListA[n]);
				removeButton(levelListB[n]);
			}
			levelListA[0].simulateClick();
		} else // B
		{
			for(n in 0...20)
			{
				lb = levelListB[n];
				if(base+n<maxLevel)
				{
					lb.setIndex(base+n+1);
					lb.setDisabled(false);
				} else
				{
					lb.setIndex(0);
					lb.setDisabled(true);
				}
				addButton(levelListB[n]);
				removeButton(levelListA[n]);
			}
			levelListB[0].simulateClick();
		}
	}
	
	function levelButtonClick(lb:LevelButton)
	{
		//Manager.sound.playSFX("tap");
		// trace(lb.index);
		if(curButton!=null)
		{
			curButton.setToggleable(true);
			curButton.setToggled(false);
		}
		curButton = lb;
		curButton.setToggled(true);
		curButton.setToggleable(false);
	}
	
	function playButtonClick()
	{
		//Manager.sound.playSFX("tap");
		LevelManager.instance.goTo(curButton.index);
	}
	
	function menuButtonClick()
	{
		//Manager.sound.playSFX("tap");
		Manager.gameState.setState("menu", "spinner");
	}
}

class LevelButton extends SpinnerButton
{
	public var index(default, null):Int;
	
	public function new(index:Int)
	{
		this.index = index;
		super(index+"");
	}
	
	public function setIndex(index:Int)
	{
		this.index = index;
		setLabel(index+"");
	}
}