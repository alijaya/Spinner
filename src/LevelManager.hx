//
//  LevelManager.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;

import manaGearz.manager.Manager;

class LevelManager 
{
	private static var _instance : LevelManager;
	public static var instance(get_instance, null) : LevelManager;
	public static function get_instance() : LevelManager
	{
		if (_instance == null) _instance = new LevelManager();
		return _instance;
	}
	
	public var levels(default, null):Array<Dynamic>;
	var curLevel:Int;
	var flag:Bool;
	
	private function new()
	{
		flag = true;
		curLevel = 0;
		levels = [];
		var n = 1;
		while(true)
		{
			var level = Manager.data.get(["level","Level"+n]);
			if(level==null) break;
			levels.push(level);
			n++;
		}
	}
	
	public function goTo(level:Int) // base 1
	{
		if(level>levels.length) return;
		curLevel = level;
		Manager.gameState.setState((flag?"levelA":"levelB"), "spinner", {nextInit:levels[level-1]});
		flag = !flag;
	}
	
	public function nextLevel()
	{
		var level = curLevel+1;
		if(level<=levels.length)
		{
			goTo(level);
		} else
		{
			Manager.gameState.setState("menu", "spinner");
		}
	}
}