void main() {
	import std;
	
	Mail email = new Mail;
	email.headers["Date"] = Clock.currTime().toRFC822DateTimeString();
	email.headers["Sender"] = "Domain.com Contact Form ";
	email.headers["From"] = "\"Joel\" <joelcnz@gmail.com>";
	email.headers["To"] = "\"Joel\" <joelcnz@gmail.com>";
	email.headers["Subject"] = "D Test";
	import std.stdio : File;
	email.setContent(
	    mailMixed(
	        mailRelated(
	            mailAlternative(
	                mailHtml("<html><body><center>E-Mail with dlang</center></body></html>"),
	                mailText("This e-mail was sent with a D program")
	            )
	        ),
	        mailAttachment(File("../Res/RockDashColoured.png","rb"),"image/png","image.png"),
	        mailAttachment(cast(immutable(ubyte[]))"This is more testing","plain/text","text.txt")
	    )
	);
	sendMail(settings, email);
}
