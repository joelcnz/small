//#might work!
//#why does with(sortBy) not work?
import std.stdio, std.string, std.conv, std.algorithm, std.array;

@property bool empty(T)(T[] a) { return a.length == 0; }
@property ref T front(T)(T[] a) { return a[0]; }
void popFront(T)(ref T[] a) { a = a[1..$]; }

V jreduce(alias fun, V, R)(V x, R range)
	if (is(typeof(x == x) == bool))
{
	for(;!range.empty ;range.popFront())
		x = fun(x, range.front);
	return x;
}

auto jreduce(string pred, R)(R range) {
	typeof(range.front) a = 0, b;
	for(;!range.empty ;range.popFront()) {
		b = range.front;
		a = mixin(pred);
	}
	return a;
}

double average(double[] values...) {
	return jreduce!((a, b) { return a+b; })(0.0, values) / values.length;
}

void main() {
	auto a = [4, 2, 3, 1];
	auto r = array( filter!( "a < 3" )( a ) );
	assert( r == [ 2, 1 ] );
	
	void print(T)( T[] arr, string header = "" ) {
		writeln( header, arr );
	}
	
	auto arr = [ 1, 2, 3 ];
	print( arr, "Starting with: " );
	print( [ jreduce!"a + b"( arr ) ], "Sum Total: " ); // 6

	writeln( map!"a * a"( arr ) ); // 1 4 9
	writeln();

	List!int list;
	list.add( [ 2, 4, 6 ] );
	print( list[] );
	writeln( map!"a * a"( list[1..list.length] ) );
	
	List!string str;
	//foreach( name; [ "house", "cat", "mouse" ] )
	//	str.add(name);
	str.add("house cat mouse".split());
	print(str[]);
	writeln(str);
	print(str[1..str.length]);

	writeln(list, " -> average = ", average(to!(double[])(list[])));
	
	List2!int list2;
	with(list2) {
		add( 'J', 1979, "Joel" ); // this is the right year 
		add( 'N', 1946, "Neville" ); // I think this is the right year
		add( 'D', 1940, "Doug" ); // I don't know what year
		writeln(list2);
		
		writeln();
		setSort(Sorted.character);
		doSort();
		writeln(list2);
	}
	
	writeln("Biggest char: ", cast(char)list2.biggest);
}

struct List(T) {
	struct Thing {
		T m_obj;
		
		this( T obj ) {
			m_obj = obj;
		}
		
		@property T data() {
			return m_obj;
		}
		
		string toString() {
			return to!string( m_obj );
		}
	}

	Thing[] m_things;
	
	ulong length() {
		return m_things.length;
	}
	
	string toString() {
		string result;
		foreach(i, s; m_things) {
			result ~= to!string(s) ~ (i == m_things.length-1 ? "" : ", ");
		}
		return result;
	}

	//void add( T element ) {
	//	m_things ~= Thing(element);
	//}
	void add(T[] elements) {
		foreach(element; elements)
				m_things ~= Thing(element);
	}
	
	T[] opSlice() {
		T[] result;
		result.length = m_things.length;
		foreach( index, thing; m_things )
			result[ index ] = thing.data;
		return result;
	}
	
	T[] opSlice(ulong s, ulong e) {
		T[] result;
		foreach( index; s .. e )
			result ~= m_things[index].data;
		return result;
	}
}

struct List2(T) {
	enum Sort {character, number, text};
	Sort sortBy;
	import std.string;
	struct Thing2 {
		this( char c, int r, string text ) {
			m_character = c;
			m_integer = r;
			m_text = text;
		}
		
		int character() {
				return cast(int)m_character;
		}
		
		int integer() {
				return m_integer;
		}
			
		int text() {
			return std.conv.to!int(m_text.toLower);
		}
		
		string toString() {
			return format( '[', m_character, ", ", m_integer, ", ", m_text, ']' );
		}

		int opCmp(T)(T other) {
			//#why does with(sortBy) not work?
			final switch(sortBy) {
				case sortBy.character:
					return character - other.character;// (cast(Thing2)other).character;
				break;
				case sortBy.number:
					return 0;
				break;
				case sortBy.text:
					return 0;
				break;
			}
			return 0;
		}

	private:
		char m_character;
		int m_integer;
		string m_text;
	}
	Thing2[] m_objs;
	
	void add(char c, int i, string t) {
		m_objs ~= Thing2(c, i, t);
	}
	
	string toString() {
		string result;
		foreach(obj; m_objs)
			result ~= std.conv.text(obj, " \n");
		return result;
	}
	
	void setSort(Sort sortBy) {
		this.sortBy = sortBy;
	}

	void doSort() {
		sort!"a < b"(m_objs);
	}
	
	int biggest() {
		int result = int.min;
		
		/* //#might work!
		m_objs.
		map!((a) {
			if (c.character > result)
				result = c.character;
			
			return a;
		}).
		array;
		*/
		foreach(c; m_objs)
			if (c.character() > result)
				result = c.character();
		return result;
	}
}

