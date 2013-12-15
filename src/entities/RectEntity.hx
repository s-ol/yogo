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
        var seg = new ShadowSegment( x, y );
        seg.add( new PointInt(0,0) );
        seg.add( new PointInt(w,0) );
        seg.add( new PointInt(w,h) );
        seg.add( new PointInt(0,h) );
        occluder = seg;
    }

    public var occluder : ILightOccluder;
}