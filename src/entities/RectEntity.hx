package entities;

import com.pdev.lighting.PointInt;
import com.pdev.lighting.occlusion.ShadowSegment;
import com.pdev.lighting.occlusion.ShadowCircle;
import com.pdev.lighting.occlusion.ILightOccluder;
import com.haxepunk.Entity;

class RectEntity extends Entity {
    public override function new( x:Int, y:Int, w:Int, h:Int, type:String ) {
        super( x, y );
        setHitbox(w, h);
        this.type = type;

        //occluder = new ShadowSegment(x, y);
        //occluder.x = x;
        //occluder.y = y;

        //obj.isClosed = true;

        //engine.addOccluder( obj);

        /*/
        occluder = new ShadowSegment( Std.int( Math.random() * 500), Std.int( Math.random() * 500));
        occluder.add( new PointInt( -5, -5));
        occluder.add( new PointInt( 5, -5));
        occluder.add( new PointInt( 5, 5));
        occluder.add( new PointInt( -5, 5));

        occluder.isClosed = true;
        /*/
        occluder = new ShadowSegment( Std.int(x+w/2), Std.int(y+h/2) );
        occluder.add( new PointInt(Std.int(-w/2),Std.int(-h/2)) );
        occluder.add( new PointInt(Std.int(w/2),Std.int(-h/2)) );
        occluder.add( new PointInt(Std.int(w/2),Std.int(h/2)) );
        occluder.add( new PointInt(Std.int(-w/2),Std.int(h/2)) );
        occluder.isClosed = true;
        /*/
        /*/
    }

    public var occluder : ShadowSegment;
}