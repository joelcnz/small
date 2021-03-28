//Org: http://www.codinghorror.com/blog/2007/02/why-cant-programmers-program.html
import std.stdio;

void main() {
	for(int i=0;i < 100;writefln(i%3==0?i%5==0?"Fizzbuzz":"FIZZ":i%5==0?"BUZZ":"%d",i++)) 
	{}
}
