// Andrei Alexandrescu
module persistent_list;
import std.experimental.allocator;
import std.stdio;

struct List(T)
if (is(T == immutable) || is(T == const))
{
	import std.traits : hasMember;
    import std.algorithm : either;

	static assert(!is(typeof(this) == immutable),
		"Immutable List is not supported");
	
	private struct Node
	{
		T payload;
		Node* next;
		uint refs;
   	}

	// layout {
	private const(Node)* root;
	private IAllocator _allocator;
	// } layout

    private @trusted IAllocator allocator() const
    {
        return cast(IAllocator) _allocator;
    }

    private static @trusted void deallocate(const void* p, IAllocator allocator)
	{
        if (!p) return;
        assert(allocator);
		allocator.deallocate(cast(void[]) p[0 .. Node.sizeof]);
	}
	
	private @trusted static void incRef(const Node* n)
	{
		if (n) ++*(cast(uint*) &(n.refs));
	}
	
    private @trusted static void decRefUnchecked(const Node* n)
    {
        assert(n && n.refs > 1);
        --*(cast(uint*) &(n.refs));
    }
    
    private @trusted static void decRef(const Node* n)
    {
        if (n) decRefUnchecked(n);
    }
    
    // Entry point, decRef and destroy+deallocate if down to zero
    private static void decRef(const Node* n, IAllocator allocator)
    {
        assert(n && allocator);
        if (n.refs > 1)
        {
            decRefUnchecked(n);
            return;
        }
        static if (hasMember!(T, "__dtor"))
            n.payload.__dtor();
        allocator.deallocate((cast(void*) &n)[0 .. Node.sizeof]);
    }

    this(this)
	{
        assert(!root || allocator);
		incRef(root);
	}

	~this()
	{
        assert(!root || allocator);
        for (auto n = root; n;)
		{
			if (n.refs > 1)
			{
				decRefUnchecked(n);
				return;
			}
            assert(n.refs == 1);
			auto goner = n;
			n = n.next;
            // TODO: _destructRecurse is faster
            destroy(*goner);
			deallocate(goner, allocator);
		}
	}

	private this(const Node* n, IAllocator a)
	{
		root = n;
        _allocator = a;
        assert(!root || allocator);
    }

	/**
	 * Constructor taking direct values. Each must be convertible to $(D T).
	 * Complexity: $(BIGOH U.length).
	 */
	this(U...)(auto ref U values)
	{
		if (values.length == 0) return;
		auto tmp = cons(values[0], typeof(this)(values[1 .. $]));
        assert(tmp.allocator);
		root = tmp.root;
        _allocator = tmp.allocator;
		tmp.root = null;
	}

	/**
	 * Returns $(D true) iff the list is empty. Complexity: $(BIGOH 1).
	 */
	bool empty() const
	{
		return root is null;
	}

	///
	@safe unittest
	{
		List!(immutable int) lst;
		assert(lst.empty);
	}

	/**
	 * Returns a reference to the first element in the list. Complexity: $(BIGOH 1).
	 */
	ref T front() const
	{
		assert(root);
		return root.payload;
	}

	/**
	 * Returns a copy of the tail of the list.Complexity $(BIGOH 1). 
	 */
	List tail()
	{
		assert(root);
		auto n = root.next;
		incRef(n);
		return List(n, allocator);
	}
	/// ditto
	const(List) tail() const
	{
		assert(root);
		auto n = root.next;
		incRef(n);
		return const(List)(n, allocator);
	}

	/**
	 * Returns a new $(D List) consisting of $(D head) followed by the contents of $(D this).
	 * Complexity: $(BIGOH n).
	 */
	List opBinaryRight(string op)(T head)
		if (op == "~")
	{
        List result;
        result._allocator = either(allocator, theAllocator);
        import std.conv : emplace;
        void[] buf = result.allocator.allocate(Node.sizeof);
        auto n = emplace!(const Node)(buf, head, root, 1);
        incRef(root);
        result.root = n;
        return result;
    }
	/// ditto
	const(List) opBinaryRight(string op)(T head) const
		if (op == "~")
	{
        List result;
        result._allocator = either(allocator, theAllocator);
        import std.conv : emplace;
        void[] buf = result.allocator.allocate(Node.sizeof);
        auto n = emplace!(const Node)(buf, head, root, 1);
        incRef(root);
        result.root = n;
        return result;
    }
	
	/**
	 * Returns a new $(D List) consisting of $(D head) followed by the contents of $(D this).
	 * Complexity: $(BIGOH n).
	 */
	static List cons(T head, List tail)
	{
		return head ~ tail;
	}
	/// ditto
	static const(List) cons(T head, const(List) tail)
	{
		return head ~ tail;
	}

//	private List!T unqualifiedCopy() const
//	{
//		incRef(root);
//		return List(root);
//	}
//	alias unqualifiedCopy this;

	auto opSlice() inout
	{
		static struct Range
		{
			// layout {
			private const(Node)* root;
			private IAllocator allocator;
			// } layout 

			this(this)
			{
                incRef(root);
			}

			~this()
			{
                if (!root) return;
                assert(allocator);
                assert(root.refs >= 1);
                decRef(root, allocator);
            }

			bool empty() const
			{
				return !root;
			}

			ref T front() const
			{
				assert(root);
				return root.payload;
			}

			void popFront()
			{
				assert(root);
                auto goner = root;
				root = root.next;
                incRef(root);
                assert(goner.refs >= 1);
                decRef(goner, allocator);
			}

			Range save()
			{
                return this;
			}
		}
		incRef(root);
		auto result = Range(root, allocator);
		return result;
	}
}

unittest
{
	List!(immutable int) lst;
	lst = 42 ~ lst;
	assert(!lst.empty);
	assert(lst.front == 42);
	lst = 77 ~ lst;
	assert(lst.front == 77);
	lst = lst.tail;
	assert(lst.front == 42);

	auto range = lst[];
	assert(range.front == 42);
	assert(!range.empty);
	auto range1 = range.save;
	range.popFront;
	assert(range.empty);
	assert(!range1.empty);
	assert(range1.front == 42);
}

unittest
{
    const lst = List!(immutable int)(1, 2, 3);
    assert(lst.root.refs == 1);
    assert(lst.front == 1);
	auto lst2 = 42 ~ lst;
    assert(lst.root.refs == 2);
    assert(lst2.root.refs == 1);
    assert(lst2.front == 42);
	
	auto range = lst2[];
    assert(lst2.root.refs == 2);
    assert(!range.empty);
	assert(range.front == 42);
    //assert(lst.root.refs == 2);
    assert(lst2.root.refs == 2);
    auto range1 = range.save;
    assert(lst2.root.refs == 3);
    assert(range.root.refs == 3);
    range.popFront();
	assert(!range.empty);
	assert(range.front == 1);
	assert(!range1.empty);
	assert(range1.front == 42);
	
	writeln("Passed all tests!");
}

void main() {}
