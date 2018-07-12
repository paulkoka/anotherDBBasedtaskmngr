//
//  TaskItem.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "TaskItem.h"

@implementation TaskItem

-(id) initWithUniqeId:(int) identifire withState:(BOOL) state title:(NSString*) title subtitle:(NSString*) subtitle additionalInformation:(NSString*)additionalInformation{
    if ((self = [super init])) {
        self.identifire = identifire;
        self.state = state;
        self.titleName = title;
        self.subtitleName = subtitle;
        self.additonalonfo = additionalInformation;
    }
    return self;
}

@end
