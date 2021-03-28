import std.stdio;
import std.conv;

void main() {
	Thing[] thgs;
	Point[] pnts = [ Point( 0, 50 ), Point( 100, 50 ), Point( 50, 50 ) ];
	thgs ~= [ cast(Thing)new Car( pnts[ 0 ] ), new Box( pnts[ 1 ] ), new Car( pnts[ 2 ] ) ];

	Seperated[] sep;
	sep ~= new Display( thgs );
	sep ~= new Movement( thgs );
	
	auto finish = 10;
	while( finish > 0 ) {
		(cast(Display)sep[ 0 ]).displayAll;
		(cast(Movement)sep[ 1 ]).moveAll;
		--finish;
	}
}

immutable Seperated_ctor =
"this( Thing[] thgs ) {
		m_thgs = thgs;
	}
";

abstract class Seperated {
	protected Thing[] m_thgs;
}

class Movement: Seperated {
	mixin( Seperated_ctor );
	
	void moveAll() {
		foreach( thg; m_thgs ) {
			thg.move;
		}
	}
}

class Display: Seperated {
	mixin( Seperated_ctor );
	
	void displayAll() {
		foreach( thg; m_thgs ) {
			thg.display;
		}
	}
}

struct Point {
	int x, y;
	string toString() {
		return text( '(', x, ',', y, ')' );
	}
}

abstract class Thing {
	Point pnt;
	abstract void move();
	abstract void display();
}

class Car: Thing {
	this( Point p ) {
		pnt = p;
	}
	
	override void move() {
		pnt.x += 2;
	}
	override void display() {
		writeln( "Car - ", pnt );
	}
}

class Box: Thing {
	this( Point p ) {
		pnt = p;
	}
	
	override void move() {
	}
	override void display() {
		writeln( "Box - ", pnt );
	}
}
