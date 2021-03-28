import jeca.all, jext.all;

mixin(Jeca.pragmalibs);

void main(string[] args) {
	Init(args);
	scope(exit)
		Deinit;
	
	auto input = new LetterManager(Bmp.loadBitmap("lemgreen.bmp"),
										 Square( 0, 0, DISPLAY_W, DISPLAY_H ), 8, 17);
	char[] space;
	int sps;
	while(! key[ALLEGRO_KEY_ESCAPE]) {
		poll_input;
		al_clear_to_color(Colour.black);
		input.draw(g_Draw.text);
		input.setText(space.idup ~ "Have a Happy Birthday Win! :-D");
		sps++;
		space.length = sps;
		space[] = ' ';
		if (sps == 50)
			sps = 0;
		al_flip_display;
		al_rest(0.15);
	}
}
