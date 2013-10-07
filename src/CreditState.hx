//
//  CreditState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/29/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.graphic.S9G;

class CreditState extends SpinnerState
{
	var returnButton:SpinnerButton;
	
	var prevState:String;
	
	var mainBack:S9G;
	var credits:SpinnerText;
	
	var creditBack:S9G;
	var creditText:SpinnerText;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		returnButton = new SpinnerButton("RETURN");
		returnButton.setXYWH(0,0,250,50);
		returnButton.click = returnClick;
		addButton(returnButton);
		
		mainBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		mainBack.setXYWH(0,0,250,250);
		
		credits = new SpinnerText(15);
		credits.text = "PROGRAMMED BY :\nalijaya\n\nART BY :\nalijaya\n\nLEVEL BY :\nalijaya\nmy brother(anthony)\n\nMUSIC BY :\nwww.incompetech.com";
		credits.x = 0;
		credits.y = 8;
		credits.width = mainBack.width;
		credits.height = mainBack.height;
		
		creditBack = new S9G(Manager.data.get(["Spinner","Box"]).bitmapData, {x:6.0,y:6.0,width:38.0,height:38.0});
		creditBack.setXYWH(0,0,250,100);
		
		creditText = new SpinnerText();
		creditText.text = "CREDIT";
		creditText.x = 0;
		creditText.y = 25 + 8;
		creditText.width = creditBack.width;
		creditText.height = creditBack.height;
		
		mainBox.addChild(mainBack.sprite);
		mainBox.addChild(credits);
		firstBox.addChild(creditBack.sprite);
		firstBox.addChild(creditText);
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