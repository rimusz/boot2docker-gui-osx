//
//  AppDelegate.m
//  Boot2Docker GUI
//
//  Created by Rimantas on 08/02/2014.
//  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    [self.statusItem setAlternateImage: [NSImage imageNamed:@"icon_or"]];
    [self.statusItem setHighlightMode:YES];
    // set image depending on the status
    [self setIcon];
    
}


- (IBAction)Start:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker will be up shortly";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d" arguments:arguments = @"up"];
}

- (IBAction)Pause:(id)sender {
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d" arguments:arguments = @"pause"];
}

- (IBAction)Stop:(id)sender {
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d" arguments:arguments = @"stop"];
}

- (IBAction)Restart:(id)sender {
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d" arguments:arguments = @"restart"];
}

- (IBAction)updateDockerClient:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"docker OS X Client";
    notification.informativeText = @"will be updated";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-update" arguments:arguments = @"docker"];
}


- (IBAction)updateBoot2DockerScript:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker script";
    notification.informativeText = @"will be updated";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-update" arguments:arguments = @"script"];
}


- (IBAction)updateBoot2DockerOS:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker OS";
    notification.informativeText = @"will be updated";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-update" arguments:arguments = @"iso"];
    
    notification.title = @"boot2docker OS";
    notification.informativeText = @"Update finished";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}


- (IBAction)installAll:(id)sender {
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker OS";
    notification.informativeText = @"Installation will start shortly";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
/*
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d-install" arguments:arguments = @"1"];
    
    notification.title = @"docker2boot OS";
    notification.informativeText = @"Installation finished";
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
 */
    
    NSString *appName = [[NSString alloc] init];
    [self runApp:appName = @"B2D-Install"];
}


- (IBAction)About:(id)sender {
    
//    [NSBundle loadNibNamed:@"About" owner:self ];
    
    self.myWindowController= [[NSWindowController alloc] initWithWindowNibName:@"About"];
    [self.myWindowController showWindow:self];
}



- (void)runScript:(NSString*)scriptName arguments:(NSString*)arguments
{
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:scriptName ofType:@"command"]];
    task.arguments  = @[arguments];
    [task launch];
    [task waitUntilExit];
    
    // set image depending on the status
    [self setIcon];
}


- (void)runApp:(NSString*)appName
{
    NSString *scriptName = [[NSString alloc] init];
    NSString *arguments = [[NSString alloc] init];
    [self runScript:scriptName = @"b2d" arguments:arguments = @"stop"];
    
    // set image depending on the status
    [self setIcon];
    
    // lunch external App from the mainBundle
    [[NSWorkspace sharedWorkspace] launchApplication:appName];
}


- (void)setIcon {
    // check b2d status and and return the shell script output
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:@"b2d" ofType:@"command"]];
    task.arguments  = @[@"status"];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    [task waitUntilExit];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//    NSLog (@"Returned:\n%@", string);
    
    // send a notification on to the screen
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"boot2docker";
    notification.informativeText = string;
//    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
    // check the status and set the correct icon
    if([string rangeOfString:@"running"].location != NSNotFound){
        [self.statusItem setImage:[NSImage imageNamed:@"icon"]];
    }
    else{
        [self.statusItem setImage:[NSImage imageNamed:@"icon_bw"]];
    }
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}


@end
