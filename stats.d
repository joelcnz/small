//Top
import std.exception, std.stdio, std.string;

interface Stat {
	void accumulate(double x);
	void postprocess();
	double result();
}

class IncermentalStat: Stat {
	protected double _result;
	abstract void accumulate(double x);
	void postprocess() {}
	double result() {
		return _result;
	}
}

class Min: IncermentalStat {
	this() {
		_result = double.max;
	}
	override void accumulate(double x) {
		if (x < _result) {
			_result = x;
		}
	}
}

class Total: IncermentalStat {
	this() {
		_result = 0;
	}
	override void accumulate(double x) {
		_result += x;
	}
}

class Average: IncermentalStat {
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

class Max: IncermentalStat {
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

void main(string[] args) {
	if (args.length == 1)
		args = "skip Min Max Average Total".split();

	Stat[] stats;
	foreach(arg; args[1 .. $]) {
		auto newStat = cast(Stat)Object.factory("stats." ~ arg);
		enforce(newStat, "Invalid statistics function: " ~ arg);
		stats ~= newStat;
	}
	auto data = [4,30,1979,37,70];
	writeln(data);
	foreach(x; data) {
		foreach(s; stats) {	
			s.accumulate(x);
		}
	}
	foreach(i, s; stats) {
		s.postprocess();
		writeln(args[i+1], ": ", s.result);
	}
}
