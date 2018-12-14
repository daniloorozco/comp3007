import Codec.BMP
import GHC.Word
import Data.ByteString

--DANILO OROZCO, 101035548
--comp3007 assignment 2, question 1
--2018/10/14

-- INSTRUCTIONS FOR RUNNING AND COMPILING --
-- loadBitmapIntoIt <filename> --
-- showAsASCIIArt (convertTuples (cleanData it)) --

-- For this code to work you will need to have installed the package "bmp-1.2.6.3"
-- You can do this using the cabal package manager (as demonstrated in class)
-- or you can follow a procedure similar to the one detailed below:
--
-- 1. Download bmp-1.2.6.3.tar.gz from http://hackage.haskell.org/package/bmp
-- 2. Extract the folder bmp-1.2.6.3
-- 3. Open a terminal (with administrator rights) and do the following:
--    a. cd into bmp-1.2.6.3
--    b. runhaskell Setup configure
--    c. runhaskell Setup build
--    d. runhaskell Setup install

loadBitmapIntoIt :: FilePath -> IO ([(Int, Int, Int)], Int, Int)
loadBitmapIntoIt filename = do
  (Right bmp) <- readBMP filename
  return ((parseIntoRGBVals (convertToIntList (unpack (unpackBMPToRGBA32 bmp)))), (fst (bmpDimensions bmp)), (snd (bmpDimensions bmp)))

convertToIntList :: [Word8] -> [Int]
convertToIntList [] = []
convertToIntList (h:t) = (fromIntegral (toInteger h)) : (convertToIntList t)

parseIntoRGBVals :: [Int] -> [(Int, Int, Int)]
parseIntoRGBVals [] = []
parseIntoRGBVals (h:i:j:_:t) = (h,i,j) : (parseIntoRGBVals t)


-- convertTuples :: ([(Int, Int, Int)], Int, Int) -> [[(Int, Int, Int)]]
-- convertTuples is the function I have written to address requirement (a)
convertTuples :: ([(Int, Int, Int)], Int, Int) -> [[(Int, Int, Int)]]
convertTuples (x, y, z) = helperTuple x y z

-- helperTuple is a helper function which is recursive
helperTuple :: [(Int, Int, Int)] -> Int -> Int -> [[(Int, Int, Int)]]
-- Base Case
-- if the tuple list is empty, return an empty list.
helperTuple _ _ 0 = []
-- list of integer and turn it into a list of tuples. 
-- get the first 3 elements in the head, and then pass the rest into function.
helperTuple area width height = [area!!i | i <- [0..(width-1)]] : helperTuple (([area!!j | j <- [width..((Prelude.length area) - 1)]])) width (height - 1)


-- ceilRGB :: [[(Int, Int, Int)]]-> [[(Int, Int, Int)]]
-- ceilRGB is the function I have written to address requirement (b)
cleanData :: [[(Int, Int, Int)]]-> [[(Int, Int, Int)]]
cleanData [] = []
cleanData (round: recurse) = helperClean round : cleanData recurse

-- helperClean is a helper function that takes rgb list and rounds up or down
helperClean :: [(Int, Int, Int)] -> [(Int, Int, Int)]
helperClean [] = []
-- sets to rgb 0,0,0 for dark
helperClean ((0, 0, 0) : l) = (0, 0, 0) : helperClean l
-- anything else (monochromatic noise) gets set to rgb 255,255,255 for light
helperClean ((_) : l) = (255, 255, 255) : helperClean l


-- showAsASCIIArt' :: [[(Int, Int, Int)]] -> [[Char]]
-- showAsASCIIArt' is the function I have written to address requirement (c)

showAsASCIIArt' :: [[(Int, Int, Int)]] -> [[Char]]
showAsASCIIArt' [] = []
-- call helper to convert to characters and add it to the bitmap
showAsASCIIArt' (chars:bitmap) = convertToChar chars : showAsASCIIArt' bitmap


-- convertToChar is a helper function that rgb to Char in ASCII
convertToChar :: [(Int, Int, Int)] -> [Char]
convertToChar [] = []
-- rgb 0,0,0 set to light ( )
convertToChar ((255, 255, 255) : chars) = ' ' : convertToChar chars
-- rgb 0,0,0 set to dark (@)
convertToChar ((0, 0, 0) : chars) = '@' : convertToChar chars

-- reverse the bitmap with prelude.reverse for proper position of bmp
showAsASCIIArt :: [[(Int, Int, Int)]] -> IO ()
showAsASCIIArt pixels = Prelude.putStr (unlines (Prelude.reverse (showAsASCIIArt' pixels)))
