//
//  BoundType.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 4/3/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;

enum BoundType
{
	None;
	Normal;
	OneSide(leftUp:Bool);
	Hollow;
	Count(count:Int);
}