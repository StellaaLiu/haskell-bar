{-|
Module      : Parse
Description : The Parse module parses the downloaded data into the given Haskell datatype in Database.hs
-}

module Parse (
  parseRecords
) where

import Fetch
import Types
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as L8

instance FromJSON Overall where
    parseJSON (Object v) =
        Overall <$> v .: "tank_name"
                <*> v .: "nation"
                <*> v .: "tank_type"
                <*> v .: "tier"
                <*> v .: "players"
                <*> v .: "average_battles"
                <*> v .: "average_damage"
                <*> v .: "average_win_rate"
                <*> v .: "average_wn8"
    parseJSON _ = mzero

instance ToJSON Overall where
    toJSON (Overall tank_name nation tank_type tier players average_battles average_damage average_win_rate average_wn8) =
        object [ "tank_name" .= tank_name
               , "nation" .= nation
               , "tank_type" .= tank_type
               , "tier" .= tier
               , "players" .= players
               , "average_battles" .= average_battles
               , "average_damage" .= average_damage
               , "average_win_rate" .= average_win_rate
               , "average_wn8" .= average_wn8
               ]

instance FromJSON SpecByNation where
    parseJSON (Object v) =
        SpecByNation <$> v .: "nation"
                     <*> v .: "tier"
                     <*> v .: "players"
                     <*> v .: "average_win_rate"
                     <*> v .: "average_wn8"
    parseJSON _ = mzero

instance ToJSON SpecByNation where
    toJSON (SpecByNation nation_ tier_ players_ average_win_rate_ average_wn8_) =
        object [ "nation" .= nation_
               , "tier" .= tier_
               , "players" .= players_
               , "average_win_rate" .= average_win_rate_
               , "average_wn8" .= average_wn8_
               ]

instance FromJSON SpecByType where
    parseJSON (Object v) =
        SpecByType <$> v .: "tank_type"
                   <*> v .: "tier"
                   <*> v .: "players"
                   <*> v .: "average_win_rate"
                   <*> v .: "average_wn8"
    parseJSON _ = mzero

instance ToJSON SpecByType where
    toJSON (SpecByType tank_type_ tier__ players__ average_win_rate__ average_wn8__) =
        object [ "tank_type" .= tank_type_
               , "tier" .= tier__
               , "players" .= players__
               , "average_win_rate" .= average_win_rate__
               , "average_wn8" .= average_wn8__
               ]

parseRecords :: L8.ByteString -> Either String [Overall]
    tags <- parseTags <$> download "https://wotlabs.net/na/tankStats"
        let overall_record = map f $ sections (~== "<tbody>") $
                             takeWhile (~/= "<td>") $
                             drop 5 $ dropWhile (~/= "</td>") 
        ToJSON $ unlines overall_record
    where
        f :: [Tag String] -> String
        f = dequote . unwords . words . fromTagText . head . filter isTagText
        dequote ('\"':xs) | last xs == '\"' = init xs
        dequote x = x