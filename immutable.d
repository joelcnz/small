int x;
immutable int y;

pure int foo(int* p) {
	(*p)++;   // ok - or not!, my change here. Was '*p++;' before
	x++;      // error
	*p = x;   // error
	*p = y;   // ok
	for(int i; i < 10; i++) {
		(*p) += i; //ok, my change here
	}
	
	return x; // error
}
