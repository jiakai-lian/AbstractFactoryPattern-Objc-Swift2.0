//
//  main.m
//  AbstractFactoryPattern
//
//  Created by bluecats on 20/08/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>

//The following protocols and classes are intentially declared into one file for learning purpose
//In practice, all these declaration should be in their own .h & .m
#pragma mark - Protocols
@protocol IProcessor <NSObject>

- (void) performOperation;

@end

@protocol IHardDisk <NSObject>

- (void) storeData;

@end

@protocol IMonitor <NSObject>

- (void) displayPicture;

@end

@protocol IComputerFactory <NSObject>

@property (nonatomic, strong) id<IProcessor> processor;
@property (nonatomic, strong) id<IHardDisk> hardDisk;
@property (nonatomic, strong) id<IMonitor> monitor;

@end

#pragma mark - ExpensiveProcessor

@interface ExpensiveProcessor : NSObject <IProcessor>

@end

@implementation ExpensiveProcessor

- (void)performOperation
{
    NSLog(@"ExpensiveProcessor performOperation");
}
@end

#pragma mark - CheapProcessor

@interface CheapProcessor : NSObject <IProcessor>

@end

@implementation CheapProcessor

- (void)performOperation
{
    NSLog(@"CheapProcessor performOperation");
}
@end

#pragma mark - ExpensiveHDD

@interface ExpensiveHDD : NSObject <IHardDisk>

@end

@implementation ExpensiveHDD

- (void)storeData
{
    NSLog(@"ExpensiveHDD storeData");
}
@end

#pragma mark - CheapHDD

@interface CheapHDD : NSObject <IHardDisk>

@end

@implementation CheapHDD

- (void)storeData
{
    NSLog(@"CheapHDD storeData");
}
@end

#pragma mark - ExpensiveMonitor

@interface ExpensiveMonitor : NSObject <IMonitor>

@end

@implementation ExpensiveMonitor

- (void)displayPicture
{
    NSLog(@"ExpensiveMonitor displayPicture");
}
@end

#pragma mark - CheapMonitor

@interface CheapMonitor : NSObject <IMonitor>

@end

@implementation CheapMonitor

- (void)displayPicture
{
    NSLog(@"CheapMonitor displayPicture");
}
@end

#pragma mark - HighBudgetComputer

@interface Computer : NSObject <IComputerFactory>

@property (nonatomic, strong) id<IProcessor> processor;
@property (nonatomic, strong) id<IHardDisk> hardDisk;
@property (nonatomic, strong) id<IMonitor> monitor;

@end

@implementation Computer


@end

@interface HighBudgetComputer : Computer

@end

@implementation HighBudgetComputer

@synthesize processor,monitor,hardDisk;

//Actually, all the initializer are factory methods
- (instancetype)init
{
    if(self = [super init])
    {
        processor = [[ExpensiveProcessor alloc] init];
        hardDisk = [[ExpensiveHDD alloc] init];
        monitor = [[ExpensiveMonitor alloc] init];
    }
    
    return self;
}

@end

#pragma mark - LowBudgetComputer

@interface LowBudgetComputer : Computer

@end

@implementation LowBudgetComputer

@synthesize processor,monitor,hardDisk;

//Actually, all the initializer are factory methods
- (instancetype)init
{
    if(self = [super init])
    {
        processor = [[CheapProcessor alloc] init];
        hardDisk = [[CheapHDD alloc] init];
        monitor = [[CheapMonitor alloc] init];
    }
    
    return self;
}

@end

#pragma mark - AverageBudgetComputer

@interface AverageBudgetComputer : LowBudgetComputer

@end

@implementation AverageBudgetComputer

//Actually, all the initializer are factory methods
- (instancetype)init
{
    if(self = [super init])
    {
        self.processor = [[ExpensiveProcessor alloc] init];
    }
    
    return self;
}

@end

#pragma mark - ComputerShop

@interface ComputerShop : NSObject

@property (nonatomic, strong) id<IComputerFactory> category;

- (void) assemblyComputer;

@end

@implementation ComputerShop

- (instancetype)initWithCategory:(id<IComputerFactory>)category
{
    if(self = [self init])
    {
        _category = category;
    }
    
    return self;
}

- (void)assemblyComputer
{
    [self.category.processor performOperation];
    [self.category.hardDisk storeData];
    [self.category.monitor displayPicture];
}
@end





int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        ComputerShop * shop = [[ComputerShop alloc] initWithCategory:[[HighBudgetComputer alloc] init]];
        [shop assemblyComputer];
        
        shop = [[ComputerShop alloc] initWithCategory:[[LowBudgetComputer alloc] init]];
        [shop assemblyComputer];
        
        shop = [[ComputerShop alloc] initWithCategory:[[AverageBudgetComputer alloc] init]];
        [shop assemblyComputer];

        
    }
    return 0;
}
