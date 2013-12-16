package entities;

import UInt;
import com.haxepunk.graphics.Spritemap;
import com.pdev.lighting.occlusion.ShadowCircle;
import com.haxepunk.Entity;
import com.haxepunk.HXP;

class Enemy extends Entity {
    public function new( x:Int, y:Int ) {
        super( x, y );

        var _map = new Spritemap( "graphics/monster.png", 10, 10 );
        _map.scale = 2;
        _map.centerOrigin();
        _map.add( "move", [0,1,0,2], 12 );
        _map.add( "idle", [0], 10 );
        _map.play( "idle" );
        graphic = _map;

        setHitboxTo( graphic );
        type = "enemy";

        occluder = new EnemyOccluder( 10, this );
    }

    public override function update() {
        occluder.x = Math.round(x);
        occluder.y = Math.round(y);

        var player = cast(HXP.scene,MainScene).player;

        if ( distanceFrom( player, true ) < 2 ) {
            player.kill();
        }

        if ( HXP.scene.collideLine( "walls", Std.int(x), Std.int(y), Std.int(player.x), Std.int(player.y) ) == null ) {
            moveTowards( player.x, player.y, 1.5, "walls" );
            var light = player.light;

            if ( cast(HXP.scene,MainScene).lightCanvas.getPixel( Std.int(x - HXP.camera.x ) , Std.int(y - HXP.camera.y) ) != 256 ) {
                player.scare( this );
            }
        }

        super.update();
    }

    public  var occluder: ShadowCircle;
    private var _map    : Spritemap;
}