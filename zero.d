alias NonZero = AbituaryRestriction!("value == 0", "Value cannot be 0");
template AbituaryRestriction(string restriction, string reason) {
	struct AbituaryRestriction(T) {
		T value;
		alias value this;
	
		this(T value) {
			this.value = value;
		}
		
		invariant() {
			if (mixin(restriction)) {
				throw new Exception(reason);	
			}
		}
		
		void opAssign(float value) {
			this.value = value;	
		}
	}
}

void main() {
	NonZero!float ft = 0.5f;
	
	import std.stdio;
	import std.range;
	foreach(i; iota(/+ from: +/ 5, /+ to: +/ -5, /+ step: +/-1)) { // from 5 to -5 step -1
		writeln("Number ", i);
		ft = i;
	}
}

