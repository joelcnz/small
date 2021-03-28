void main() {
	import std.stdio;
	writeln("Program ran.");
}

struct Stack(T, size_t expectedMaxSize = 32) {
	T[expectedMaxSize] initialBuffer;
	T[] buffer;
	size_t currentPosition;
	bool isEmpty() { return currentPosition == 0; }
	void push(T item) {
		if (buffer is null)
			buffer = initialBuffer[];
		if (currentPosition == buffer.length)
			buffer.length += 64;
		buffer[currentPosition++] = item;
	}
	T pop() {
		if (currentPosition == 0)
			throw new Exception("Empty stack cannot pop.");
		return buffer[--currentPosition];
	}
}

struct StackView(T) {
	private  const(T)[] data;
	private this(const(T)[] data) {
		this.data = data;
	}

	@property bool empty() const {
		return data.length == 0;
	}

	@property const(T) front() const {
		return data[$ - 1];
	}

	void popFront() {
		data = data[0 .. $ - 1];
	}

	@property auto view() const {
		return StackView!T(buffer[0 .. currentPosition]);
	}
}
