import std.stdio; 
import std.algorithm;

class TreeNode
{
	private TreeNode left, right; 
	private int item; 
	this(int item)
	{
		this.item = item; 
	}
	static TreeNode bottomUpTree(int item, int depth)
	{
		TreeNode t; 
		ChildTreeNodes(t, item, depth-1);
		return t; 
	}
	static void ChildTreeNodes(out TreeNode node, int item, int depth)
	{
		node = new TreeNode(item);
		if(depth > 0)
		{
			ChildTreeNodes(node.left, 2*item - 1, depth -1);
			ChildTreeNodes(node.right, 2*item, depth -1);
		}
	}
	int itemCheck()
	{
		if(right is null) return item; 
		else return item + left.itemCheck() - right.itemCheck(); 
	}
}

void main(string[] args)
{
	const int minDepth = 4;
	int n = 0; 
	//if (args.length > 0) n = parse!int(args[0]);
	int maxDepth = max(minDepth + 2, n);
	int stretchDepth = maxDepth + 1; 
	int check = (TreeNode.bottomUpTree(0, stretchDepth)).itemCheck();
	writeln("stretch tree of depth ", stretchDepth, " check: ", check);
	TreeNode longLivedTree = TreeNode.bottomUpTree(0, maxDepth); 
	for(int depth = minDepth; depth <= maxDepth; depth +=2)
	{
		int iterations = 1 << (maxDepth - depth + minDepth);
		check = 0; 
		for(int i = 1; i <= iterations; i++)
		{
			check += (TreeNode.bottomUpTree(i, depth)).itemCheck(); 
			check += (TreeNode.bottomUpTree(-i, depth)).itemCheck(); 
		}
		writeln(iterations * 2, " trees of depth ", depth, " check: ", check);
	}
	writeln("long lived tree of depth ", maxDepth, " check: ", longLivedTree.itemCheck()); 
}

