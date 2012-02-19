/* TerpGlkViewController.m: Interpreter-specific subclass of the IosGlk view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "TerpGlkViewController.h"
#import "TerpGlkDelegate.h"
#import "GlkFrameView.h"
#import "GlkWinBufferView.h"

@implementation TerpGlkViewController

- (TerpGlkDelegate *) terpDelegate {
	return (TerpGlkDelegate *)self.glkdelegate;
}

- (void) didFinishLaunching {
	[super didFinishLaunching];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	CGFloat maxwidth = [defaults floatForKey:@"FrameMaxWidth"];
	self.terpDelegate.maxwidth = maxwidth;
}

- (IBAction) pageDisplayChanged {
	NSLog(@"### page changed");
	
	//### some debugging
	/*
	for (UIView *subview in self.frameview.subviews) {
		if ([subview isKindOfClass:[GlkWinBufferView class]]) {
			GlkWinBufferView *winv = (GlkWinBufferView *)subview;
			[winv.textview debugDisplay];
			break;
		}
	}
	 */
}

- (IBAction) showPreferences {
	NSLog(@"### preferences");
	CGFloat maxwidth = self.terpDelegate.maxwidth;
	if (maxwidth > 0)
		maxwidth = 0;
	else
		maxwidth = (self.view.bounds.size.width > 500) ? 600 : 280; //###
	
	self.terpDelegate.maxwidth = maxwidth;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setFloat:maxwidth forKey:@"FrameMaxWidth"];
	
	[self.frameview setNeedsLayout];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
	//### different for iPad?
	return (orientation == UIInterfaceOrientationPortrait);
}

@end
