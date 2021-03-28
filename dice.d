/+
Dice program

use: just list 6 unique numbers, representing a side of a die each
+/

struct Side {
	int side;
	string toString() const {
		import std.string;
		return format("==%s", side);
	}
}

void main() {
	Side[] dice;
	import std.range;
	import std.random;
	import std.stdio;
	
	dice.length = 6;
	dice[] = Side(0);
	
	int rand() {
		int nc;
		bool ifThere() {
			foreach(n; dice) {
				if (n.side == nc)
					return true;
			}
			
			return false;
		}

		do {
			nc = uniform!"[]"(1, 6);
		} while(ifThere);
		
		break1: foreach(i, d; dice[0..6])
			if (d.side == 0) {
				dice[i].side = nc;
				break break1;
			}
		
		return nc;
	}

	dice.
	map!(a => rand).
	writeln;
	
	// Throw 3 dice


	writeln("Roll 3 times:");
	dice.take(3).map!(a => uniform!"[]"(1, 6)).array.writeln();
	
	//Another way
	auto nums = iota(1,6+1).array;
	void shuffle() {
		void swap(int a, int b) {
			int tmp;
			tmp = nums[a];
			nums[a] = nums[b];
			nums[b] = tmp;
		}
		foreach(a; 0 .. 6)
			swap(a, uniform!"[]"(1, 6) - 1);
	}
	
	shuffle;
	writeln(nums);
	shuffle;
	writeln(nums);
}
