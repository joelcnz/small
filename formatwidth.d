//Org: Learn Forum http://forum.dlang.org/thread/mqwalzvqzrrhhepnfhxn@forum.dlang.org
import std.stdio, std.range, std.conv, std.array;

void formatWidthIotaToStr(ref string formatStr, int[] inputRange) 
{
	
	formatStr ~= ";;";
	int formatWidth = 30, lenStr = formatStr.length;
	
	foreach (e; inputRange) {
		lenStr += e.text.length;
		if (lenStr < formatWidth) {
			lenStr += 2;
			formatStr ~= ' ', formatStr ~= e.text, formatStr ~= ',';
		}
		else {
			formatStr ~= "\n;; ", formatStr ~= e.text, formatStr ~= ',';
			lenStr = e.text.length + 5;
		}
	}
	
	formatStr.length -= 1;
	formatStr ~= '.';
}

void main() {
	
	auto a = iota(10, 1101).array;
	
	string s;
	
	formatWidthIotaToStr(s, a);
	
	writeln(s);
}
