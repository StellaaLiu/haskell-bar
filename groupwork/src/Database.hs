{-|
Module      : Database
Description : The Database module creates DB tables, 
              saves/retrieves data from/to a database using again the appropriate Haskell data types
-}

{-# LANGUAGE OverloadedStrings #-}

module Database (
    initialiseDB,
    saveRecords,
) where

import Types
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.Internal
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToRow

instance FromRow Overall where
    fromRow = Overall <$> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field

instance ToRow Overall where
    toRow (Overall tank_name nation tank_type tier players average_battles average_damage average_win_rate average_wn8)
        = toRow (tank_name, nation, tank_type, tier, players, average_battles, average_damage,  average_win_rate, average_wn8)

instance FromRow SpecByNation where
    fromRow = SpecByNation <$> field <*> field <*> field <*> field <*> field

instance ToRow SpecByNation where
    toRow (SpecByNation nation_ tier_ players_ average_win_rate_ average_wn8_)
        = toRow (nation_, tier_, players_, average_win_rate_, average_wn8_)

instance FromRow SpecByType where
    fromRow = SpecByType <$> field <*> field <*> field <*> field <*> field

instance ToRow SpecByType where
    toRow (SpecByType tank_type_ tier__ players__ average_win_rate__ average_wn8__)
        = toRow (tank_type_, tier__, players__, average_win_rate__, average_wn8__)

initialiseDB :: IO Connection
initialiseDB = do
        conn <- open "tanks.sqlite"
        execute_ conn "CREATE TABLE IF NOT EXISTS overall (\
            \tank_name VARCHAR(50) PRIMARY KEY NOT NULL,\
            \nation VARCHAR(50) NOT NULL, \
            \tank_type VARCHAR(50) NOT NULL, \
            \tier INT NOT NULL, \
            \players INT NOT NULL, \
            \average_battles INT NOT NULL, \
            \average_damage INT NOT NULL, \
            \average_win_rate REAL NOT NULL, \
            \average_wn8 INT NOT NULL, \
            \)"
        execute_ conn "CREATE TABLE IF NOT EXISTS specByNation (\
            \nation VARCHAR(50) NOT NULL, \
            \tier INT NOT NULL, \
            \players INT NOT NULL, \
            \average_win_rate REAL NOT NULL, \
            \average_wn8 INT NOT NULL, \
            \)"
        execute_ conn "CREATE TABLE IF NOT EXISTS specByType (\
            \tank_type VARCHAR(50) NOT NULL, \
            \tier INT NOT NULL, \
            \players INT NOT NULL, \
            \average_win_rate REAL NOT NULL, \
            \average_wn8 INT NOT NULL, \
            \)"
        return conn


