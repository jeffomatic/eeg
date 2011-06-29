package ff.tweaker
{
	public class Item
	{
		public function Item( label:String = "" )
		{
			m_label = label;
			m_children = new Vector.<Item>;
		}
		
		final public function Select():void
		{
			m_selected = true;
			OnSelect();
		}
		
		final public function Unselect():void
		{
			m_selected = false;
			OnUnselect();			
		}
		
		final public function Click():void
		{
			OnClick();
			
			if ( m_tweakable )
			{
				m_tweaking = ! m_tweaking;
			}
		}
		
		final public function BackClick():void
		{
			OnBackClick();
			
			if ( m_tweaking )
			{
				m_tweaking = false;	
			}
			else 
			{
				if ( m_parent )
				{
					m_parent.OnChildBackClick();
				}	
			}
		}
		
		final public function AddChild( c : Item ):void
		{
			m_children.push( c );
			
			if ( m_children.length > 1 ) 
			{
				var prev:Item = m_children[ m_children.length - 2 ];
				var oldNext:Item = prev.m_next; // could be the next folder
				prev.m_next = c;
				c.m_prev = prev;
				c.m_next = oldNext;
			}
		}
		
		// Setters
		public function SetLabel( l : String ):void { m_label = l; }
		public function SetPrev( item:Item ):void { m_prev = item; }
		public function SetNext( item:Item ):void { m_next = item; }
		
		// Getters
		public function Parent():Item { return m_parent; }
		public function Prev():Item { return m_prev; }
		public function Next():Item { return m_next; }
		public function Children():Vector.<Item> { return m_children; }
		
		public function GetChild( label : String ):Item
		{
			for each ( var c:Item in m_children )
			{
				if ( c.m_label == label )
				{
					return c;
				}
			}
			
			return null;
		}
		
		public function IsSelected():Boolean { return m_selected; }
		public function IsTweakable():Boolean { return m_tweakable; }
		public function IsTweaking():Boolean { return m_tweaking; }
		public function Label():String { return m_label; }
		public function ValueText():String { return "[no value]"; }
		
		// Overridables
		protected function OnSelect():void {}
		protected function OnUnselect():void {}
		protected function OnClick():void {}
		protected function OnBackClick():void {}
		protected function OnChildBackClick():void {}
		
		public function OnAction( action : uint ):void {}		
		
		// Hierarchy
		protected var m_parent:Item;
		protected var m_prev:Item;
		protected var m_next:Item;
		protected var m_children:Vector.<Item>;
		
		// Flags
		protected var m_selected:Boolean;
		protected var m_tweakable:Boolean;
		private var m_tweaking:Boolean;
		
		// Other attributes
		private var m_label:String;
	}
}