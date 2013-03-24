March 24, 2013
==============

Still the same great functionality. Did some polish on the UI. Branched off GDIPAlt for those with 10.6 and 10.7.

March 23, 2013
==============

There are no major functional changes to report, just more polishing in the background. I added an extension to NSArray to enumerate blocks across elements of the array and thus removed a bunch of lines of code in all three classes and hopefully built in some flexibility for the future. I decided to release a binary build which you can find [here][4]. Please note that we're currently only supporting OSX 10.8 for now. 

March 15, 2013
==============

Ditched the whole AnimatedViews class and all the associated code that went with it in favour of Core Animation effects. These are much smoother in my optinion and reduced the quantity of code significantly. Still haven't put in a way to turn it off yet. 

March 10, 2013
==============

I changed the way the addresses are displayed from a straight label to a view that has them slide in from the right. My thinking is that it will give the user some indication that stuff is happening when they click on refresh. Don't worry, there will be a switch in the settings to turn that off. I also abandoned the idea of using a tear-off window to provide extra controls. Using the tear-off window made the popover behave in a weird way that I couldn't figure out. I suppose I could add stuff in the settings panel to remove controls for those who want a slimmed down look. 

February 17, 2013
=================

There have been a bunch of changes since the first push. The most notable is the addition of the ability to select and copy addresses and host names (without highlighting and right clicking). There has also been some refactoring and tuning in the code thanks to the feedback from some nice folks over on the [NS Brief][3] Glassboard. If you're looking for some Cocoa in your ears, stop by and check out their podcast.

February 15, 2013
=================

This is the first push of the stable and working project GDIP. GDIP is a status bar app for OS X Mountain Lion built and tested on version 10.8.2. The purpose of the app is to answer the question "What's my GD IP?" without popping open a browser window. This version borrows heavily from the article *[A Cocoa application driven by HTTP data][1]* by Matt Gallagher at Cocoa with Love. 

<strike>Please note that there is no pre-built binary. If you want to use this app, you'll need to build it yourself. I'm sure if you're reading this, you have the ability to do that.</strike>

If you have any questions or comments you can find me here on GitHub or at [www.veganswithtypewriters.com][2]. 


Licensing
=========

Really, this is such a trivial app that anyone could have thought it up, and I'm surprised that nobody hasn't. Do what you want with it. It would be nice if you threw me a mention, but whatever, it's your electrons.



[1]: http://www.cocoawithlove.com/2008/09/cocoa-application-driven-by-http-data.html (Cocoa with Love: A Cocoa application driven by HTTP data)
[2]: http://veganswithtypewriters.com/ (Vegans With Typewriters)
[4]: http://veganswithtypewriters.com/gdip (GDIP — Vegans With Typewriters)
[3]: http://nsbrief.com/ (NSBrief)