//What rubbish!
string createIt(string name, string op) pure {
	return "auto " ~ name ~ "() { " ~ op ~ " }";
}

void main() {
	mixin(createIt("hi", "= 1 + 1;"));
}
