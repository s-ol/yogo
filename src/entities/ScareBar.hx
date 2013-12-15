package entities;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

class ScareBar extends Entity {

    public override function new( x:Int, y:Int, p:Player ) {
        super( x, y );
        _player = p;
        _image = new Image( "graphics/redtest.png" );
        _image.scrollX = 0;
        _image.scrollY = 0;
    }

    public override function update() {
        super.update();
        _image.scaledWidth = _player.scared * 10;
    }

    private var _player : Player;
    private var _image  : Image;
}