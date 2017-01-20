//
//  CPlusWrapper.m
//  testCommandLine
//
//  Created by John Bethancourt on 1/11/17.
//  Copyright © 2017 John Bethancourt. All rights reserved.
//

#import "CPlusWrapper.h"
#include "cplusfunctions.hpp"

@implementation CPlusWrapper
-(void)daClearScreenWrapped{
    
    CPP cpp;
    cpp.DaClearScreen();
}
-(void)daClearScreen2Wrapped{
    CPP cpp;
    cpp.DaClearScreen2();
}
@end
