package entities;

import com.haxepunk.Graphic;
import com.haxepunk.Entity;

class GraphicsEntity extends Entity {
    public override function new( image : Graphic )
    {
        super();
        graphic = image;
    }
}