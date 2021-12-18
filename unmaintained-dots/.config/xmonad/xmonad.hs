------------------------------------------------------------------------
-- Imports
------------------------------------------------------------------------

import Control.Monad (when)
import qualified Data.Map as M
import Data.Maybe (fromJust, isJust)
import Data.Monoid
import System.Exit
import XMonad
import XMonad.Layout
import XMonad.Actions.CycleWS (Direction1D (..), WSType (..), moveTo, nextScreen, nextWS, prevScreen, shiftTo)
import XMonad.Config.Dmwit (altMask)
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

------------------------------------------------------------------------
-- Settings
------------------------------------------------------------------------

-- Terminal
myTerminal :: String
myTerminal = "alacritty"

-- Browser
myBrowser :: String
myBrowser = "firefox"

-- File Manager
myFM :: String
myFM = "thunar"

-- Text Editor
myEditor :: String
myEditor = myTerminal ++ " -e nvim"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels
myBorderWidth = 1

-- Border colors for unfocused and focused windows
myNormalBorderColor = "#3D4353"

myFocusedBorderColor = "#e06c75"

-- Mod Key
myModMask = mod4Mask

------------------------------------------------------------------------
-- Workspaces
------------------------------------------------------------------------

myWorkspaces = ["web", "dev", "ter", "dir", "vid", "vm", "other"]

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1 ..]

-- clickable workspaces
clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

------------------------------------------------------------------------
-- Key bindings
------------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ ------------------------------------------------------------------
      -- Applications
      ------------------------------------------------------------------

      -- launch a terminal
      ((modm, xK_Return), spawn $ XMonad.terminal conf),
      -- launch a web browser
      ((modm, xK_a), spawn $ myBrowser),
      -- launch a file manager
      ((modm, xK_e), spawn $ myFM),
      -- launch a Texteditor
      ((modm, xK_n), spawn $ myEditor),

      ------------------------------------------------------------------
      -- Rofi menus
      ------------------------------------------------------------------

      -- Application launcher
      ((modm, xK_d), spawn "~/.config/rofi/bin/app_menu"),
      -- Screenshot menu
      ((modm, xK_s), spawn "~/.config/rofi/bin/screenshot_menu"),
      -- Power menu
      ((modm .|. shiftMask, xK_e), spawn "~/.config/rofi/bin/power_menu"),

      ------------------------------------------------------------------
      -- Window controls
      ------------------------------------------------------------------

      -- close focused window
      ((modm .|. shiftMask, xK_q), kill),
      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
      -- Swap the focused window and the master window
      ((modm .|. shiftMask, xK_Return), windows W.swapMaster),
      -- Shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- Expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- Push window back into tiling
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- Increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- Deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- Toggle the status bar gap
      ((modm, xK_v), sendMessage ToggleStruts),

      ------------------------------------------------------------------
      -- Xmonad
      ------------------------------------------------------------------

      -- Cycle non-empty workspaces
      ((modm, xK_Tab), moveTo Next NonEmptyWS),
      -- Cycle all workspaces
      ((modm, xK_z), nextWS),
      -- Quit xmonad
      ((modm .|. shiftMask, xK_c), io (exitWith ExitSuccess)),
      -- Restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart"),

      ------------------------------------------------------------------
      -- Screen
      ------------------------------------------------------------------

      -- Rotate left
      ((modm .|. altMask, xK_Left), spawn "xrandr --output VGA1 --rotate left"),
      -- Rotate right
      ((modm .|. altMask, xK_Right), spawn "xrandr --output VGA1 --rotate right"),
      -- Rotate upside down
      ((modm .|. altMask, xK_Down), spawn "xrandr --output VGA1 --rotate inverted"),
      -- Rotate normal
      ((modm .|. altMask, xK_Up), spawn "xrandr --output VGA1 --rotate normal"),

      ------------------------------------------------------------------
      -- Volume
      ------------------------------------------------------------------

      -- Increase volume
      ((0, 0x1008ff13), spawn "pactl -- set-sink-volume 0 +5%; ~/.config/xmobar/scripts/volume.sh"),
      -- Decrease volume
      ((0, 0x1008ff11), spawn "pactl -- set-sink-volume 0 -5%; ~/.config/xmobar/scripts/volume.sh"),
      -- Toggle Mute
      ((0, 0x1008ff12), spawn "pactl set-sink-mute 0 toggle; ~/.config/xmobar/scripts/volume.sh")
    ]
      ++
      -- Switch to a workspace & Move window to a workspace
      [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]

------------------------------------------------------------------------
-- Mouse bindings
------------------------------------------------------------------------

myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ --((modm, button1), (\w -> focus w >> windows W.shiftMaster)),
      -- mod-button2, Set the window to floating mode and move by dragging
      ( (modm, button2),
        ( \w -> do
            focus w
            mouseMoveWindow w
            windows W.shiftMaster
        )
      ),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        ( \w ->
            focus w >> mouseResizeWindow w
              >> windows W.shiftMaster
        )
      )
    ]

------------------------------------------------------------------------
-- Layouts
------------------------------------------------------------------------

myLayout = avoidStruts (smartBorders tiled ||| smartBorders Full ||| Mirror tiled )
  where
    -- Default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio

    -- Default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

------------------------------------------------------------------------
-- Window rules
------------------------------------------------------------------------

myManageHook =
  composeAll
    [ isFullscreen --> doFullFloat,
      className =? "obs" --> doFloat,
      className =? "Nm-connection-editor" --> doFloat,
      className =? "Pavucontrol" --> doFloat,
      className =? "Tk" --> doFloat,
      className =? "Xmessage" --> doFloat,
      title =? "Confirm to replace files" --> doFloat,
      title =? "File Operation Progress" --> doFloat,
      className =? "Code" --> doShift (myWorkspaces !! 1),
      className =? "Gimp" --> doShift (myWorkspaces !! 4),
      className =? "kdenlive" --> doShift (myWorkspaces !! 4),
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling
------------------------------------------------------------------------

myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging
------------------------------------------------------------------------

myLogHook h =
  dynamicLogWithPP $
    xmobarPP
      { ppCurrent = xmobarColor "#c678dd" "" . wrap "<box type=Bottom width=1 mb=2 color=#c792ea>" "</box>",
        ppHidden = xmobarColor "#98c379" "" . clickable,
        ppHiddenNoWindows = xmobarColor "#61afef" "" . clickable,
        ppTitle = xmobarColor "#abb2bf" "" . shorten 30,
        ppOutput = hPutStrLn h
      }

------------------------------------------------------------------------
-- Startup hook
------------------------------------------------------------------------

myStartupHook = do
  spawn "~/.config/xmobar/scripts/volpipe.sh &"
  spawnOnce "lxsession &"
  spawnOnce "emote &"
  spawnOnce "parcellite &"
  spawnOnce "trayer --edge top --align right --padding 9 --SetDockType true --SetPartialStrut true --expand true --monitor VGA1 --transparent true --alpha 0 --tint 0x282c34 --widthtype request --height 22 &"

------------------------------------------------------------------------
-- Named Scratchpads
------------------------------------------------------------------------

myScratchPads :: [NamedScratchpad]
myScratchPads =
  [ NS "terminal" spawnTerm findTerm manageTerm
  ]
  where
    spawnTerm = myTerminal ++ " -t scratchpad"
    findTerm = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

------------------------------------------------------------------------
-- Run xmonad
------------------------------------------------------------------------

main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobar.hs"
  xmonad $
    docks
      def
        { terminal = myTerminal,
          focusFollowsMouse = myFocusFollowsMouse,
          clickJustFocuses = myClickJustFocuses,
          borderWidth = myBorderWidth,
          modMask = myModMask,
          workspaces = myWorkspaces,
          normalBorderColor = myNormalBorderColor,
          focusedBorderColor = myFocusedBorderColor,
          keys = myKeys,
          mouseBindings = myMouseBindings,
          layoutHook = myLayout,
          manageHook = myManageHook,
          handleEventHook = myEventHook,
          logHook = myLogHook xmproc,
          startupHook = myStartupHook
        }
