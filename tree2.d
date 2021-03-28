//http://forum.dlang.org/thread/twhxdjpcorscltrfacze@forum.dlang.org
import std.stdio;

struct Tree
{
    this(string data, Tree[] children...)
    {
		this.data = data;
        this.children = children;
    }

	string data;
    Tree[] children;
}

void main()
{
	auto tree = Tree("data1",
					 Tree("data2",
						  Tree("Data3"),
						  Tree("Data4")),
					 Tree("data5",
						  Tree("data6")));
	
	writeln(tree.data);
	foreach (child; tree.children)
	{		
		writeln("    ", child.data);
		foreach (subChild; child.children)
		{
			writeln("        ", subChild.data);
		}
	}
}
