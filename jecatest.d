// get access stuff for using
import jeca.all;

// for librays access
mixin(Jeca.pragmalibs);

// the main entry point (the main function)
void main() {
	// set stuff up like DISPLAY_W for the width in pixels of the program window (or full screen width)
	Init([]);
	// shut down
	scope(exit) Deinit();
	
	// foreach loop x = 0 and keeps changing up to DISPLAY_W. One loop a count. No loop when is equal to DISPLAY_W.
	foreach(x; 0..DISPLAY_W) {
		// clear the graphics buffer
		al_clear_to_color(Colour.black);
		// draw a dot using the value of the changing x for the distance right, 50 pixels down and in the colour yellow
		al_draw_pixel(x, 50, Colour.yellow);
		// show grahics for you to see
		al_flip_display();
		// pause for a moment
		al_rest(0.01);
		// refresh for key presses
		poll_input();
		// if Esc key is pressed then quit the foreach loop and program
		if (key[ALLEGRO_KEY_ESCAPE] || exitHandler.doKeysAndCloseHandling)
			break;
	}
}

version(Uncommented) {

import jeca.all;

mixin(g_librarys);

void main() {
	Init([]);
	scope(exit) Deinit();
	
	foreach(x; 0..DISPLAY_W) {
		al_clear_to_color(Colour.black);
		al_draw_pixel(x, 50, Colour.yellow);
		al_flip_display();
		al_rest(0.01);
		poll_input();
		if (key[ALLEGRO_KEY_ESCAPE])
			break;
	}
}

}
