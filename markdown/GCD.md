# Grand Central Dispatch (GCD)

## Background Threads

- Do not run anything from UIKit on background thread
- CoreData: NSManagedObjectContext can only be used in same queue it was created
    - i.e. if you create context in main queue, you can only use it in the main queue
    - if you create context in background queue, you may only use it in the background

## GCD Updates

- dispatch_async(_:) has been renamed to async
- dispatch_queue_t has been renamed to DispatchQueue
- dispatch_queue_create() has been renamed to DispatchQueue(label:attributes:)
- DISPATCH_QUEUE_SERIAL has been deprecated. Concurrent queues may use DispatchQueue.Attributes.concurrent
- dispatch_get_global_queue() has been renamed to DispatchQueue.global(qos:)
- QOS_CLASS_BACKGROUND has been renamed to DispatchQoS.QoSClass.background
- QOS_CLASS_UTILITY has been renamed to DispatchQoS.QoSClass.utility
- QOS_CLASS_USER_INTERACTIVE has been renamed to DispatchQoS.QoSClass.userInteractive
- QOS_CLASS_USER_INITIATED has been renamed to DispatchQoS.QoSClass.userInitiated
- dispatch_get_main_queue has been renamed to DispatchQueue.main

## Resources

