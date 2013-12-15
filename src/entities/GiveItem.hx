package entities;

import com.haxepunk.Entity;

class GiveItem extends Entity implements IWalkable {
    public override function new( x:Int, y:Int, item:String ) {
        super( x, y );
        this.item = item;
        taken = false;
        type = "item";
        setHitbox( 24, 24, -12, -12 );
    }

    public function hit( ply:Player ) {
        if ( !taken ) {
            taken = true;
            ply.give( item );
        }
    }

    public  var item    : String;
    public  var taken   : Bool;
}