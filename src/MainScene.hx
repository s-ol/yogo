import entities.Door;
import entities.GiveItem;
import entities.Teleporter;
import flash.geom.Point;
import com.pdev.lighting.Light;
import entities.RectEntity;
import com.haxepunk.tmx.TmxObject;
import flash.display.Bitmap;
import entities.Enemy;
import com.pdev.lighting.display.BitmapGraphics;
import com.pdev.lighting.occlusion.ShadowCircle;
import com.pdev.lighting.occlusion.ShadowSegment;
import com.pdev.lighting.LightEngine;
import com.pdev.lighting.PointInt;
import com.pdev.tools.LightTool;
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

        lightEngine = new LightEngine();
        lightEngine.paletteMap = LightTool.paletteMap( [ 0x0000ff00, 0xaa005500, 0xff000000], [0, 180, 256]);

        var map = new TmxMap( Assets.getText( "maps/map.tmx" ) );
        _level = new TmxEntity( map );
        _level.loadGraphic( "graphics/tileset.png", ["floor", "items"] );
        _level.layer = 21;

        //HXP.screen.scale = Math.min( HXP.screen.width / map.fullWidth, HXP.screen.height / map.fullHeight ) * 2;
        //HXP.setCamera( map.fullWidth / 2 - HXP.halfWidth / HXP.screen.scale - 100, map.fullHeight / 2 - HXP.halfHeight / HXP.screen.scale - 100);

        player = new Player( 10, 20, LightTool.radialLightMap( 600, 600, 1.0 ) );

        for( object in _level.map.getObjectGroup( "objects" ).objects )
        {
            if ( object.type == "spawn" ) {
                player.x = object.x;
                player.y = object.y;
            } else if ( object.type == "monster" ) {
                var enemy = new Enemy( Std.int(object.x), Std.int(object.y) );
                lightEngine.addOccluder( enemy.occluder );
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
        }

        for ( line in _level.map.getObjectGroup( "objects" ).polylines )
        {
            var occ:ShadowSegment = new ShadowSegment();
            for ( point in line.points )
                occ.add( new PointInt( Std.int(point.x), Std.int(point.y) ) );
            occ.isClosed = false;
            lightEngine.addOccluder( occ );
        }

        add( _level );

        _bmps = new Array<Bitmap>();

        lightCanvas = new BitmapData( HXP.width, HXP.height, true, 0xff000000 );
        var b = new Bitmap( lightCanvas );
        _bmps.push(b);
        HXP.stage.addChild( b );

        scareBar = new BitmapData( HXP.width, HXP.height, true, 0x00000000 );
        b = new Bitmap( scareBar );
        _bmps.push(b);
        HXP.stage.addChild( b );

        lightEngine.addLight( player.light );
        add( player );
	}

    public override function update()
    {
        super.update();
        HXP.camera.x = player.x - HXP.halfWidth;
        HXP.camera.y = player.y - HXP.halfHeight;

        var x = HXP.width - 40;
        var y = HXP.height - 100;
        var dy = Std.int( player.scared * -20 );
        var dx = Std.int( 40 / 200 * dy );
        var color = Std.int( (10 - player.scared) / 10 * 255 ) << 8 | Std.int( player.scared / 10 * 255 ) << 16 | 0xff000000;

        scareBar.fillRect( scareBar.rect, 0x00000000);
        BitmapGraphics.drawLine( scareBar, x, y, x, y + dy, color );
        BitmapGraphics.drawLine( scareBar, x, y + dy, x + dx, y + dy, color );
        BitmapGraphics.drawLine( scareBar, x, y, x + dx, y + dy, color );
        scareBar.floodFill( x - 1, y - 10, color );

        lightEngine.render( lightCanvas, Std.int(player.x - HXP.halfWidth), Std.int(player.y - HXP.halfHeight) );
    }

    public function replaceLight( light:Light, newLight:Light ) {
        lightEngine.removeLight( light );
        lightEngine.addLight( newLight );
    }

    public override function end() {
        for ( bmp in _bmps )
           HXP.stage.removeChild( bmp );
        super.end();
    }

    public  var player          : Player;
    public  var lightCanvas     : BitmapData;
    public  var lightEngine     : LightEngine;
    public  var scareBar        : BitmapData;
    private var _level          : TmxEntity;
    private var _bmps           : Array<Bitmap>;
}