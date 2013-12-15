package entities;

import entities.IWalkable;
import com.pdev.lighting.Light;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import flash.display.BitmapData;
import com.pdev.lighting.DirectionalLight;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

class Player extends Entity {
    public function new( x:Int, y:Int, bmpd:BitmapData )
    {
        super(x, y);

        scared = 0;
        _alive = true;

        light = new DirectionalLight( bmpd, 180 );
        light.x = light.y = 0;

        _sprite = new Image("graphics/redtest.png");
        _sprite.centerOrigin();
        graphic = _sprite;

        setHitboxTo( graphic );
        type = "player";
    }

    public override function update()
    {
        if ( !_alive )
            return;

        _angle = Math.atan2( Input.mouseY - HXP.halfHeight, Input.mouseX - HXP.halfWidth );
        _sprite.angle = _angle / Math.PI * -180;

        if ( Input.check( Key.W ) ) {
            moveBy( 0, -2, "walls" );
        }
        if ( Input.check( Key.A ) ) {
            moveBy( -2, 0, "walls" );
        }
        if ( Input.check( Key.D ) ) {
            moveBy( 2, 0, "walls" );
        }
        if ( Input.check( Key.S ) ) {
            moveBy( 0, 2, "walls" );
        }

        light.x = Std.int(x);
        light.y = Std.int(y);
        light.rotation = _angle;

        scared /= 1.5;

        var e:IWalkable = cast(collide( "door", x, y ),IWalkable);
        if ( e != null )
            e.hit( this );
        e = cast(collide( "item", x, y ),IWalkable);
        if ( e != null )
            e.hit( this );
        e = cast(collide( "teleporter", x, y ),IWalkable);
        if ( e != null   )
            e.hit( this );

        super.update();
    }

    public function scare( e:Enemy ) : Void {
        scared += distanceFrom( e ) / 800;
    }

    public function kill( ) : Void {
        if ( _alive ) {
            _alive = false;
            cast(HXP.scene,MainScene).replaceLight( light, new Light( light.texture, Std.int(x), Std.int(y) ) );
        }
    }

    public function give( item:String ) : Void {
        _items.push( item );
        trace( "got " + item );
    }

    public function has( item:String ) : Bool {
        if ( _items.filter( function( str:String ):Bool{ return str == item; } ).length > 0 )
            trace("have " + item);
            return true;
        return false;
    }

    private var _sprite : Image;
    private var _angle  : Float;
    private var _alive  : Bool;
    private var _items  : Array<String>;
    public  var scared  : Float;
    public  var light   : Light;
}