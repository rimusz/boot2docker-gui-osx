//
//  AppDelegate.h
//  Boot2Docker GUI
//
//  Created by Rimantas on 08/02/2014.
//  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>

@property (strong, nonatomic) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem;

@property(strong) NSWindowController *myWindowController;


@end
