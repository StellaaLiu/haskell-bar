{-|
Module      : Fetch
Description : The Fetch module defines a function for downloading the document
-}

module Fetch (
  download
) where

import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple

-- | The objected URL should be a String.
type URL = String


-- | Parses a String as URL and get the response.
download :: URL -> IO L8.ByteString
download url = do
  request <- parseRequest url
  response <- httpLBS request
  return $ getResponseBody response