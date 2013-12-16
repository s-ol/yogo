package ;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.Entity;
import entities.GraphicsEntity;
import com.haxepunk.graphics.Backdrop;
import entities.GraphicsEntity;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import entities.GraphicsEntity;
import entities.SlideinEntity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;

class MenuScene extends Scene
{
	public override function begin()
	{
        _start = false;
        _clicked = false;
        add( new SlideinEntity( new Image( "graphics/gui/youonly.png"), Std.int(HXP.halfWidth), Std.int(HXP.height * 0.1), 10, 0, 10 ) );
        add( new SlideinEntity( new Image( "graphics/gui/getone.png"),  Std.int(HXP.halfWidth), Std.int(HXP.height * 0.35), 10, 15, 0, 30 ) );
        add( new SlideinEntity( new Image( "graphics/gui/breath.png"),  Std.int(HXP.halfWidth), Std.int(HXP.height * 0.6), 10, -15, 0, 50 ) );
        add( new SlideinEntity( new Image( "graphics/gui/whenyourescared.png"), Std.int(HXP.halfWidth), Std.int(HXP.height * 0.75), 4, 0, -20, 100 ) );
        add( new GraphicsEntity( new Image( "graphics/gui/play.png" ), Std.int(HXP.halfWidth), Std.int(HXP.height * 0.9), 10, start ) );
    }

    public function start() : Void {
        if ( _start && !_clicked )
            HXP.scene = new MainScene();
        else {
            _start = true;
            add( new Entity( 0, 0, new Backdrop( "graphics/gui/white.png" ) ) );
            add( new GraphicsEntity( new Image( "graphics/gui/instructions.png" ), Std.int(HXP.halfWidth), Std.int(HXP.halfHeight), 6, start ) );
        }
        _clicked = true;
    }

    public override function update() {
        super.update();
        if ( !Input.mouseDown && !Input.pressed( Key.SPACE ) )
            _clicked = false;
    }

    var _start : Bool;
    var _clicked : Bool;
}