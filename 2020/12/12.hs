import           Data.List
import           Data.List.Utils
import           Data.Maybe

main = do
  test <- readFile "test"
  input <- readFile "input"

  putStrLn "== Test Part 1 =="
  print $ navigate (0, 0, 90) $ lines test
  print $ (\(x,y,_) -> manhattan x y ) $ navigate (0, 0, 90) $ lines test

  putStrLn "== Part 1 =="
  print $ navigate (0, 0, 90) $ lines input
  print $ (\(x,y,_) -> manhattan x y ) $ navigate (0, 0, 90) $ lines input

  putStrLn "== Test Part 2 =="

  putStrLn "== Part 2 =="


navigate :: (Int, Int, Int) -> [String] -> (Int, Int, Int)
-- Base case: no commands left
navigate (x, y, direction) [] = (x, y, direction)
-- Recursive case: at lease one command left
navigate (x, y, direction) (command:commands) =
  let action = head command
      value  = read $ tail command
  in case action of
    'N' -> navigate (x, y+value, direction) commands
    'S' -> navigate (x, y-value, direction) commands
    'E' -> navigate (x+value, y, direction) commands
    'W' -> navigate (x-value, y, direction) commands
    'L' -> navigate (x, y, mod (direction - value) 360) commands
    'R' -> navigate (x, y, mod (direction + value) 360) commands
    'F' -> navigate (fromJust $ lookup direction [(0, x), (90, x + value), (180, x), (270, x - value)], fromJust $ lookup direction [(0, y + value), (90, y), (180, y - value), (270, y)], direction) commands

manhattan :: Int -> Int -> Int
manhattan x y = (abs x)+(abs y)