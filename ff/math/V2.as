package ff.math
{
	import ff.M;

	public final class V2
	{
		public var x : Number;
		public var y : Number;
		
		public function V2( _x : Number = 0, _y : Number = 0 )
		{
			x = _x;
			y = _y;
		}
		
		public static function add( a : V2, b : V2 ) : V2 { return new V2( a.x + b.x, a.y + b.y ); }
		public static function subtract( a : V2, b : V2 ) : V2 { return new V2( a.x - b.x, a.y - b.y ); }
		public static function mult( a : V2, b : V2 ) : V2 { return new V2( a.x * b.x, a.y * b.y ); }		
		public static function divide( a : V2, b : V2 ) : V2 { return new V2( a.x / b.x, a.y / b.y ); }
		
		public static function scale( v : V2, b : Number ) : V2 { return new V2( v.x * b, v.y * b ); }
		public static function neg( v : V2 ) : V2 { return new V2( -v.x, -v.y ); }
		public static function clone( v : V2 ) : V2 { return new V2( v.x, v.y ); }
		
		public static function normalized( v : V2 ) : V2
		{
			var fMag : Number = v.mag();
			return new V2( v.x / fMag, v.x / fMag );
		}
		
		public static function rotated( v : V2, r : Number ) : V2
		{
			var vNew : V2 = new V2( v.x, v.y );
			vNew.rotateBy( r );
			return vNew;
		}
		
		public static function dot( a : V2, b : V2 ) : Number {	return a.x * b.x + a.y * b.y; }
		public static function normal( v : V2 ) : V2 { return new V2( v.y, v.x ); }
		public static function det( a : V2, b : V2 ) : Number { return a.x * b.y - a.y * b.x; }
		
		public function plus( v : V2 ) : void { x += v.x; y += v.y; }
		public function minus( v : V2 ) : void { x -= v.x; y -= v.y; }
		public function times( v : V2 ) : void { x *= v.x; y *= v.y; }
		public function divBy( v : V2 ) : void { x /= v.x; y /= v.y; }
		public function scaleBy( v : Number ) : void { x *= v; y *= v; }
		public function cp( v : V2 ) : void { x = v.x; y = v.y; }
		public function place( _x : Number, _y : Number ) : void { x = _x; y = _y; }
		
		public function rotateBy( r : Number ) : void
		{
			var sin:Number = Math.sin( r );
			var cos:Number = Math.cos( r );
			var x2:Number = cos * x - sin * y;
			var y2:Number = sin * x + cos * y;
			x = x2;
			y = y2;
		}
		
		public function zero() : void { x = 0; y = 0; }
		public function one() : void { x = 1; y = 1; }
		public function unitX() : void { x = 1; y = 0; }
		public function unitY() : void { x = 0; y = 1; }
		public function invert() : void { x = -x; y = -y; }
		public function normalize() : void { scaleBy( 1 / mag() ); }
		
		public function mag() : Number { return Math.sqrt(x * x + y * y); }
		public function magSquare() : Number { return x * x + y * y; }

		public function equal( v : V2 ) : Boolean { return x == v.x && y == v.y; }
		public function gt( v : V2 ) : Boolean { return x > v.x && y > v.y; }
		public function gte( v : V2 ) : Boolean { return x >= v.y && y >= v.y; }
		public function lt( v : V2 ) : Boolean { return x < v.x && y < v.y; }
		public function lte( v : V2 ) : Boolean { return x <= v.x && y <= v.y; }
	}
}