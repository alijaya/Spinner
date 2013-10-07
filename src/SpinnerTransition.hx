//
//  SpinnerTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/15/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;

import manaGearz.manager.Manager;
import manaGearz.transition.SpriteTransition;
import manaGearz.fsm.FSM;

import feffects.easing.Bounce;

class SpinnerTransition extends SpriteTransition
{
	var firstSpinner:SpinnerState;
	var secondSpinner:SpinnerState;
	
	var movingState:Int;
	
	public function new(fsm:FSM, ?first:SpinnerState, ?second:SpinnerState)
	{
		super(fsm, first, second);
		defaultTime = 100;
		firstSpinner = first;
		secondSpinner = second;
		movingState = 0;
	}
	
	public override function enter()
	{
		Manager.gameState.root.addChildAt(secondSprite, 0);
		secondSpinner.mainBox.y = -250;
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		firstSpinner = d.first;
		secondSpinner = d.second;
		movingState = 0;
	}
	
	override function trans()
	{
		if(movingState==0)
		{
			firstSpinner.firstBox.x = Bounce.easeOut(curTime, 0, -250, 50);
			secondSpinner.firstBox.x = Bounce.easeOut(curTime, 250, -250, 50);
			
			firstSpinner.mainBox.y = Bounce.easeOut(curTime, 0, -250, 50);
			if(curTime==25) movingState=1;
		} else if(movingState==1)
		{
			firstSpinner.firstBox.x = Bounce.easeOut(curTime, 0, -250, 50);
			secondSpinner.firstBox.x = Bounce.easeOut(curTime, 250, -250, 50);
			
			firstSpinner.secondBox.x = Bounce.easeOut(curTime-25, 0, 250, 50);
			secondSpinner.secondBox.x = Bounce.easeOut(curTime-25, -250, 250, 50);
			
			firstSpinner.mainBox.y = Bounce.easeOut(curTime, 0, -250, 50);
			if(curTime==50) movingState=2;
		} else if(movingState==2)
		{
			firstSpinner.secondBox.x = Bounce.easeOut(curTime-25, 0, 250, 50);
			secondSpinner.secondBox.x = Bounce.easeOut(curTime-25, -250, 250, 50);
			
			firstSpinner.thirdBox.x = Bounce.easeOut(curTime-50, 0, -250, 50);
			secondSpinner.thirdBox.x = Bounce.easeOut(curTime-50, 250, -250, 50);
			
			secondSpinner.mainBox.y = Bounce.easeOut(curTime-50, -250, 250, 50);
			if(curTime==75) movingState=3;
		} else if(movingState==3)
		{
			firstSpinner.thirdBox.x = Bounce.easeOut(curTime-50, 0, -250, 50);
			secondSpinner.thirdBox.x = Bounce.easeOut(curTime-50, 250, -250, 50);
			
			secondSpinner.mainBox.y = Bounce.easeOut(curTime-50, -250, 250, 50);
			if(curTime==100) movingState=4;
		}
		if(curTime==15) Manager.sound.playSFX("knock");
		if(curTime==40) Manager.sound.playSFX("knock");
		if(curTime==65) Manager.sound.playSFX("knock");
		if(interval>=1)
		{
			Manager.gameState.root.removeChild(firstSprite);
		}
	}
}