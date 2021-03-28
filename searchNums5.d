void main() {
	int[] nums;
	nums.length = 1 + 10 + 1;
	enum Gate {closed, open}
	Gate[] gates; // all set to closed
	gates.length = nums.length;
	auto line = "";
	foreach(i; 1 .. nums.length - 1) {
		int rc;
		do {
			import std.random;
			
			rc = cast(int)uniform(1, nums.length - 1);
			
		} while(gates[rc] == Gate.open);
		
		gates[rc] = Gate.open;
		import std.string;
		line ~= format("%s ", rc);
		if (line.length + 3 > 3 * 10 || i == nums.length - 2) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}