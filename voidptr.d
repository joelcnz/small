//Org: learn fourm: http://forum.dlang.org/thread/udbpqnctllqzkhwymmrv@forum.dlang.org
import std.stdio;

void main() {
	string[void*] aa;
	
	void function() fp, fp2;
	
	aa[fp] = "fp";
	aa[fp2] = "fp2";
	writeln(aa);
	
	int[string] strInt;
	strInt["1"] = 10;
	strInt["2"] = 20;
	writeln(strInt);
}
