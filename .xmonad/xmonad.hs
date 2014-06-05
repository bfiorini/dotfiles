import XMonad
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.GridSelect

import Data.Bits ((.|.))
import Data.Ratio ((%))
import System.IO
import qualified Data.Map as M


modMask = mod1Mask


myWorkspaces :: [String]
myWorkspaces =
    ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="]


-- keycode: /usr/include/X11/keysymdef.h
defKeys  = keys defaultConfig
myKeys x = foldr (uncurry M.insert) (defKeys x) (toAdd x)
toAdd x  =
    [
        -- Cycle through workspaces
          ((Main.modMask, xK_grave ), nextWS)
        , ((Main.modMask .|. shiftMask, xK_grave ), prevWS)
        -- Increment the number of windows in the master area
        , ((Main.modMask, xK_comma ), sendMessage (IncMasterN 1))
        -- Deincrement the number of windows in the master area
        , ((Main.modMask, xK_period), sendMessage (IncMasterN (-1)))
        -- Hide status bar
        , ((Main.modMask, xK_b ), sendMessage ToggleStruts)
        -- Restart xmonad
        , ((Main.modMask, xK_q ), spawn "xmonad --recompile;xmonad --restart")
        -- Run file manager
        , ((Main.modMask, xK_f ), spawn "thunar")
        -- Resizable tile
        , ((Main.modMask, xK_a ), sendMessage MirrorShrink)
        , ((Main.modMask, xK_z ), sendMessage MirrorExpand)
        -- Lock screen
        , ((Main.modMask, xK_BackSpace ), spawn "xscreensaver-command -lock")
        -- Hibernate
        , ((Main.modMask .|. shiftMask, xK_BackSpace ), spawn "sudo pm-hibernate")
        -- Screenshot
        , ((0           , xK_Print ), spawn "gnome-screenshot")
        -- GridSelect
        , ((Main.modMask, xK_g), goToSelected defaultGSConfig)
    ]
    ++
    -- the 12 workspaces acces keys
    [((m .|. Main.modMask, k), windows $ f i)
         | (i, k) <- zip myWorkspaces [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0,xK_minus,xK_equal]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myManageHook = composeAll . concat $
    [ 
          [ isFullscreen --> doFullFloat ]
        , [ isDialog     --> doCenterFloat ]
        , [ title     =? "DOTA 2 - OpenGL" --> doFullFloat ]
        , [ title     =? t --> doCenterFloat | t <- myTitleFloats ]
        , [ resource  =? r --> doCenterFloat | r <- myResourceFloats ]
        , [ className =? c --> doCenterFloat | c <- myCenterFloats ]
        , [ className =? c --> doFloat       | c <- myFloats ]
        , [ className =? c --> doFullFloat   | c <- myFullFloats ]
        , [ className =? c --> doIgnore      | c <- myIgnores ]
        , [ className =? "Chromium" --> doShift "1" ]
        , [ className =? "Icedove"  --> doShift "-" ]
    ]
    where
        myFloats         = ["Gimp", "Skype", "MPlayer", "SMPlayer", "VLC", "Audacious", "Steam"]
        myFullFloats     = ["steam"]
        myCenterFloats   = ["Xmessage"]
        myTitleFloats    = ["File Operation Progress"]
        myResourceFloats = ["Dialog"]
        myIgnores        = ["trayer"]


myLayout = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| noBorders Full ||| Grid ||| resizable))
          where
              tiled     = Tall nmaster delta ratio
              resizable = ResizableTall nmaster delta ratio []
              nmaster   = 1     -- The default number of windows in the master pane
              ratio     = 1%2   -- Default proportion of screen occupied by master pane
              delta     = 5%100 -- Percent of screen to increment by when resizing panes


-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what's being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]" 
                , ppHiddenNoWindows = xmobarColor "#444" ""}

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


-- Main configuration, override the defaults to your liking.
myConfig = ewmh defaultConfig {
      workspaces = myWorkspaces
    , layoutHook = myLayout
    , terminal = "xterm"
    -- , modMask = mod1Mask
    , keys = myKeys
    , manageHook = manageHook defaultConfig <+> myManageHook <+> manageDocks
    }

-- Ouhlala
main :: IO ()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
