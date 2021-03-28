//Note: not complete!
//#aliases to mutable thread-local data not allowed
//This file is based from 'The D programming language' book page 399
/**
Author: Joel Ezra Christensen
Date: July 4, 2010
Discription: Learning threads
*/
import std.concurrency, std.stdio, std.string;
import jeca.all;

mixin(Jeca.pragmalibs);

const HOLD = "while(key[ALLEGRO_KEY_SPACE]) { poll_input(); }";
const ARROW1 = 0, ARROW2 = 1;

void main(string[] args) {
	Init(args);
	scope(exit) Deinit();

	Arrow[] arrows;
	arrows ~= new Arrow(0, 50, ">==>", 10, ALLEGRO_KEY_LCTRL);
	arrows ~= new Arrow(0, 100, ">>--->", 11, ALLEGRO_KEY_RIGHT);

	// spawn two arrows
	//foreach (arrowIndex; 0 .. 2)
//		spawn(&fly, arrows[arrowIndex]); //#aliases to mutable thread-local data not allowed
	do {
		foreach (arrowIndex; 0 .. 2)
			arrows[arrowIndex].update;
		poll_input();
		if (key[ALLEGRO_KEY_1])
			arrows[ARROW1].move(0);
		if (key[ALLEGRO_KEY_2])
			arrows[ARROW2].move(0);
		al_flip_display();
		al_rest(0.05);
	} while (! key[ALLEGRO_KEY_ESCAPE]);
}

void fly(Arrow arrow) {
	do {
		arrow.update;
		al_rest(arrow.pauseTime / 100);
		mixin(HOLD);
	} while (! key[ALLEGRO_KEY_ESCAPE]);
}

class Arrow {
private:
	int _x, _y;
	string _sprite;
	int _pauseTime;
	int _burstKey;
public:
	this(int x, int y, string sprite, int pause, int burstKey) {
		_x = x;
		_y = y;
		_sprite = sprite;
		_pauseTime = pause;
		_burstKey = burstKey;
	}
	int pauseTime() { return _pauseTime; }
	void move(int newPos) {
		clean;
		_x = newPos;
	}
	void clean(int x = -1) {
		if (x != -1)
			x = 0;
		else
			x = _x;
		al_draw_filled_rectangle(x, _y, x + _sprite.length * 8, _y + 7, Colour.black);
	}
	void update() {
		move(_x + 1);
		if (_x > DISPLAY_W)
			_x = 0;
		//textprintf_ex(screen, font, _x, _y, Colour.amber, -1, toStringz(_sprite));
		if (_x + _sprite.length * 8 >= DISPLAY_W)
			clean(0); //,textprintf_ex(screen, font, _x - SCREEN_W, _y, Colour.amber, -1, toStringz(_sprite));
		//al_draw_filled_rectangle(_x, _y, _x + _sprite.length * 8, _y + 7, Colour.amber);
	}
}
