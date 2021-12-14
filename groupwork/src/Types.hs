{-|
Module      : Types
Description : The Types module defines the data types in the three tables
-}

module Types (
    Overall (..),
    SpecByNation (..),
    SpecByType (..),
) where

import GHC.Generics

-- | The main table containing major imformation
data Overall = Overall {
    tank_name :: String, -- ^ The primary key
    nation :: String, -- ^ Foreign key
    tank_type :: String, -- ^ Foreign key
    tier :: Int,
    players :: Int,
    average_battles :: Int,
    average_damage :: Int,
    average_win_rate :: Double,
    average_wn8 :: Int
} deriving (Show)

-- | Average statetics and players for each nation
data SpecByNation = SpecByNation {
    nation_ :: String, -- ^ The primary key
    tier_ :: Int, -- ^ Todo: is the primary key nation or (nation, tier)?
    players_ :: Int,
    average_win_rate_ :: Double,
    average_wn8_ :: Int
} deriving (Show)

-- | Average statetics and players for each nation
data SpecByType = SpecByType {
    tank_type_ :: String, -- ^ The primary key
    tier__ :: Int, -- ^ Todo: is the primary key tank_type or (tank_type, tier)?
    players__ :: Int,
    average_win_rate__ :: Double,
    average_wn8__ :: Int
} deriving (Show)