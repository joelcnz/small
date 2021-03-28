//#works on Joy's TV
import std.stdio, std.string;
import jeca.all;

mixin(Jeca.pragmalibs);

void main(string[] args) {
	//Init("-mode full -wxh 1920 1080".split); //#works on Joy's TV
//	Init("-m full -wxh 1280 800".split);
	Init("-m auto".split);
	scope(exit) Deinit();
	writeln(DISPLAY_W, 'x', DISPLAY_H);
	auto t = new Test(); t.fun();
	do {
		poll_input();
		al_clear_to_color(Colour.black);
		al_draw_rectangle(0.5,0.5, DISPLAY_W - 1, DISPLAY_H - 1, Colour.white, 1);
		al_flip_display();
		al_rest(0.1);
	} while(! key[ALLEGRO_KEY_ESCAPE]);
}

class Test {
	int cat;
	string dog;
	void fun() {
		cat = 13;
		dog = "Fetch!";
		foreach (i,    v; this.tupleof )
			writeln(`'`, v, '`');
	}
}
