//
//  TKCompaniesViewController.m
//  Engine Sound
//
//  Created by Timofey Korchagin on 21/08/2012.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKCompaniesViewController.h"
#import "TKAppDelegate.h"
#import "TKCompanies.h"
#import "TKModelsViewController.h"

@interface TKCompaniesViewController ()

@property (nonatomic, strong) NSArray *companiesList;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation TKCompaniesViewController
@synthesize companiesList = _companiesList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TKCompanies"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor
                                                             sortDescriptorWithKey:@"name" ascending:YES]];
    self.companiesList = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CompaniesToModelsSegue"]) {
        TKModelsViewController *model = segue.destinationViewController;
        model.companies = [self.companiesList objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    return [(TKAppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companiesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompaniesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TKCompanies *currentCompany = [self.companiesList objectAtIndex:indexPath.row];
    cell.textLabel.text = currentCompany.name;

    cell.imageView.image = [UIImage imageNamed:currentCompany.icon];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
