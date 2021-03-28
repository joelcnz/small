import ufcs4c;

auto minus(T,T2)(Maths!T maths, T a, T2 b) {
	maths.value = a - b;
	
	return maths;
}
