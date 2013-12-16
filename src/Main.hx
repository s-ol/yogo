import com.haxepunk.Sfx;
import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{

#if debug
        HXP.console.enable();
#end
        try {
        _music = new Sfx( "audio/AlteredCarbon-Reptilian.mp3" );
        _music.loop(); } catch (e:Dynamic) trace(e);
        HXP.scene = new MenuScene();
	}

	public static function main() { new Main(); }
    private var _music : Sfx;
}