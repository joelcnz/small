void main() {
	import std;
	zip(iota(1,10+1,1),"I went for a walk and fell down a hole.".split).
		each!((i,z) => writeln("[",i,"] ",z[0],". ",z[1]));
}