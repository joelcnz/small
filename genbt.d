//Trying to convet it to a 2D array, some I can make games or so
import std.string;
import std.random;
import core.stdc.stdio;
import core.stdc.time;
import std.conv;
import std.stdio;

int xrand()
{
	static int lr = 0;
	lr = cast(int)uniform!"[]"(0, int.max);

	return lr;
}

char[][] a;

void genbt(int w, int h)
{
	int x,y,v;
	w *= 2;
	char[] s1, s2;
	s1.length = s2.length = w;

	import std.range;
//	std.stdio.writeln("+", '-'.repeat(w + 1), "+");
//	std.stdio.writeln("|", ' '.repeat(w + 1), "|");
	a.length = 50;
//	foreach(i; 0 .. 50)
//		a[i].length = 50;
//	a[0].length = 40;
	a[0] = text("+", '-'.repeat(w + 1), "+").dup;
	a[1] = text("|", ' '.repeat(w + 1), "|").dup;
		
	for(y = 0; y < h; y++)
	{
		for(x = 0; x < w;)
		{
			v = (xrand>>3)&1;
			s1[x] = '#';
			s2[x++] = v ? ' ' : '#';
			s1[x] = v ? '#' : ' ';
			s2[x++] = ' ';
		}
		a[y+2] = format("| %s|\n| %s|\n",s1[0],s2[0]).dup;
//		printf("| %s|\n| %s|\n",&s1[0],&s2[0]);
	}
	a[h] = text("+", ' '.repeat(w + 1), "+").dup;
	
	foreach(line; a)
		writeln(line);
}

int main(string[] args)
{
	if (args.length != 3)
		args ~= ["20","10"];
	//srand(time(null));
	if(args.length <= 2) return 1;
	genbt(to!int(args[1]), to!int(args[2]));

	return 0;
}
