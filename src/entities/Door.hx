package entities;

import com.haxepunk.Entity;

class Door extends Entity implements IWalkable {
    public override function new( x:Int, y:Int, cx:Int, cy:Int, key:String ) {
        super( x, y );
        this.key = key;
        type = "door";
        open = false;
        setHitbox( 24, 24, 12, 12 );
    }

    public function hit( ply:Player ) {
        if ( open || ply.has( key ) ) {
            open = true;
            return;
        } else {
            ply.moveBy( 0, -5 );
        }
    }

    public  var key : String;
    public  var open: Bool;
}