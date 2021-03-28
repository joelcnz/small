//Org: from DAllegro forum under: install_int not interrupting, by: ggvicviper
import allegro.allegro;

int i = 0;

extern (C) void fpsTimer()
{
volatile i++;
}

int main(char[][] args)
{
allegro_init();
install_timer();
install_keyboard();

set_color_depth(32);
set_gfx_mode(GFX_AUTODETECT_WINDOWED, 320, 240, 0, 0);

BITMAP *buffer = create_bitmap(screen.w, screen.h);

install_int(&fpsTimer, 16);

while(!key[KEY_ESC])
{
textprintf_ex(buffer, font, 0, 0, -1, -1, "%d", i);

vsync();
acquire_screen();
blit(buffer, screen, 0, 0, 0, 0, 320, 240);
release_screen();

clear_bitmap(buffer);
rest(0);
}

destroy_bitmap(buffer);

remove_int(&fpsTimer);
remove_timer();
allegro_exit();

return 0;
}
