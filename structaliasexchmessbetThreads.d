// some of this file is from 'The D programming language' book page 401 - 402
// other stuff origin from news groups
import std.concurrency, std.stdio, std.exception;

//start 2
// note knocks off the last item, not displaying it
struct UserDefinedAttribute(Args...)
{
//	alias Args[$ - 1] pop
	alias Args[0 .. $ - 1] attributes;
}

// redundant, it's built in now
void userDefine() {
	UserDefinedAttribute!("my attr", int) a;
	UserDefinedAttribute!("my attr", 4, int) b;

	writeln(typeof(a).attributes.stringof);
	writeln(typeof(b).attributes.stringof);
}
// end 2 (other than call in main)

//start 1
enum __FUNCTION = q{ __traits(identifier, __traits(parent, {})) };
enum __FUNCTION_SIGNATURE = q{ typeof(__traits(parent, {})).stringof };

// I think this is old, use __FUNCTION__, and a pretty function one too
void functionName(int x = 0) {
	writefln( "File: %s, Func: %s, FuncSig: %s, Line: %d", __FILE__, mixin(__FUNCTION), mixin(__FUNCTION_SIGNATURE), __LINE__ );
}
//end 1 (other than call in main)

void main() {
	userDefine();
	functionName(); // 1
	auto low = 0, high = 100;
	auto tid = spawn(&writer);
	foreach (i; low .. high) {
		writeln("Main thread: ", i);
		tid.send(thisTid, i);
		enforce(receiveOnly!Tid() == tid);
	}
}

void writer() {
	for(;;) {
		auto msg = receiveOnly!(Tid, int)();
		writeln("Secondary thread: ", msg[1]);
		msg[0].send(thisTid);
	}
}
