package entities;

import com.haxepunk.Entity;

class Teleporter extends Entity implements IWalkable {
    public override function new( x:Int, y:Int, dx:Int, dy:Int ) {
        super( x, y );
        this.dx = dx;
        this.dy = dy;
        type = "teleporter";
        setHitbox( 24, 24, -12, -12 );
    }

    public function hit( ply:Player ) : Void {
        ply.x = dx * 24;
        ply.y = dy * 24;
        trace( "tele" );
    }

    public var dx:Int;
    public var dy:Int;
}