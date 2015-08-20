# AbstractFactoryPattern-Objc-Swift2.0
Examples of Abstract Factory Pattern in both Objective-C and Swift 2.0


In Abstract Factory we define an interface which will create families of related or dependent objects. In simple words, interface will expose multiple methods each of which will create some object. Again, here method return types will be generic interfaces. All this objects will together become the part of some important functionality.

Question – If every factory is going to create multiple objects and all those objects will be related to each other (means they will use each other) how this relating happens and who does that?

Answer –
There will be an intermediary class which will have composition relationship with our interface.
This class will do all the work, using all the objects got from interface methods.
This will be the class with which client will interact.