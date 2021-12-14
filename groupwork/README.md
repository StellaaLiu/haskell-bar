# groupwork

> 一名测试工程师走进了一个酒吧......

## Build This Project

copying code:
```
stack new groupwork new-template
cd groupwork
stack build
stack exec groupwork-exe
```

buliding as a existing stack:
```
stack unpack groupwork
cd groupwork
stack init
```

## Menu

- app/Main.hs: create and initialise an sqlite database, download data and save to database, run queries on the database.
- src/Types.hs: defines the Haskell data types you are using
- src/Fetch.hs: defines a function for downloading the document
- src/Parse.hs: parses the downloaded data into the given Haskell datatype
- src/Database.hs: creates DB tables, saves/retrieves data from/to a database using again the appropriate Haskell data types

## Use Haddock

```
haddock [option ...] file ...
```
See [Haddock Documentation](https://haskell-haddock.readthedocs.io/en/latest/invoking.html)

TODO: I am not sure whether it works