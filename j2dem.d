// From Programming in D book
import std.stdio;

enum totalLines = 20;
enum totalColums = 60;

alias Line = dchar[totalLines];
alias Canvas = Line[];

void print(Canvas canvas) {
	foreach(line; canvas)
		writeln(line);
}

void putDot(Canvas canvas, int line, int column, dchar dot = '#')
{
	canvas[line][column] = dot;
}

void drawVerticalLine(
						Canvas canvas,
						int line,
						int column,
						int length)
{
	foreach(lineToPaint; line .. line + length) {
		putDot(canvas, lineToPaint, column);
	}
}

void directionPaint(Canvas canvas,int x, int y, int dx, int dy, int length, 
		   dchar dot)
{
	foreach(_; 0 .. length)
		putDot(canvas, y, x, dot),
		x += dx,
		y += dy;
}
	
void main()
{
	Line emptyLine = '.';
	
	Canvas canvas;
	
	foreach(i; 0 .. totalLines) {
		canvas ~= emptyLine;
	}
	
	putDot(canvas, 7, 3);
	drawVerticalLine(canvas, 5, 10, 4);
	directionPaint(canvas, 3, 2, 1,1, 5, '@');

	import std.string;
	import std.algorithm;
	writeln(canvas.map!(a => a.idup).join("\n"));
}
