import com.pdev.lighting.PointInt;
import entities.Door;
import entities.GiveItem;
import entities.Teleporter;
import flash.geom.Point;
import com.pdev.lighting.Light;
import entities.RectEntity;
import com.haxepunk.tmx.TmxObject;
import com.pdev.lighting.occlusion.ShadowSegment;
import entities.ScareBar;
import entities.Enemy;
import flash.display.Bitmap;
import com.pdev.tools.LightTool;
import com.pdev.lighting.LightEngine;
import com.pdev.lighting.occlusion.ShadowCircle;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import flash.display.BitmapData;
import openfl.Assets;
import entities.Player;

class MainScene extends Scene
{
	public override function begin()
	{
        //add( new GraphicsEntity( new Backdrop( "graphics/tiles.jpg" ) ) );
        HXP.stage.color = 0xff000000;
        _lightEngine = new LightEngine();
        _lightEngine.paletteMap = LightTool.paletteMap( [ 0x0000ff00, 0xaa005500, 0xff000000], [ 0, 180, 256]);

        var map = new TmxMap( Assets.getText( "maps/map.tmx" ) );
        _level = new TmxEntity( map );
        _level.loadGraphic( "graphics/tileset.png", ["floor", "items"] );
        _level.layer = 21;

        //HXP.screen.scale = Math.min( HXP.screen.width / map.fullWidth, HXP.screen.height / map.fullHeight ) * 2;
        //HXP.setCamera( map.fullWidth / 2 - HXP.halfWidth / HXP.screen.scale - 100, map.fullHeight / 2 - HXP.halfHeight / HXP.screen.scale - 100);

        player = new Player( 10, 20, LightTool.radialLightMap( 600, 600, 1.0 ) );

        try {
        for( object in _level.map.getObjectGroup( "objects" ).objects )
        {
            if ( object.type == "spawn" ) {
                player.x = object.x;
                player.y = object.y;
            } else if ( object.type == "monster" ) {
                var enemy = new Enemy( Std.int(object.x), Std.int(object.y) );
                _lightEngine.addOccluder( enemy.occluder );
                add( enemy );
            } else if ( object.type == "teleporter" ) {
                add( new Teleporter( Std.int(object.x), Std.int(object.y), Std.parseInt(object.custom.resolve("dx")), Std.parseInt(object.custom.resolve("dy")) ) );
            } else if ( object.type == "giveitem") {
                add( new GiveItem( Std.int(object.x), Std.int(object.y), object.custom.resolve("item")));
            } else if ( object.type == "door") {
                add( new Door( Std.int(object.x), Std.int(object.y), Std.parseInt(object.custom.resolve("cx")), Std.parseInt(object.custom.resolve("cy")), object.custom.resolve("key")));
            } else {
                var r:RectEntity = new RectEntity( Std.int(object.x), Std.int(object.y), Std.int(object.width), Std.int(object.height), "walls" );
                add( r );
            }
            trace("object");
        }


        trace("asd");
        for ( line in _level.map.getObjectGroup( "objects" ).polylines )
        {
            var occ:ShadowSegment = new ShadowSegment();
            for ( point in line.points )
                occ.add( new PointInt( Std.int(point.x), Std.int(point.y) ) );
            occ.isClosed = false;
            _lightEngine.addOccluder( occ );
            trace("line");
        }
        trace("bsf");

        add( _level ); } catch ( e:Dynamic ) trace( e );

        _lightCanvas = new BitmapData( HXP.width, HXP.height, true, 0xff000000 );
        HXP.stage.addChild( new Bitmap( _lightCanvas ) );

        _lightEngine.addLight( player.light );
        add( player );
	}

    public override function update()
    {
        super.update();
        HXP.camera.x = player.x - HXP.halfWidth;
        HXP.camera.y = player.y - HXP.halfHeight;
        _lightEngine.render( _lightCanvas, Math.round(player.x - HXP.halfWidth), Math.round(player.y - HXP.halfHeight) );
    }

    public function replaceLight( light:Light, newLight:Light ) {
        _lightEngine.removeLight( light );
        _lightEngine.addLight( newLight );
    }

    public  var player          : Player;
    private var _lightEngine    : LightEngine;
    private var _lightCanvas    : BitmapData;
    private var _level          : TmxEntity;
}