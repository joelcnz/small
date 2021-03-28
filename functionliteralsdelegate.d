// function and delegate literals
import std.stdio, std.range, std.string, ascii = std.ascii, std.random;

void main() {
	auto findPos = (int a) { return a >= 0; };

	writeln(find!int(findPos, [5,87,3,4,-1,-6,8]));
	writeln(find!int((a) => a >= 0, [5,87,3,4,-1,-6,8]));
	writeln(find!int((a) => a >= 0, []));
	
	more();
	
	yetMore();
}

auto find(T)(bool function(T) dg, T[] arr) {
	for(; !arr.empty() && dg(arr[0]); arr.popFront()) {
	}
	
	return arr;
}

void more() {
	gun((a) { if (a<0) writeln("Negitive ", a * -1); else writeln("Positive ", a); } );
}

void gun(void function(int) funl) {
	foreach(x; [56,7,423,6,-2,45,-7]) {
		funl(x);
	}
}

void yetMore() {
	writeln(jfilter!(a => a < 0)([56,88,-54,34,5,-7,3,32,2,49]));
	writeln(jfilter!"a < 0"([56,88,-54,34,5,-7,3,32,2,49]));
	alias toLowerAscii = std.ascii.toLower;
	import std.conv;
	auto names = "Alan Joel Timothy Neville Jeremy Joy Ria";
	writeln("Every name: ", names);
	writeln("Filter out names not starting with 'J'.");
	writeln(jfilter!(a => a[0].toLower == 'j')(names.to!(char[]).split));
}

T[] jfilter(alias filt, T)(T[] arr) {
	T[] result;
	for(; !arr.empty(); arr.popFront()) {
		if (filt(arr.front())) {
			result ~= arr.front();
		}
	}
	
	return result;
}

T[] jfilter(string filt, T)(T[] arr) {
	T[] result;
	for( ; !arr.empty(); arr.popFront()) {
		T a = arr.front();
		if (mixin(filt)) {
			result ~= a;
		}
	}
	
	return result;
}
