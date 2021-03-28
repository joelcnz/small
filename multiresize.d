// This is old now, I think
import std.stdio;
import std.string;
import std.ascii;
import std.array;
import std.algorithm;
import std.file;
import std.conv;
import std.path;

import jeca.all;

mixin(Jeca.pragmalibs);

void main() {
	Init();
	scope(exit) {
		Deinit();
	}
	
	int picnum;
	foreach(i, file; dirEntries(".", SpanMode.shallow).filter!`endsWith( a.name.toLower(), ".jpg" )`().array()) {
		auto bmp = Bmp.loadBmp(file.name);
		bmp = reduceBmp(bmp, 800, 600);

		while(exists(format(buildPath("..","pic%03s.jpg"), picnum)))
			picnum++;

		al_save_bitmap(format(buildPath("..","pic%03s.jpg"), picnum).toStringz(), bmp.bitmap);
	}
}

Bmp reduceBmp(Bmp bmp, float destw, float desth) {
	float sw=bmp.width, sh=bmp.height;
	float dw,dh;
	float dv;

	dv = (sw > sh ? destw : desth) / (sw > sh ? sw : sh);
	dw = sw*dv;
	dh = sh*dv;

	mixin(traceLine("dw", "dh"));
	bmp.resize(dw,dh);

	return bmp;
}
