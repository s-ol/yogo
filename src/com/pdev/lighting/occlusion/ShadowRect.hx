package com.pdev.lighting.occlusion;
import com.pdev.lighting.Light;
import com.pdev.lighting.LightEngine;
import com.pdev.lighting.PointInt;
import de.polygonal.ds.SLL;
import flash.display.BitmapData;
import flash.geom.Rectangle;

/**
 * ...
 * @author P Svilans
 */

using com.pdev.lighting.display.BitmapGraphics;

class ShadowRect implements ILightOccluder
{
	
	public var x:Int;
	public var y:Int;
	public var rotation:Float;
	
	private var w:Int;
    private var h:Int;
	
	private var _bounds:Rectangle;

	public function new( radius:Int, x:Int = 0, y:Int = 0, w:Int=0, h:Int=0)
	{
		_bounds = new Rectangle();
		
		this.x = x;
		this.y = y;
        this.w = w;
        this.h = h;
	}
	
	/* INTERFACE com.pdev.lighting.occlusion.ILightOccluder */
	
	public function init( light:Light):SLL<PointInt> 
	{
        var r = light.radius;

        light.canvas.drawLine( x+light.x+r, y+light.y+r, x+w+light.x+r, y+light.y+r, LightEngine.BOUND_COLOUR );
        //light.canvas.drawLine( x+w+light.x+r, y+light.y+r, x+w+light.x+r, y+h+light.y+r, LightEngine.BOUND_COLOUR );
        //light.canvas.drawLine( x+w+light.x+r, y+h+light.y+r, x+light.x+r, y+h+light.y+r, LightEngine.BOUND_COLOUR );
        //light.canvas.drawLine( x+light.x+r, y+h+light.y+r, x+light.x+r, y+light.y+r, LightEngine.BOUND_COLOUR );

		var e = new SLL<PointInt>();
        e.append( new PointInt( x, y));
        e.append( new PointInt( x+w, y));
		//e.append( new PointInt( x+w, y+h));
        //e.append( new PointInt( w, y+h));
		
		return e;
	}
	
	private function get_bounds():Rectangle 
	{
        _bounds.width = w;
        _bounds.height = h;
		_bounds.x = x;
		_bounds.y = y;
		return _bounds;
	}
	
	public var bounds(get_bounds, null):Rectangle;

    public function callback( light : Light ) : Void {

    }
}