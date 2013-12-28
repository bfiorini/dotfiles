import XMonad
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Prompt
import XMonad.Prompt.Shell

import Data.Bits ((.|.))
import Data.Ratio ((%))
import System.IO
import qualified Data.Map as M


modMask = mod1Mask


myWorkspaces :: [String]
myWorkspaces =
    ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="]


-- keycode: /usr/include/X11/keysymdef.h
defKeys = keys defaultConfig
myKeys x   = foldr (uncurry M.insert) (defKeys x) (toAdd    x)
toAdd x   =
    [
        -- Cycle through workspaces
         ((Main.modMask .|. shiftMask, xK_grave ), prevWS)
        ,((Main.modMask   , xK_grave ), nextWS)
        -- Increment the number of windows in the master area
        ,((Main.modMask  , xK_comma ), sendMessage (IncMasterN 1))
        -- Deincrement the number of windows in the master area
        ,((Main.modMask  , xK_period), sendMessage (IncMasterN (-1)))
        -- Hide status bar
        ,((Main.modMask  , xK_b ), sendMessage ToggleStruts)
        -- Restart xmonad
        , ((Main.modMask  , xK_q ), spawn "xmonad --recompile; xmonad --restart")
        -- Run nautilus
        , ((Main.modMask  , xK_f ), spawn "nautilus --no-desktop")
        -- Prompt
        , ((Main.modMask  , xK_semicolon ), shellPrompt defaultXPConfig)
        -- Resizable tile
        , ((Main.modMask  , xK_a ), sendMessage MirrorShrink)
        , ((Main.modMask  , xK_z ), sendMessage MirrorExpand)
        -- lock screen
        , ((Main.modMask  , xK_BackSpace ), spawn "i3lock -d")
        -- screenshot
        , ((0  , xK_Print ), spawn "gnome-screenshot")
    ]
    ++
    -- the 12 workspaces acces keys
    [((m .|. Main.modMask, k), windows $ f i)
         | (i, k) <- zip myWorkspaces [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0,xK_minus,xK_equal]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myManageHook =
    [ 
          isFullscreen --> doFullFloat
        , isDialog     --> doCenterFloat
        , className    =? "Xmessage"       --> doCenterFloat 
        , className    =? "Gimp"           --> doFloat
        , className    =? "Chromium"       --> doShift "1"
        , className    =? "Icedove"        --> doShift "-"
        , className    =? "Skype"          --> doFloat
        , className    =? "vlc"            --> doCenterFloat
        , className    =? "MPlayer"        --> doCenterFloat
        , className    =? "Audacious"      --> doFloat
    ]


myLayout = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| Full ||| Grid ||| resizable))
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
myConfig = defaultConfig {
     workspaces = myWorkspaces
    , layoutHook = myLayout
    , terminal = "xterm"
    -- , modMask = mod1Mask
    , keys = myKeys
    , manageHook = manageHook defaultConfig <+> composeAll myManageHook <+> manageDocks
    }

-- Ouhlala
main :: IO ()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
