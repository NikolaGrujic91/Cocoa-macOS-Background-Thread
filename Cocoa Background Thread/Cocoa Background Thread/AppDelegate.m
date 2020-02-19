//
//  AppDelegate.m
//  Cocoa Background Thread
//
//  Created by Nikola Grujic on 17/02/2020.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - Action methods

- (IBAction)count:(id)sender
{
    [self disableControls];
    
    NSString *text = [_wordsView string];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Execute on background thread
        CountAndSet result = [self countWords:text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Execute on main thread
            NSString *labelString = [NSString stringWithFormat:@"Word count:%lu", (unsigned long)result.count];
            [self->_countLabel setStringValue:labelString];
            
            labelString = [NSString stringWithFormat:@"Unique words:%lu", (unsigned long)result.frequencies.count];
            [self->_uniqueLabel setStringValue:labelString];
            
            [self enableControls];
        });
    });
}

#pragma mark - Helper methods

- (CountAndSet)countWords:(NSString*)string
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    NSCountedSet *wordSet = [NSCountedSet set];
    
    NSString *word;
    
    while ([scanner scanUpToCharactersFromSet:whiteSpace intoString:&word])
    {
        [wordSet addObject:[word lowercaseString]];
        count++;
    }
    
    CountAndSet result = {count, wordSet};
    
    sleep(2); // Slows down execution to notice background worker
    
    return result;
}

- (void)disableControls
{
    [_wordsView setEditable:NO];
    [_countButton setEnabled:NO];
    [_spinner setHidden:NO];
    [_spinner startAnimation:self];
}

- (void)enableControls
{
    [_wordsView setEditable:YES];
    [_countButton setEnabled:YES];
    [_spinner stopAnimation:self];
    [_spinner setHidden:YES];
}

@end
