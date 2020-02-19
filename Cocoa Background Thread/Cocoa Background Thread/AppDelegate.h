//
//  AppDelegate.h
//  Cocoa Background Thread
//
//  Created by Nikola Grujic on 17/02/2020.
//

#import <Cocoa/Cocoa.h>

typedef struct
{
    NSUInteger count;
    NSCountedSet *frequencies;
}CountAndSet;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextView *wordsView;
@property (weak) IBOutlet NSTextField *countLabel;
@property (weak) IBOutlet NSTextField *uniqueLabel;
@property (weak) IBOutlet NSButton *countButton;
@property (weak) IBOutlet NSProgressIndicator *spinner;

- (IBAction)count:(id)sender;

- (CountAndSet)countWords:(NSString*)string;
- (void)disableControls;
- (void)enableControls;


@end

