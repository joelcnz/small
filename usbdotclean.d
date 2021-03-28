// 28 7 2020 - './usbupdate ChronoLog' works now. './usbupdate /FE'
// 17 7 2020 - 'usbupdate -all'  or eg. 'usbupdate ChronoLog' working, only './usbupdate'
// 6 6 2020 -> runs clean dot on M128GB USB drive
// Doesn't copies programs to USB (M128GB)
import std;

void main(string[] args) {
	immutable jprodpro2 = "jpro/dpro2";
	if (args.length > 1 && args[1] == "-all")
		args[1] = "";
	else if (args.length == 1)
			args ~= jprodpro2 ~ "/";
	else if (args[1][0] != '/')
		args[1] = jprodpro2 ~ "/" ~ args[1] ~ "/";
	else
		args[1] = args[1][1 .. $] ~ "/";
	immutable usb = "/Volumes/SAN256GB2/" ~ args[1];
    immutable commands =
        [
		//["cp", "../ChronoLog", usb ~ "ChronoLog"],
			["dot_clean", usb ~ "."]];
    foreach(i, command; commands) {
        writeln("D> ", command.join(" "));
        wait(spawnProcess(command));
    }
}
