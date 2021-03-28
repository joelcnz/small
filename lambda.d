//#May 2010 and Feb 2012, also Nov 2012
//#not work with name.safe
//#.. hey, but I'm not using lambda here!
import std.stdio;
import std.algorithm;
import std.ascii;

version(all) {
void main() {
	class Valid {
		string name;
		string delegate(string) safe;
		
		this() {
			safe = (string s) {
				if (any!"a == ' ' || std.ascii.toLower(a) == 'q' "(s))
					return "Warning: text contains space(s) or Q's";

				return s;
			};

			name = "Pluto";
			writeln(safe(name)); //#not work with name.safe
			name = "a bit dodge";
			writeln(safe(name));
			name = "AQHere";
			writeln(safe(name));
		}
	}
	
	auto valid = new Valid();
	
	auto safe2 = (string s) {
		if (any!"a == ' ' || std.ascii.toLower(a) == 'q'"(s))
			return "Warning: text contains space(s) or Q's";

		return s;
	};

	string name;
	name = "Pluto";
	writeln(safe2(name));
	name = "a bit dodge";
	writeln(safe2(name));
	name = "AQHere";
	writeln(safe2(name));
	
	// these work at module level definition functions (name.safe3() instead of safe3(name))
	name = "Pluto";
	writeln(name.safe3());
	name = "a bit dodge";
	writeln(name.safe3());
	name = "AQHere";
	writeln(name.safe3());
}

auto safe3(string s) {
	if (any!"a == ' ' || std.ascii.toLower(a) == 'q'"(s))
		return "Warning: text contains space(s) or Q's";

	return s;
}

/+
 +  //C#
	class Test {
		Func<string,string> safe = t => {
		   if( String.IsNullOrWhitespace(t) ){
			  return String.Empty;
		   }else{
			 return t;
		  }
		};
	}

		Person person = new Person {
		  FirstName = safe( recordSet["FirstName"]),
		  LastName = safe( recordSet["LastName"]),
		  ...
		};
	}
+/
}

version(none) {
//#.. hey, but I'm not using lambda here!
string test(string name) {
   if(name[0] == 'J' ){
      return "Joel";
   }else{
     return name;
  }
}

void main() {
	writeln(test("Jack"));
	writeln(test("Zed"));
}
}

version(none) {
import std.stdio, std.string, std.algorithm;

void main() {
	int[] arr = [5, 8, 4, 23, 6];
	string[] arrs = split("aaa cc Bb");
	
	void display1() { writeln( arr ); writeln(); }
	void display2() { writeln( arrs ); writeln(); }

	auto display = &display1;
	display();
	sort!((a, b) => a < b)(arr);
	display();
	sort!"a > b"(arr);
	display();
	
	display = &display2;
	display();
	sort!((a, b) => toLower(a) < toLower(b) )(arrs);
	display();
}
}
