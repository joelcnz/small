//Guy rang for Cecily, but she not back
void main() {
	
	enum COUNT = 10;
	
	void doUnique(ref int[] arr) {
		int rand() {
		
			import std.random: uniform;

			return uniform!"[]"(1, COUNT);
		}
		
		++arr.length;
		int rc;
		bool unique;
		do {

			unique = true;
			rc = rand;
			foreach(a; arr) {
				
				if (a == rc) {
					unique = false;
					break;
				}
			}
			arr[$-1] = rc;
		} while(! unique);
	}
	
	int[] arr;
	foreach(a; 0 .. COUNT) {
	
		doUnique(/* int[] */ arr);
	}
	
	import std.stdio: writeln;
	writeln(arr);
}
