#!/usr/bin/env dub
/+ dub.sdl:
name "hello_vibed"
dependency "vibe-d" version="~>0.8.0-rc.1"
versions "VibeDefaultMain"
+/
import vibe.d;

shared static this() @safe
{
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    listenHTTP(settings, (req, res) {
        res.writeBody("Hello, World: " ~ req.path);
    });
}
