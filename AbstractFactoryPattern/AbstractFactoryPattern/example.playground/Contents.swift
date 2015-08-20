//: Playground - noun: a place where people can play

import Cocoa

// MARK: Protocols
protocol IProcessor
{
    func performOperation()
}

protocol IHardDisk
{
    func storeData()
}

protocol IMonitor
{
    func displayPicture()
}

protocol IComputerFactory
{
    var processor: IProcessor {get}
    var hardDisk: IHardDisk {get}
    var monitor: IMonitor {get}
}

// MARK: Entities
class ExpensiveProcessor: IProcessor {
    func performOperation() {
        NSLog("ExpensiveProcessor performOperation");
    }
}

class CheapProcessor: IProcessor {
    func performOperation() {
        NSLog("CheapProcessor performOperation");
    }
}

class ExpensiveHDD: IHardDisk {
    func storeData() {
        NSLog("ExpensiveHDD storeData");
    }
}

class CheapHDD: IHardDisk {
    func storeData() {
        NSLog("CheapHDD storeData");
    }
}

class ExpensiveMonitor: IMonitor {
    func displayPicture() {
        NSLog("ExpensiveHDD displayPicture");
    }
}

class CheapMonitor: IMonitor {
    func displayPicture() {
        NSLog("CheapHDD displayPicture");
    }
}

// MARK: Computers
class Computer: IComputerFactory
{
    var processor:IProcessor
    var hardDisk: IHardDisk
    var monitor:IMonitor
    
    init(aProsessor:IProcessor,  aHardDisk:IHardDisk,  aMonitor:IMonitor)
    {
        self.processor = aProsessor
        self.hardDisk = aHardDisk
        self.monitor = aMonitor
    }
    
}

class HighBudgetComputer: Computer
{
    init()
    {
        super.init(aProsessor: ExpensiveProcessor() as IProcessor,aHardDisk: ExpensiveHDD() as IHardDisk,aMonitor: ExpensiveMonitor() as IMonitor);
    }
}

class LowBudgetComputer: Computer
{
    init()
    {
        super.init(aProsessor: CheapProcessor() as IProcessor,aHardDisk: CheapHDD() as IHardDisk,aMonitor: CheapMonitor() as IMonitor);
    }
}

class AverageBudgetComputer: LowBudgetComputer
{
    override init()
    {
        super.init();
        processor = ExpensiveProcessor()
    }
}

class ComputerShop {
    var category: IComputerFactory
    
    init(aCategory : IComputerFactory)
    {
        category = aCategory
    }
    
    func assemblyComputer()
    {
        print("\(category.dynamicType)")
        category.processor.performOperation()
        category.hardDisk.storeData()
        category.monitor.displayPicture()
    }
}

ComputerShop(aCategory: HighBudgetComputer() as IComputerFactory).assemblyComputer()
ComputerShop(aCategory: LowBudgetComputer() as IComputerFactory).assemblyComputer()
ComputerShop(aCategory: AverageBudgetComputer() as IComputerFactory).assemblyComputer()





