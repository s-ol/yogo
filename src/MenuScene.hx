package ;
import com.haxepunk.graphics.Image;
import entities.GraphicsEntity;
import entities.SlideinEntity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;

class MenuScene extends Scene
{
	public override function begin()
	{
        add( new SlideinEntity( new Image( "graphics/gui/youonly.png"), Std.int(HXP.halfWidth), Std.int(HXP.height * 0.1), 10, 0, 10 ) );
        add( new SlideinEntity( new Image( "graphics/gui/getone.png"),  Std.int(HXP.halfWidth), Std.int(HXP.height * 0.35), 10, 15, 0, 30 ) );
        add( new SlideinEntity( new Image( "graphics/gui/breath.png"),  Std.int(HXP.halfWidth), Std.int(HXP.height * 0.6), 10, -15, 0, 50 ) );
        add( new SlideinEntity( new Image( "graphics/gui/whenyourescared.png"), Std.int(HXP.halfWidth), Std.int(HXP.height * 0.75), 4, 0, -20, 100 ) );
        add( new GraphicsEntity( new Image( "graphics/gui/play.png" ), Std.int(HXP.halfWidth), Std.int(HXP.height * 0.9), 10, start ) );
    }

    public function start() : Void {
        HXP.scene = new MainScene();
    }
}