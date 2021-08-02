# AdventureWorks installation script for InterSystems IRIS

See [here](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/adventure-works) for the full documentation of Microsoft SQL Server's AdventureWorks sample data warehouse schema. This is merely a script to create and populate the schema on IRIS, all rights on the data and concept remain with Microsoft.

To load the sample, clone the repo and run:

```ObjectScript
do ##class(AdventureWorks.Utils).Setup("/path/to/isc-adventureworks/")
```