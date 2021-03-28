/+
31 January 2015
1 February 2015
Dice - inner functions
+/

struct Die {
	Side[] sides;

	struct Side {
		int load; // from loaded a dice
		string toString() const {
			import std.conv;
			return load.to!string;
		}
	}
		
	void loadTheDice() {
		int nc;
		sides.length = 6;
		import std.random;
		void rand() {
			nc = uniform!"[]"(1,6);
		}
		bool isUnique() {
			foreach(const n; sides)
				if (n.load == nc)
					return false;
			return true;
		}
		
		foreach(ref s; sides) {
			do {
				rand;
			} while(! isUnique);
			s.load = nc;
		}
	}
	
	void print() {
		import std.stdio;
		
		foreach(const s; sides)
			write(s, " ");
		//write("\b");
	}
}

void main() {
	Die die;
	with(die)
		loadTheDice,
		print;
}
