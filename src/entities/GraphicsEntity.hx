package entities;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.utils.Key;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Image;
import com.haxepunk.Graphic;
import com.haxepunk.Entity;

class GraphicsEntity extends Entity {
    public override function new( image : Image, x:Int = 0, y:Int=0, scale:Int=0, callback:Void->Void=null )
    {
        super(x, y);
        image.scale = scale;
        image.centerOrigin();
        graphic = image;
        setHitbox( Std.int(image.scaledWidth), Std.int(image.scaledHeight), Std.int(image.scaledWidth / 2), Std.int(image.scaledHeight / 2) );
        callBack = callback;
    }

    public override function update() {
        super.update();
        if ( ( (collidePoint( x, y, Input.mouseX, Input.mouseY ) && Input.mouseDown) || Input.pressed( Key.SPACE ) ) && callBack != null ) {
            callBack();
        }
    }

    public var callBack : Void->Void;
}