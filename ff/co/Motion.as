package ff.co
{
	import ff.math.*;
	
	public class Motion extends Base
	{
		public var vPos : V2 = new V2;
		public var vVel : V2 = new V2;
		public var vAcc : V2 = new V2;
		
		override public function Update( timeDelta : Number ) : void
		{
			vPos.plus( V2.add(
				V2.scale( vVel, timeDelta ),
				V2.scale( vAcc, 0.5 * timeDelta * timeDelta ) ) );
			
			vVel.plus( V2.scale(vAcc, timeDelta) );				
		}
	}
}