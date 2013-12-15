package com.haxepunk.tmx;
import flash.geom.Point;
import haxe.xml.Fast;

/**
 * A TmxObject with a <polyline> node.
 * @author Princess Buccaneer */
class TmxPolylin extends TmxShape {

    public function new(source:Fast, parent:TmxObjectGroup) {
        super(source, parent);

        var pointStrings = source.node.polyline.att.points.split(" ");
        for (point in pointStrings) {
            var xy: Array<String> = point.split(",");
            points.push(new Point(x + Std.parseFloat(xy[0]), y + Std.parseFloat(xy[1])));
        }
    }
}