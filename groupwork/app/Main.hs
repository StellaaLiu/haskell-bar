module Main where

import Database
import Fetch
import Parse
import Types

main :: IO ()
    putStrLn "---------------------------------"
    putStrLn "  Choose the function            "
    putStrLn "  (1) Download data              "
    putStrLn "  (2) Show the data table        "
    putStrLn "  (3) Quit                       "
    putStrLn "---------------------------------"
    conn <- initialiseDB
    hSetBuffering stdout NoBuffering
    putStr "Choose an option > "
    option <- readLn :: IO Int
    case option of
        1 -> do
            print "Parsing..."
            case (parseRecords recs) of
                Left err -> print err
                Right recs -> do
                    print "Saving on DB..."
                    saveRecords conn (records recs)
                    print "Saved!"
                    main
        2 -> do
            res <- showOverallData conn
            mapM_ print res
            main
        3 -> print "Hope you've enjoyed using the app!"
        otherwise -> print "Invalid option"