//Is not complete, doesn't work for words longer than the collum width
import std.string: pwrap = wrap; // can be used, any way

import std.stdio;
import std.array;
import std.algorithm;

string wrap(string input,int width)
{
    string[] splat=input.split();
    string[] buffer;
    
    string[] ret;
    
    while(splat.length>0)
    {
        while(splat.length>0)
        {
            if((splat[0]~buffer).join(" ").length>width)
                break;
            buffer=splat[0]~buffer;
            splat=splat[1 .. $];
        }
        buffer.reverse();
        ret~=buffer.join(" ");
        buffer=[];
    }
    return ret.join("\n");
}

void main()
{
	string input="I went for a walk and fell down a hole.";
	int width=6;
	writeln(wrap(input,width));
	
	writeln(input.pwrap(6,null,null,0));
}
