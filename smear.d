module screen;

//Note: do not have prama(lib.. when using rdmd (but I think it works in Windows still).
mixin(Jeca.pragmalibs);

import std.stdio;
import std.string;
import std.math;
import std.random;
import std.array: split;
import std.algorithm;

import jeca.all;

//version = DUnit; // also one of these in the game module
version = Reset;

version(DUnit) {
	import dunit;

	pragma(msg, "Using DUnit");
}

immutable init = `
	//Init("-mode windowed -wxh 800 600".split());
	Init("-mode auto".split());
	//Init("-mode full -wxh 640 480".split());
	Init("-wxh 320 240".split());
	//Init("-mode full -wxh 800 600".split());
	`;

version(DUnit) {
	void main(string[] args) {
		mixin(init);
		scope(exit)
			Deinit(); //,
			//readln();
		
		//al_set_window_title(DISPLAY, "#TESTING - Balliters, by Joel Ezra Christensen".ptr);
		runTests_Tree();
	}
} else {
	// production
	void main(string[] args) {
		mixin(init);
		scope(exit)
			Deinit();

		al_set_window_title(DISPLAY, "Joel and Jeremy's screen saver. That heats up the computer too".ptr);

		float x, y, dx, dy;
		int colourCount = 0;
		
		void reset() {
			x = DISPLAY_W, y = DISPLAY_H /4, dx = -1, dy = -1;
		}
		reset();
		
		auto back = new Bmp(DISPLAY_W, DISPLAY_H);

		al_set_target_bitmap(back.bitmap);
		al_clear_to_color(Colour.black);
		al_set_target_backbuffer(DISPLAY);
		
		ubyte rnd() {
			return cast(ubyte)uniform(0, ubyte.max + 1);
		}

		auto newRandomColour() {
			return makecol(rnd(), rnd(), rnd());
		}

		float findDistanceToEdge(float x, float y, float dx, float dy) {
			float result = 0;

			while(x >= 0 && x <= DISPLAY_W
				&& y >= 0 && y <= DISPLAY_H) {
				result++;
				x += dx;
				y += dy;
				debug(10)
					mixin(trace("x y dx dy result".split()));
			}
			
			return result;
		}

		//auto currentColour = newRandomColour();
		auto startColour = Colour.black;
		auto endColour = Colour.white;
		auto currentColour = startColour;
		//auto startColour = newRandomColour();
		//auto endColour = newRandomColour();
		float total; // total distance before new colour
		float progress = 0f, progressStep;

		void doChange() {
			x += dx;
			y += dy;
			swap(startColour, endColour);
			endColour = newRandomColour();
			total = findDistanceToEdge(x, y, dx, dy); // total distance to next edge
			progress = 0f;
			progressStep = 1 / total;
		}
		doChange();
		
		void wipe(float x, float y, float w, float h) {
			al_draw_filled_rectangle(x, y, x + w, y + h, Colour.black);
		}
		FONT = al_load_font("DejaVuSans.ttf", 18, 0);

		// aways starts by going from white to black
		startColour = Colour.white;
		endColour = Colour.black;
		//al_clear_to_color(Colour.black);
		ubyte r1,g1,b1, r2,g2,b2, r3,g3,b3;

		// while not any of these
		//while(! any!((a) => a)([key[ALLEGRO_KEY_ESCAPE], exitHandler.doKeysAndCloseHandling()])) {
		//while(! (keypressed() || key[ALLEGRO_KEY_LSHIFT])) {
		//	poll_input();
		//}
		while(! any!((a) => a)([keypressed(),
			key[ALLEGRO_KEY_LSHIFT],
			key[ALLEGRO_KEY_LCTRL],
			key[ALLEGRO_KEY_RSHIFT],
			key[ALLEGRO_KEY_RCTRL],
			key[ALLEGRO_KEY_ALT],
			key[ALLEGRO_KEY_LWIN],
			key[ALLEGRO_KEY_RWIN],
			key[ALLEGRO_KEY_MENU],
			key[ALLEGRO_KEY_ALTGR],
			key[ALLEGRO_KEY_COMMAND],
			key[ALLEGRO_KEY_SCROLLLOCK],
			key[ALLEGRO_KEY_NUMLOCK],
			key[ALLEGRO_KEY_CAPSLOCK],
			exitHandler.doKeysAndCloseHandling()])) {
			poll_input();
			
			version(Reset) {
				while(key[ALLEGRO_KEY_SPACE]) { poll_input(); if (key[ALLEGRO_KEY_ESCAPE]) goto exit; }
				if (key[ALLEGRO_KEY_ENTER]) {
					al_set_target_bitmap(back.bitmap);
					al_clear_to_color(Colour.black);
					al_set_target_backbuffer(DISPLAY);
					progress = 0;
					doChange();
					reset();
				}
			}
			
			//colourCount++;
			//if (colourCount >= 100)
			//	currentColour = makecol(rnd(), rnd(), rnd()),
			//	colourCount = 0;
			//al_clear_to_color(Colour.black);
			//al_set_target_bitmap(back.bitmap);
			//al_draw_filled_circle(x, y, 7, currentColour); //, Colour.amber);
			//mixin(trace("total progressStep progress".split()));
			al_set_target_bitmap(back.bitmap);
			currentColour = getBlend(startColour, endColour, progress);
			al_draw_filled_circle(x, y, 7, currentColour);
			al_set_target_backbuffer(DISPLAY);
			al_draw_bitmap(back.bitmap, 0, 0, 0);
			//al_draw_filled_circle(x, y, 7, currentColour);
			progress += progressStep;
			
		version(ExtraStuff) {
			//wipe(0, 0, 800, 120);
			al_draw_filled_rectangle(0, 0, progress * total, 16, Colour.amber);
			al_draw_rectangle(0, 0, total, 16, Colour.white, 1);

			al_draw_text( FONT, Colour.black, 0, 41, ALLEGRO_ALIGN_LEFT,
				"test house cat".split()[uniform(0, $)].toStringz());
			al_draw_text( FONT, Colour.amber, 0, 40, ALLEGRO_ALIGN_LEFT,
				"test house cat".split()[uniform(0, $)].toStringz());
			al_draw_text( FONT, Colour.black, 0, 21, ALLEGRO_ALIGN_LEFT,
				std.conv.text("total: ", total, " progressStep: ", progressStep, " progress: ", progress).toStringz());
			al_draw_text( FONT, Colour.amber, 0, 20, ALLEGRO_ALIGN_LEFT,
				std.conv.text("total: ", total, " progressStep: ", progressStep, " progress: ", progress).toStringz());

			al_unmap_rgb( startColour, &r1, &g1, &b1 );
			al_unmap_rgb( endColour, &r2, &g2, &b2 );
			al_unmap_rgb( currentColour, &r3, &g3, &b3 );

			al_draw_text( FONT, Colour.black, 0, 61, ALLEGRO_ALIGN_LEFT,
				std.conv.text("Start colour:- Red: ", r1, " Green: ", g1, " Blue: ", b1).toStringz());
			al_draw_text( FONT, Colour.black, 0, 81, ALLEGRO_ALIGN_LEFT,
				std.conv.text("End colour:- Red: ", r2, " Green: ", g2, " Blue: ", b2).toStringz());
			al_draw_text( FONT, Colour.black, 0, 101, ALLEGRO_ALIGN_LEFT,
				std.conv.text("Current colour:- Red: ", r3, " Green: ", g3, " Blue: ", b3).toStringz());

			al_draw_text( FONT, Colour.amber, 0, 60, ALLEGRO_ALIGN_LEFT,
				std.conv.text("Start colour:- Red: ", r1, " Green: ", g1, " Blue: ", b1).toStringz());
			al_draw_text( FONT, Colour.amber, 0, 80, ALLEGRO_ALIGN_LEFT,
				std.conv.text("End colour:- Red: ", r2, " Green: ", g2, " Blue: ", b2).toStringz());
			al_draw_text( FONT, Colour.amber, 0, 100, ALLEGRO_ALIGN_LEFT,
				std.conv.text("Current colour:- Red: ", r3, " Green: ", g3, " Blue: ", b3).toStringz());

			al_draw_line(0, DISPLAY_H - 256, DISPLAY_W, DISPLAY_H - 256 - 2, Colour.gray, 2);
			al_draw_line(0, DISPLAY_H - 256 + r1, DISPLAY_W, DISPLAY_H - 256 + r2, Colour.red, 2);
			al_draw_line(0, DISPLAY_H - 256 + g1, DISPLAY_W, DISPLAY_H - 256 + g2, Colour.green, 2);
			al_draw_line(0, DISPLAY_H - 256 + b1, DISPLAY_W, DISPLAY_H - 256 + b2, Colour.blue, 2);
			al_draw_line(progress * DISPLAY_W, DISPLAY_H - 256, progress * DISPLAY_W, DISPLAY_H, Colour.white, 2);
			al_draw_circle(progress * DISPLAY_W, DISPLAY_H - 256 + r3, 7, Colour.white, 2);
			al_draw_circle(progress * DISPLAY_W, DISPLAY_H - 256 + g3, 7, Colour.white, 2);
			al_draw_circle(progress * DISPLAY_W, DISPLAY_H - 256 + b3, 7, Colour.white, 2);
			//al_draw_line(progress * 800 - 7, 600 - 256 + r3, progress * 800 + 7, 600 - 256 + r3, Colour.white, 2);
			//al_draw_line(progress * 800 - 7, 600 - 256 + g3, progress * 800 + 7, 600 - 256 + g3, Colour.white, 2);
			//al_draw_line(progress * 800 - 7, 600 - 256 + b3, progress * 800 + 7, 600 - 256 + b3, Colour.white, 2);
			//al_draw_filled_circle(x, y, 7, Colour.amber);
			//al_set_target_bitmap();
			//writeln([x,y]);
			//al_draw_bitmap(back.bitmap, 0,0, 0);
		} // version, ExtraStuff

			al_flip_display();

			//al_rest(0.01);
			x += dx;
			y += dy;
			bool changeColour = false;
			if (x < 0 || x > DISPLAY_W)
				changeColour = true,
				dx *= -1;
			if (y < 0 || y > DISPLAY_H)
				changeColour = true,
				dy *= -1;
			if (changeColour) {
				//currentColour = makecol(rnd(), rnd(), rnd());				

				doChange();
				//break;
			}
		}
exit: {}
	}
} // not version DUnit
