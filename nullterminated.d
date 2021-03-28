void main() {
	import std.stdio;
	wchar* ch = cast(wchar*)"I went for a walk and fell down a hole.";
	foreach(c; nullTerminated!(typeof(ch))(ch))
		write(c);
	writeln;
}

auto nullTerminated(C)(C c) {
    struct NullTerminated(C)
    {
        private C _front;
        ///
        this(C c)
        {
            _front = c;
        }
        ///
        @property bool empty()
        {
            return *_front == 0;
        }
        ///
        auto front()
        {
            return *_front;
        }
        ///
        void popFront()
        {
            ++_front;
        }
        ///
        C save()
        {
            return _front;
        }
    }
    return NullTerminated!C(c);
}

