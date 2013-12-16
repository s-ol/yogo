package entities;

import com.haxepunk.Scene;
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

        scared = 1;
        _alive = true;

        light = new DirectionalLight( bmpd, 180 );
        light.x = light.y = 0;

        _sprite = new Image("graphics/redtest.png");
        _sprite.centerOrigin();
        graphic = _sprite;

        setHitboxTo( graphic );
        type = "player";

        _items = new Array<String>();
    }

    public override function update()
    {
        if ( !_alive ) {
            if ( Input.pressed( Key.SPACE ) || Input.mouseDown )
                HXP.scene = new MenuScene();
            else
                return;
        }

        if ( scared > 10 )
            kill();

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

        if ( scared > 1 )
            scared /= 1.01;

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
        if ( _alive )
            scared *= 1.1;
    }

    public function kill() : Void {
        if ( _alive ) {
            _alive = false;
            cast(HXP.scene,MainScene).replaceLight( light, new Light( light.texture, Std.int(x), Std.int(y) ) );
            var img = new SlideinEntity( new Image( "graphics/gui/spacetorestart.png"), Std.int(HXP.halfWidth), Std.int(HXP.halfHeight), 20, 0, 10 );
            img.renderTarget = cast(HXP.scene,MainScene).scareBar;
            HXP.scene.add( img );
        }
    }

    public function give( item:String ) : Void {
        _items.push( item );
        trace( "you found " + item + "!" );
    }

    public function has( item:String ) : Bool {
        if ( _items.filter( function( str:String ):Bool{ return str == item; } ).length > 0 ) {
            return true;
        }
        return false;
    }

    private var _sprite : Image;
    private var _angle  : Float;
    private var _alive  : Bool;
    private var _items  : Array<String>;
    public  var scared  : Float;
    public  var light   : Light;
}