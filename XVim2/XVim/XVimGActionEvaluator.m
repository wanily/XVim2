//
//  XVimGActionEvaluator.m
//  XVim
//
//  Created by Tomas Lundell on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import "XVimJoinEvaluator.h"
#import "XVimGActionEvaluator.h"
#import "XVimInsertEvaluator.h"
#import "XVimLowercaseEvaluator.h"
#import "XVimUppercaseEvaluator.h"

#ifdef TODO
#import "XVimTildeEvaluator.h"
#import "XVimKeyStroke.h"
#import "XVimWindow.h"
#import "XVim.h"
#import "XVimMark.h"
#import "XVimMarks.h"
#import "XVimVisualEvaluator.h"
#import "NSTextStorage+VimOperation.h"
#import "NSTextView+VimOperation.h"
#endif

@implementation XVimGActionEvaluator

// CASE CHANGING

- (XVimEvaluator*)u
{
        [self.argumentString appendString:@"u"];
        return [[XVimLowercaseEvaluator alloc] initWithWindow:self.window];
}

- (XVimEvaluator*)U
{
        [self.argumentString appendString:@"U"];
        return [[XVimUppercaseEvaluator alloc] initWithWindow:self.window];
}

#ifdef TODO
- (XVimEvaluator*)d
{
        [NSApp sendAction:@selector(jumpToDefinition:) to:nil from:self];
        return nil;
}

- (XVimEvaluator*)f
{
        // Does not work correctly.
        // This seems because the when Xcode change the content of DVTSourceTextView
        // ( for example when the file shown in the view is changed )
        // it makes the content empty first but does not set selectedRange.
        // This cause assertion is NSTextView+VimMotion's ASSERT_VALID_RANGE_WITH_EOF.
        // One option is change the assertion condition, but I still need to
        // know more about this to implement robust one.
        //[NSApp sendAction:@selector(openQuickly:) to:nil from:self];
        return nil;
}

- (XVimEvaluator*)i
{
        XVimMark* mark = [[XVim instance].marks markForName:@"^" forDocument:self.sourceView.documentURL.path];
        XVimInsertionPoint mode = XVIM_INSERT_DEFAULT;

        if (mark.line != NSNotFound) {
                NSUInteger newPos = [self.sourceView.textStorage xvim_indexOfLineNumber:mark.line column:mark.column];
                if (NSNotFound != newPos) {
                        XVimMotion* m = XVIM_MAKE_MOTION(MOTION_POSITION, CHARACTERWISE_EXCLUSIVE, MOTION_OPTION_NONE, 0);
                        m.position = newPos;

                        [self.window preMotion:m];
                        [self.sourceView xvim_move:m];
                        mode = XVIM_INSERT_APPEND;
                }
        }
        return [[XVimInsertEvaluator alloc] initWithWindow:self.window mode:mode];
}

- (XVimEvaluator*)J
{
        XVimJoinEvaluator* eval = [[XVimJoinEvaluator alloc] initWithWindow:self.window addSpace:NO];
        return [eval executeOperationWithMotion:XVIM_MAKE_MOTION(MOTION_NONE, CHARACTERWISE_EXCLUSIVE, MOTION_OPTION_NONE, self.numericArg)];
}


- (XVimEvaluator*)v
{
        // Select previous visual selection
        return [[XVimVisualEvaluator alloc] initWithLastVisualStateWithWindow:self.window];
}

- (XVimEvaluator*)TILDE
{
        [self.argumentString appendString:@"~"];
        return [[XVimTildeEvaluator alloc] initWithWindow:self.window];
}
#endif
@end