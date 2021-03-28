// 21 3 2020 10:22am
// See also char2num2.d
void main(string[] args) {
	import std;

	struct Nums {
		int id;
		string lets;
	}
	Nums[] nms = [{1, "AJS"},{2,"BKT"},{3,"CLU"},{4,"DMV"},{5,"ENW"},{6,"FOX"},{7,"GPY"},{8,"HQZ"},{9,"IR"}];
	
	if (args.length == 1) {
		args ~= "dolfin simpson billgates orange diamond coronavirus eventtwooone".split ~
			"deankoontz prophet china virus plague covid stephen picard".split ~
				"RaceWar Police Masonry Federal Secrecy Order Clinton Bonjovi ribbon".split ~
					"sweeney robert priest october howard".split;
	}

//	args.each!(arg => )

	foreach(arg; args[1..$]) {
		int total;
		foreach(l; arg.toUpper) {
			foreach(nums; nms)
				if (nums.lets.canFind(l))
					total += nums.id;
		}
		writeln(arg, " - ", total);
	}
}