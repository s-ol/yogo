package entities;

import com.haxepunk.Entity;

class Door extends Entity implements IWalkable {
    public override function new( x:Int, y:Int, cx:Int, cy:Int, key:String ) {
        super( x, y );
        this.key = key;
        type = "door";
        setHitbox( Std.int(24+Math.abs(cx*24)), Std.int(24+Math.abs(cy*24)), -12+Std.int(Math.max(0, cx * 24 )), -12+Std.int(Math.max(0, cy * 24)) );
    }

    public function hit( ply:Player ) {
        if ( ply.has( key ) )
            type = "door";
    }

    public  var key : String;
}