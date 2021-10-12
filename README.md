# AdventureWorks installation script for InterSystems IRIS

See [here](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/adventure-works) for the full documentation of Microsoft SQL Server's AdventureWorks sample data warehouse schema. This is merely a script to create and populate the schema on IRIS, downloading the source files from Microsoft's repository. 
All rights on the data and concept remain with Microsoft.

To load the sample, clone the repo and run:

```ObjectScript
do ##class(AdventureWorks.Utils).Setup("/path/to/isc-adventureworks/")
```

## Demo instructions

The `demo/` folder includes a sample script to demonstrate recent IRIS SQL extensions. After loading the AdventureWorks dataset, the queries in `demo/commands.sql` should run smoothly. In order to clean up and prepare for another run, use `demo/cleanup.sql`. 