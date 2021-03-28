struct TaskAndSubs {
	string _task;
	TaskAndSubs[] _sub;

	void add(string[] subs...) {
		foreach(task; subs) {
			_sub ~= TaskAndSubs(task);
		}
	}

	string toString() {
		return _task;
	}
}

void main() {
	import std.stdio;
	import std.string;
	import std.algorithm;
	import std.array;
	
	auto dataTop = "00Wake up|01Get up|02Get dressed|03Eat breakfast|04Brush teeth|05Computer";
	TaskAndSubs[] taskAndSubs;
	foreach(thing; dataTop.split("|"))
		taskAndSubs ~= TaskAndSubs(thing[2..$]);
	
	taskAndSubs[03].add("mouthfuls|till|empty plate".split("|"));
	taskAndSubs[04].add("brush|until|clean".split("|"));
	taskAndSubs[05].add("Turn on|wait for booting|do programming".split("|"));

	foreach(step; taskAndSubs) {
		writeln(step);
		foreach(subStep; step._sub)
			writeln(" ".replicate(2), subStep);
//			writeln(" ".replicate(2), "Too..hard!"); // step._sub._task);
	}
}

version(noOrder) {
//#wrong order!
struct Extra {
	size_t id;
	string direction;
	string[] subscripts;
	
	this(size_t id, string category) {
		this.id = id;
		direction = category;
	}
	
	string toString() {
		return direction;
	}
}

void main() {
	import std.stdio;
	import std.string;
	auto dataTop = "Wake up|Get up|Get dressed|Eat breakfast|Brush teeth|Computer";
	Extra[string] extra;
	foreach(i, thing; dataTop.split("|"))
		extra[thing] = Extra(cast(size_t)i, thing);
	
	extra["Eat breakfast"].subscripts = "mouthfuls|till|empty plate".split("|");
	extra["Brush teeth"].subscripts = "brush|until|clean".split("|");
	extra["Computer"].subscripts = "Turn on|wait for booting|do programming".split("|");
	
//	import std.algorithm;
//	extra = extra.values.sort!"a.id < b.id";
	
	//#wrong order!
	foreach(step; extra) {
		writeln(step);
		foreach(subStep; step.subscripts)
			writeln("	", subStep);
	}
	
	/+
	foreach(ex; extra) {
		import std.stdio;
		writeln(ex.direction);
		if (ex.subscripts.length > 0) {
			foreach(thing; ex.subscripts)
				writeln("	", thing);
		}
	}
	+/
}
} //version noOrder

/+
void getTopLevelInput(ref string[] cat) {
	import std.stdio;
	
	foreach(name; cat) {
		writeln(name);
	}
	string input;
	import std.stdio;
	writeln("Enter 'q' to quit");
	while1: while(true) {
		import std.string;
		input = readln.chomp;
		if (input != "q")
			cats ~= input;
		else
			break while1;
	}
}
+/
