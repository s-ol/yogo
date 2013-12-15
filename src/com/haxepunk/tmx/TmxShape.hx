package com.haxepunk.tmx;

import flash.geom.Point;
import haxe.xml.Fast;
import com.haxepunk.utils.Draw;

/**
 * ...
 * @author Princess Buccaneer
 */

class TmxShape extends TmxObject {

    public var points: Array<Point>;

    function new(source:Fast, parent:TmxObjectGroup) {
        super(source, parent);
        points = new Array<Point>();
    }

    public override function render() {

        //super.render();
#if debug
		for (point in points) {
			var x:Int = Std.int(point.x);
			var y:Int = Std.int(point.y);
			Draw.line(x - 2, y - 2, x + 2, y + 2, 0x0000FF);
			Draw.line(x - 2, y + 2, x + 2, y - 2, 0x0000FF);
		}
		var x:Int = Std.int(x);
		var y:Int = Std.int(y);
		Draw.line(x - 2, y - 2, x + 2, y + 2, 0xFF0000);
		Draw.line(x - 2, y + 2, x + 2, y - 2, 0xFF0000);
	#end
    }

}