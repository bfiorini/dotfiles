import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import Data.Bits ((.|.))
import Data.Ratio ((%))
import System.IO

import qualified Data.Map as M

myWorkspaces :: [String]
myWorkspaces =
  ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="]


modMask = mod1Mask

-- keycode: /usr/include/X11/keysymdef.h
defKeys = keys defaultConfig
myKeys x   = foldr (uncurry M.insert) (defKeys x) (toAdd    x)
toAdd x   =
    [ 

        -- switch workspace (gnome shortcut) 
        -- ((Main.modMask .|. controlMask, xK_Left  ), prevWS)
         ((Main.modMask   , xK_grave ), nextWS)
        -- Increment the number of windows in the master area
        ,((Main.modMask  , xK_comma ), sendMessage (IncMasterN 1))
        -- Deincrement the number of windows in the master area
        ,((Main.modMask  , xK_semicolon), sendMessage (IncMasterN (-1)))
        ,((Main.modMask  , xK_b ), sendMessage ToggleStruts)
        -- Restart xmonad
        , ((Main.modMask  , xK_q ), spawn "xmonad --recompile; xmonad --restart")
        , ((Main.modMask  , xK_f ), spawn "nautilus --no-desktop")

        , ((Main.modMask  , xK_BackSpace ), spawn "i3lock -d")
        , ((0  , xK_Print ), spawn "gnome-screenshot")

    ]
    ++
    [((m .|. Main.modMask, k), windows $ f i)
         | (i, k) <- zip myWorkspaces [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8, xK_9, xK_0, xK_minus, xK_equal] -- [xK_F1 .. xK_F9]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myManageHook =
-- Single monitor setups, or if the previous hook doesn't work
    [ 
        isFullscreen --> doFullFloat
        , isDialog --> doCenterFloat
        , className =? "Xmessage"       --> doCenterFloat 
        , className =? "Gimp"           --> doFloat
        , className =? "Chromium"       --> doShift "1"
        , className =? "Icedove"        --> doShift "-"
        , className =? "Claws"          --> doShift "-"
        , className =? "Deluge"         --> doShift "4"
        , className =? "Skype"          --> doFloat
        , className =? "vlc"            --> doCenterFloat
        , className =? "Pidgin"         --> doShift "="
    ]


myLayout = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| Full))
          where
              tiled   = Tall nmaster delta ratio
              nmaster = 1     -- The default number of windows in the master pane
              ratio   = 1%2   -- Default proportion of screen occupied by master pane
              delta   = 5%100 -- Percent of screen to increment by when resizing panes

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what's being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" 
                , ppHiddenNoWindows = xmobarColor "#444" ""}

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig {
     workspaces = myWorkspaces
    , layoutHook = myLayout
    , terminal = "xterm"
    -- , modMask = mod1Mask
    , keys = myKeys
    , manageHook = manageHook defaultConfig <+> composeAll myManageHook <+> manageDocks
    }

main :: IO ()
--main =
--  xmonad gnomeConfig
--  { 
--     workspaces = myWorkspaces
--    , layoutHook = myLayout
--    --, terminal = myTerminal
--    --, modMask = mod4Mask
--    , keys = myKeys
--    , manageHook = manageHook gnomeConfig <+> composeAll myManageHook
--  }

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
