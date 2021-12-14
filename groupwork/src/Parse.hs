{-|
Module      : Parse
Description : The Parse module parses the downloaded data into the given Haskell datatype in Database.hs
-}

module Parse (
  parseRecords
) where

import Types
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as L8

