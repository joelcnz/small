//#interest
/**
Date: 17/06/2011
Comment: Started on Ryan's Mac laptop, just unzip one the dmd folder
(with other folders in it) then used the command prompt and text editor
to make a program. Did the program in D's OSX bin folder.
*/
module main;

import std.stdio: writeln, write;
import std.string: split, toLower;
import std.conv: to;
import std.algorithm: sort;

void main( string[] args ) {
    writeln( "Hello OSX D world!" );
   
    if ( args.length == 1 )
        args ~=
            "I had a horrible accident, I got glue all over my pjs. " ~
            "Now I'm stuck in bed!";
    version( none )
        args ~= "I tackled a bucket of pengwanes -Hamish";

    auto lists = new PList!IList;
	/+
	with( lists )
        add( new List!string( args[1].split ) ),
        add( new List!int( [ 5, 8, 4, 67, 25, 102, 45, 42 ] ) ),
        add( new List!double( [ 3.9, 55.6, 50.2, 104.67, 4.5, 32.42 ] ) ),
		add( new List!Square( [ new Square(10), new Square( 5 ) , new Square(42) ] ) );
	+/
	// add objects of some time. meat is the type + the data. eg. mixin(samwich("int([1,2,3])"));
	string samwich(string meat) {
		return "lists ~= new List!" ~ meat ~ ";";
	}
	
	mixin(samwich("string(args[1].split)"));
	mixin(samwich("int( [ 5, 8, 4, 67, 25, 102, 45, 42 ])")); // with(lists) new List!int([1, 2, 3]));
    mixin(samwich("double( [ 3.9, 55.6, 50.2, 104.67, 4.5, 32.42 ] )"));
	mixin(samwich("Square( [ new Square(10), new Square( 5 ) , new Square(42) ] )"));

	writeln( "Number of lists: ", lists.length );
    foreach( list; lists )
        with( list )
            writeln( list ),
            doSort,
            writeln( list );
	
	writeln( `add( new Bop( "` ~ "cat" ~ `" ) )` ); // prototype
	
	string addBop( string thing ) {
		return `add( new Bop( "` ~ thing ~ `" ) );`;
	}
	
	// Welcome to the bops part of the program.
	auto bops = new PList!Bop;
	void addBop1( string thing ) {
		with( bops )
			add( new Bop( thing ) );
	}
	with( bops ) {
		add( new Bop( "house" ) );
		mixin( addBop( "shed" ) );
		addBop1( "roof" );
		
		void print() {
			foreach( item; bops ) {
				writeln( item );
			}
		}
		writeln( "first:" );
		print;

        Bop[] arr;
        foreach( bop; bops )
			arr ~= bop;

		// 1) short and quick, but inflexible
		//arr.sort.reverse;
		//arr.reverse;

		// 2)
        //bool strComp(Bop a, Bop b) { return a < b; }
		//sort!strComp( arr );
		
		// 2)
		//sort!((a, b) => a < b)(arr);

		//3)
		sort!"a < b"(arr);
		
		emptyList;
        foreach( item; arr ) {
            add( item );
        }
        writeln( "Sorted:" );
        print;
	}
	
	auto sq1 = new Square(33);
	auto sq2 = new Square(33);
	writeln(sq1, " & ", sq2, " are the same number? ", sq1 == sq2);
	sq2 = new Square(18);
	writeln(sq1, " & ", sq2, " are the same number? ", sq1 == sq2);
}

class Bop {
	this( string thing ) {
		m_thing = thing;
	}
	
	override string toString() {
		return m_thing;
	}
	
	override int opCmp( Object obj ) {
		alias m_thing a;
		auto bop = cast(Bop)obj;
		auto b = bop.thing;
		writeln( '>', a, ' ', b );
		if (a.toLower < b.toLower)
			return -1;
		else if (a.toLower > b.toLower)
			return 1;
		return 0;
	}
	
	string thing() {
		return m_thing;
	}
	
private string m_thing;
}

immutable NodeClass =
	"private class Node {
		this( T item ) {
			data = item;
		}
		T data;
		Node next;
	}";

class PList( T ) {
	mixin( NodeClass );

	int opApply(int delegate(ref T) dg) { // foreach (t; thg)
        int result = 0;

        auto current = head;
        while( current !is null ) {
            result = dg( current.data );
            if ( result )
				break;
            current = current.next;
        }

        return result;
	}

    size_t length() {
        size_t count = 0;
        auto current = head;
        while( current !is null ) {
            count++;
            current = current.next;
        }
        return count;
    }

	void opOpAssign(string op)(T obj) {
		add(obj);
	}
	
    void add( T obj ) {
        if ( head is null ) {
            head = new Node( obj );
            return;
        }
        auto current = head;
        while( current.next !is null ) {
            current = current.next;
        }
        current.next = new Node( obj );
    }
   
    T opIndex( int iTarg ) {
        int i = 0;
        auto current = head;
        while( current !is null && i != iTarg ) {
            ++i;
            current = current.next;
        }
        return current.data;
    }
    
    void emptyList() {
		head = null;
	}
private:
    T _obj;
    Node head;
}

interface IList {
    void doSort();
}

class List(T) : IList {
	mixin( NodeClass );

    this( T[] items ) {
		  add( items );
    }
    
	int opApply(int delegate(ref T) dg) { // foreach (t; thg)
        int result = 0;

        auto current = head;
        while( current !is null ) {
            result = dg( current.data );
            if ( result )
				break;
            current = current.next;
        }
        
        return result;
	}
	
	void add( T[] items ) {
        foreach( item; items ) {
            add( item );
        }
	}

    void add( T item ) {
        if ( head is null ) {
            head = new Node( item );
            return;
        }
        auto current = head;
        while( current.next !is null ) {
            current = current.next;
        }
        current.next = new Node( item );
    }
   
    void doSort() {
        T[] arr;
        auto current = head;
        while( current !is null ) {
            arr ~= current.data;
            current = current.next;
        }
        static if ( is( T == string ) ) {
			//#interest
			// 1) bulky
			bool strComp(string x, string y) {
				 return x.toLower < y.toLower;
			}
			sort!strComp( arr );
			// 2) alright
			//sort!((x, y) => std.ascii.toLower( x ) < std.ascii.toLower( y ))( arr );
			// 3) not work
			//sort!( "tolower( a ) < tolower( b )", SwapStrategy.stable)( arr );
		}
		else
			sort!"a < b"( arr );
        head = null;
        foreach( item; arr ) {
            add( item );
        }
    }
   
    override string toString() {
		string text;
		
		text = T.stringof ~ ": [ ";
		foreach( current; this )
			text ~= to!string( current ) ~ ' ';
		text ~= ']';

		return text;
    }
private:
    Node head;
}

import std.math;
class Square {
    this( double number ) {
         this.number = number;
    }

    double square( double n ) {
        return n ^^ 2;
    }
	
	override bool opEquals(Object other) {
		return abs(number - (cast(Square)other).getNumber) < 0.001;
	}
    
    override int opCmp( Object obj ) {
		auto rhs = cast( typeof( this ) )obj;
		if ( rhs !is null )
			if ( this.number > rhs.number )
				return 1;
			else if ( this.number < rhs.number )
				return -1;
			else
				return 0;
		return super.opCmp( rhs );
    }
   
    override string toString() {
        return to!string( number ) ~ ':' ~ to!string( square( number ) );
    }
	
	double getNumber() {
		return number;
	}
private:
    double number;
}
