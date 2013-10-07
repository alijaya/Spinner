//
//  SpinnerText.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/29/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;

import manaGearz.manager.Manager;

import flash.text.TextField;

class SpinnerText extends TextField
{
	public function new(?size:Int=25, ?color:Int=0x008888)
	{
		super();
		// autoSize = flash.text.TextFieldAutoSize.CENTER;
		multiline = false;
		#if android
		embedFonts = true;
		#end
		selectable = false;
		init(size, color);
	}
	
	public function init(?size:Int=25, ?color:Int=0x008888)
	{
		var textFormat = defaultTextFormat;
		#if android
		textFormat.font = Manager.data.get(["Spinner", "Monaco"]).fontName;
		#else
		textFormat.font = "Monaco";
		#end
		textFormat.align = flash.text.TextFormatAlign.CENTER;
		textFormat.size = size;
		textFormat.color = color;
		defaultTextFormat = textFormat;
	}
}