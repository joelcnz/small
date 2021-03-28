import std.stdio;

void main() {
	char[] s=new char[10];
	s[]='C';
	writeln(s);
	s="".dup;
	while (s.length<50)
		s~="Cat";
	s.length=50;
	writeln(s);
	char[] word="Cat".dup;
	foreach (w; 0..s.length/word.length)
		foreach (i, l; word)
			s[i]=l;
	writeln('[', s, ']');
	s.length = 0;
	writeln('[', s, ']'); // just a extra space
}
