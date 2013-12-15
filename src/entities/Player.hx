package entities;

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

        super.update();
    }

    public function scare( e:Enemy ) : Void {
        scared += distanceFrom( e ) / 800;
    }

    private var _sprite : Image;
    private var _angle  : Float;
    public  var scared   : Float;
    public  var light   : DirectionalLight;
}