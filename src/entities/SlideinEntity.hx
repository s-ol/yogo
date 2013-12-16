package entities;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import entities.GraphicsEntity;

class SlideinEntity extends GraphicsEntity {
    public override function new( image : Image, x:Int = 0, y:Int=0, scale:Int=0, dx:Int = 0, dy:Int = 0, delay:Int=0 )
    {
        var xx = Std.int(HXP.sign(dx) * (-HXP.halfWidth-image.width*scale) + HXP.halfWidth);
        var yy = Std.int(HXP.sign(dy) * (-image.height*scale-HXP.halfHeight) + HXP.halfHeight);
        if ( dx == 0 ) xx = x;
        if ( dy == 0 ) yy = y;
        super( image, xx, yy, scale );
        _destx = x;
        _desty = y;
        _dx = dx;
        _dy = dy;
        _delay = delay;
    }

    public override function update() {
        if ( _delay-- > 0 )
            return;
        if ( ( _dx < 0 && x > _destx) || ( _dx > 0 &&x < _destx ) )
            x += _dx;
        if ( ( _dy < 0 && y > _desty) || ( _dy > 0 && y < _desty ) )
            y += _dy;
    }

    private var _destx:Int;
    private var _desty:Int;
    private var _dx:Int;
    private var _dy:Int;
    private var _delay:Int;
}