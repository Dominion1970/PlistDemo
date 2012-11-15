//
//  AppDelegate.m
//  PlistDemo
//
//  Created by Valentine Gorshkov on 15.11.12.
//  Copyright (c) 2012 silvansky. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (retain) NSString *plistFileName;

@end

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];

	self.plistFileName = plistPath;
	NSLog(@"plist file path: %@", plistPath);
}

- (IBAction)savePlist:(id)sender
{
	NSMutableDictionary *root = [NSMutableDictionary dictionary];
	[root setObject:@YES forKey:@"autosave"];
	[root setObject:@"hello" forKey:@"greet-text"];
	[root setObject:@"4F4@@" forKey:@"identifier"];
	NSMutableArray *elements = [NSMutableArray array];
	[elements addObject:@"one"];
	[elements addObject:@"two"];
	[elements addObject:@"thee"];
	[root setObject:elements forKey:@"elements"];
	NSMutableArray *subs = [NSMutableArray array];
	for (NSInteger i = 0; i < 10; i++)
	{
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		[dict setObject:[NSString stringWithFormat:@"John %ld", i] forKey:@"name"];
		[dict setObject:[NSString stringWithFormat:@"Moscow %ld", i] forKey:@"city"];
		[dict setObject:[NSNumber numberWithInteger:i] forKey:@"id"];
		[subs addObject:dict];
	}
	[root setObject:subs forKey:@"subs"];
	NSLog(@"saving data:\n%@", root);
	NSError *error = nil;
	NSData *representation = [NSPropertyListSerialization dataWithPropertyList:root format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
	if (!error)
	{
		BOOL ok = [representation writeToFile:self.plistFileName atomically:YES];
		if (ok)
		{
			NSLog(@"ok!");
		}
		else
		{
			NSLog(@"error writing to file: %@", self.plistFileName);
		}
	}
	else
	{
		NSLog(@"error: %@", error);
	}

}

- (IBAction)loadPlist:(id)sender
{
	NSData *plistData = [NSData dataWithContentsOfFile:self.plistFileName];
	if (!plistData)
	{
		NSLog(@"error reading from file: %@", self.plistFileName);
		return;
	}
	NSPropertyListFormat format;
	NSError *error = nil;
	id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
	if (!error)
	{
		NSMutableDictionary *root = plist;
		NSLog(@"loaded data:\n%@", root);
	}
	else
	{
		NSLog(@"error: %@", error);
	}
}


@end
