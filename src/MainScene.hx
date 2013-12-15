import entities.RectEntity;
import entities.RectEntity;
import com.pdev.lighting.occlusion.ILightOccluder;
import com.pdev.lighting.occlusion.ShadowRect;
import com.haxepunk.tmx.TmxObject;
import com.pdev.lighting.PointInt;
import com.pdev.lighting.occlusion.ShadowSegment;
import com.haxepunk.graphics.Backdrop;
import entities.ScareBar;
import entities.Enemy;
import entities.GraphicsEntity;
import flash.display.Bitmap;
import com.pdev.tools.LightTool;
import com.pdev.lighting.LightEngine;
import com.pdev.lighting.DirectionalLight;
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


        for( object in _level.map.getObjectGroup( "objects" ).objects )
        {
            if ( object.type == "spawn" ) {
                player.x = object.x;
                player.y = object.y;
            } else if ( object.type == "monster" ) {
                var enemy = new Enemy( object.x, object.y );
                _lightEngine.addOccluder( enemy.occluder );
                add( enemy );
            } else {
                var r:RectEntity = new RectEntity( object.x, object.y, object.width, object.height, "walls" );
                _lightEngine.addOccluder( r.occluder );
                add( r );
            }
        }
        trace( "asd" );

        add( _level );

        _lightCanvas = new BitmapData( HXP.width, HXP.height, true, 0xff000000 );
        HXP.stage.addChild( new Bitmap( _lightCanvas ) );

        _lightEngine.addLight( player.light );
        add( player );

        add( new ScareBar( 20, HXP.height - 30, player ) );

	}

    public override function update()
    {
        super.update();
        //HXP.setCamera( player.x - HXP.halfWidth, player.y - HXP.halfWidth );
        HXP.camera.x = player.x - HXP.halfWidth;
        HXP.camera.y = player.y - HXP.halfHeight;
        _lightEngine.render( _lightCanvas, Math.round(player.x - HXP.halfWidth), Math.round(player.y - HXP.halfHeight) );
        //_lightEngine.render( _lightcanvas, 0, 0 );
    }

    public  var player          : Player;
    private var _lightEngine    : LightEngine;
    private var _lightCanvas    : BitmapData;
    private var _level          : TmxEntity;
}