import std;

void main() {
	writeln("Donkey plonks!");
	for(float y=1.0;y > -1.0; y -= 0.05) {
	    for(float x=2.0; x > 0.5; x -= 0.0315)
	        abs(mandelbrot(x+y)) < 2 ? write("*") : write(".");
		writeln();
	}
}

auto mandelbrot(double a) {
    double z = 0;
    foreach(i; 1 .. 50) {
        z = z.pow(2) + a;
    }
    return z;
}
