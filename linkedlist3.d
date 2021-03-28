//What a disaster! My programming is next to nothing!
module unit;

import std.stdio;

void main() {
	UnitList!int ints;
	ints.append(1);
}

class UnitList(T) {
private:
	T m_head, m_tail;
public:
	@property ref T head() { return m_head; }
	@property ref T tail() { return m_tail; }


	string opString() const {
		string data;
		return data;
	}
	
	void append(T newUnit) {
		if (tail is null) {
			head = tail = newUnit;
		}
		else {
			tail.next = newUnit;
			newUnit.previous = tail;
			tail = newUnit;
		}
	}

	int opApply(int delegate(ref T) dg) { // foreach (t; thg)
        int result = 0;

		Unit current = head;
		while (current !is null) {
			result = dg(current);
			if ( result )
				break;
			current = current.next;
		}
		return result;
	}

	int opApply(int delegate(ref int i, ref T) dg) { // foreach (i, t; thg)
        int result = 0;

		int i = 0;
		Unit current = head;
		while (current !is null) {
			result = dg(i, current);
			if ( result )
				break;
			++i;
			current = current.next;
		}
		return result;
	}

	T[] opSlice(int start, int end) {
		size_t len = length();
		if (end < 0)
			end=cast(int)len+end+1; // eg len=5 end=-1 -> end=len
		T[] slice;
		int pos = 0;
		T current = head;
		while(current !is null && pos != start) {
			pos++;
			current = current.next;
		}
		while (current !is null && pos != end) {
			slice~=current;
			pos++;
			current = current.next;
		}
		return slice;
	}

	T opIndex(uint index)
	{
		uint position = 0;
		T current = head;
		while (current.next !is null && position != index) {
			position++;
			current=current.next;
		}
		if (position != index)
			return null;
		return current;
	}

	int length() {
		T current = head;
		int total = 0;
		while (current !is null) {
			++total;
			current = current.next;
		}
		return total;
	}

	//#not work
	size_t opDollar(T)(T d) {
		return length();
	}
	
	//alias length opDollar; //#not work for slices

	T remove(T node) {
		if (node.previous !is null) {
			node.previous.next = node.next; // previous points to next
		}
		else {
			head = node.next;
		}
		
		if (node.next !is null)	{
			node.next.previous = node.previous; // next points to previous
		}
		else {
			tail = node.previous;
		}
		
		return node.previous !is null ? node.previous : node.next !is null ? node.next : null;
	}
	
	void draw() {
		foreach( unit; this ) {
			writeln(unit);
		}
	}
}
