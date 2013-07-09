IndexSet-Backed-Table
=====================

Example of a NSIndexSet backed UITableView for large sets of data. Super fast.

First, a few disclaimers.

1. This is not production ready code. The goal of this example app is to demonstrate the speed of using NSIndexSets to represent the backing model of a UITableView. You should still follow best practices when making a real production app.
2. There are no unit tests, you should have unit tests. This example has no unit tests in order to stay focused on the example.
3. The UITableView controller subclass SDCalendarTableViewController is the datasource and delegate for the table. A production app should not be written this way. You should use a separate object as your datasource. Your code will be cleaner and easier to test.
