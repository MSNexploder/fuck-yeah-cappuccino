/*
 * AppController.j
 * simple-tableview
 *
 * Created by Stefan Huber on June 5, 2010.
 * Copyright 2010, MSNexploder (at) gmail.com All rights reserved.
 */

@import <Foundation/CPObject.j>

@implementation AppController : CPObject
{
  CPArray _tableContent;
}

- (id)init
{
  if (self = [super init]) {
    _tableContent = [[CPArray alloc] init];
    [_tableContent addObject:@"Cappuccino"];
    [_tableContent addObject:@"Awesome"];
    [_tableContent addObject:@"Stuff"];
  }
  return self;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
    var contentView = [theWindow contentView];
    
    var scrollView = [[CPScrollView alloc] initWithFrame:[contentView bounds]];
    [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    var tableView = [[CPTableView alloc] initWithFrame:[scrollView bounds]];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    
    var column = [[CPTableColumn alloc] initWithIdentifier:@"Stuff"];
    [[column headerView] setStringValue:@"Stuff"];
    [tableView addTableColumn:column];
    
    [scrollView setDocumentView:tableView];
    [contentView addSubview:scrollView];
    
    [theWindow orderFront:self];
}

- (int)numberOfRowsInTableView:(CPTableView)aTableView
{
  return [_tableContent count];
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aTableColumn row:(int)aRow
{
  return [_tableContent objectAtIndex:aRow];
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
  row = [[[aNotification object] selectedRowIndexes] firstIndex];
  // console.info(row);
  if (row == -1) {
    console.info(@"Nothing selected");
  }
  else {
    console.info([CPString stringWithFormat:@"selected: %@", [_tableContent objectAtIndex:row]]);
  }
}

@end
