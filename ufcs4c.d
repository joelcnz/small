class Maths(T) {
	T value;
	
	Maths plus(T2)(T a, T2 b) {
		value = a + b;
		return this;
	}
}
