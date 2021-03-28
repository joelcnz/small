import std.stdio;

struct Get {};
struct Set {};

struct Thing {
	@(Get, Set) int _age;
	@(Get, Set) string _name;

	//<mixin>
}

auto getSet(alias T)() {
	import std.traits;
	
	string result;
	
	foreach(memberName; __traits(allMembers, T)) {
		writef("The attributes of %-8s:", memberName);
		
		foreach(attr; __traits(getAttributes, 
									__traits(getMember, T, memberName))) {
										writef(" %s", attr.stringof);
			static if (is(attr == Get))
				result ~=  "<type>" ~ " " ~ memberName[1 .. $] ~ "() { return " ~ memberName ~ "; }\n";
			static if (is(attr == Set))
				result ~=  "void " ~ memberName[1 .. $] ~
					"(<type> " ~ memberName[1 .. $] ~ ") { " ~ memberName ~ " = " ~ memberName[1 .. $] ~ "0; }\n";
		}
		writeln;
	}
	
	return result;
}

void main() {
	writeln(getSet!Thing);
}