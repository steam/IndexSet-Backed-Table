IndexSet-Backed-Table
=====================

Example of a NSIndexSet backed UITableView for large sets of data. Super fast.

Using an NSIndexSet, or a collection of NSIndexSets can be very fast. When your backing datasource for UITable is complex and quite large it often makes sense to ditch the first option of using an array to represent the table's model.

While working on complex calendaring component for a client, Ryan Boyajian and I decided to take a different approach. Our problem was that we needed to display an unpredictable number of rows representing ranges of time over a large duration. Working with NSDate, NSDateFormatter and NSCalendar objects can be expensive. We needed to find a solution that minimized the number of date objects and calculations that were performed. We decided to go with NSIndexSets and the results surprised us. We saw drastically improved performance by drawing rows with indexes and delaying the expensive date calculations until they were needed.

This project is not meant to be a plug and play component for use in your projects but rather an example that demonstrates the concepts behind using NSIndexSet(s) as your primary UITableView datasource. Checkout the blog post ##### for a more detailed discussion of the approach.

First, a few disclaimers.

1. This is not production ready code. The goal of this example app is to demonstrate the speed of using NSIndexSets to represent the backing model of a UITableView. You should still follow best practices when making a real production app.
2. There are no unit tests, you should have unit tests. This example has no unit tests in order to stay focused on the example.
3. The UITableView controller subclass SDCalendarTableViewController is the datasource and delegate for the table. A production app should not be written this way. You should use a separate object as your datasource. Your code will be cleaner and easier to test.
