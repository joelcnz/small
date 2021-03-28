//Ref: stats.d
import std.exception, std.stdio, std.string;

interface Stat {
	void accumulate(double);
	void postprocess();
	double result();
}

abstract class IncrementalStat: Stat {
	protected double _result;
	abstract void accumulate(double);
	void postprocess() {}
	double result() {
		return _result;
	}
}

class Min: IncrementalStat {
	this() {
		_result = double.max;
	}
	override void accumulate(double x) {
		if (_result > x)
			_result = x;
	}
	override void postprocess() {}
}

class Max: IncrementalStat {
	this() {
		_result = double.min_normal;
	}
	override void accumulate(double x) {
		if (x > _result) {
			_result = x;
		}
	}
	override void postprocess() {}
}

class Average: IncrementalStat {
	private uint items;
	this() {
		_result = items = 0;
	}
	override void accumulate(double x) {
		_result += x;
		++items;
	}
	override void postprocess() {
		if (items) {
			_result /= items;
		}
	}
}

class Total: IncrementalStat {
	this() {
		_result = 0;
	}
	override void accumulate(double x) {
		_result += x;
	}
	override void postprocess() {}
}

void main() {
	auto args = "skip Min Average Max Total".split();
	Stat[] stats;
	foreach(arg; args[1..$]) {
		auto newStat = cast(Stat)Object.factory("classpractise." ~ arg);
		enforce(newStat, "Invalid statistics function: " ~ arg);
		stats ~= newStat;
	}
	auto data = [1,2,3,4];
	data.writeln;
	foreach(d; data)
		foreach(s; stats)
			s.accumulate(d);
	foreach(i, s; stats) {
		s.postprocess();
		writefln!"%s: %2.1f"(args[i+1], s.result());
	}
}
