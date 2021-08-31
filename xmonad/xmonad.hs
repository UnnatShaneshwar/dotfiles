------------------------------------------------------------------------
-- Imports
------------------------------------------------------------------------

import qualified Data.Map as M
import Data.Maybe
import Data.Monoid
import System.Exit
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

------------------------------------------------------------------------
-- Settings
------------------------------------------------------------------------

-- Terminal
myTerminal :: String
myTerminal = "alacritty"

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

--myWorkspaces = ["", "", "", "", "", "", "", "", "", "Other"]
--myWorkspaces = ["\e007", "\f121", "\f120", "\f086", "\f07b", "\f008", "\f108", "\f249", "\f233", "Other"]

myWorkspaces = ["web", "dev", "ter", "dir", "vid", "vm", "other"]

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

------------------------------------------------------------------------
-- Key bindings
------------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ -- launch a terminal
      ((modm, xK_Return), spawn $ XMonad.terminal conf),
      -- rofi application launcher
      ((modm, xK_d), spawn "~/.config/rofi/bin/app_menu"),
      -- rofi menu screenshot
      ((modm, xK_s), spawn "~/.config/rofi/bin/screenshot_menu"),
      -- rofi powermenu
      ((modm .|. shiftMask, xK_e), spawn "~/.config/rofi/bin/power_menu"),
      -- open file manager
      ((modm, xK_e), spawn "thunar"),
      -- close focused window
      ((modm .|. shiftMask, xK_q), kill),
      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window and the master window
      ((modm .|. shiftMask, xK_Return), windows W.swapMaster),
      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
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
      ((modm, xK_b), sendMessage ToggleStruts),
      -- Cycle Workspaces
      ((modm, xK_Tab), moveTo Next NonEmptyWS),
      ((modm, xK_z), nextWS),
      -- Quit xmonad
      ((modm .|. shiftMask, xK_c), io (exitWith ExitSuccess)),
      -- Restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart"),
      -- Increase volume
      ((0, 0x1008ff13), spawn "pactl -- set-sink-volume 0 +5%"),
      -- Decrease volume
      ((0, 0x1008ff11), spawn "pactl -- set-sink-volume 0 -5%"),
      -- Toggle Mute
      ((0, 0x1008ff12), spawn "pactl set-sink-mute 0 toggle")
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
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        ( \w ->
            focus w >> mouseMoveWindow w
              >> windows W.shiftMaster
        )
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        ( \w ->
            focus w >> mouseResizeWindow w
              >> windows W.shiftMaster
        )
      )
    ]

------------------------------------------------------------------------
-- Layouts:
------------------------------------------------------------------------

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
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
-- Window rules:
------------------------------------------------------------------------

myManageHook =
  composeAll
    [ isFullscreen --> doFullFloat,
      className =? "Lxappearance" --> doFloat,
      className =? "obs" --> doFloat,
      className =? "Nm-connection-editor" --> doFloat,
      className =? "Pavucontrol" --> doFloat,
      className =? "Xmessage" --> doFloat,
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
  spawnOnce "picom --experimental-backend &"
  spawnOnce "xmodmap ~/.config/.Xmodmap &"
  spawnOnce "feh --bg-scale '/home/unnat/Pictures/backgrounds/w_68.jpeg' &"
  spawnOnce "lxsession &"

------------------------------------------------------------------------
-- Run xmonad
------------------------------------------------------------------------

main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobar.config"
  xmonad $
    docks
      defaultConfig
        { -- simple stuff
          terminal = myTerminal,
          focusFollowsMouse = myFocusFollowsMouse,
          clickJustFocuses = myClickJustFocuses,
          borderWidth = myBorderWidth,
          modMask = myModMask,
          workspaces = myWorkspaces,
          normalBorderColor = myNormalBorderColor,
          focusedBorderColor = myFocusedBorderColor,
          -- key bindings
          keys = myKeys,
          mouseBindings = myMouseBindings,
          -- hooks, layouts
          layoutHook = myLayout,
          manageHook = myManageHook,
          handleEventHook = myEventHook,
          logHook = myLogHook xmproc,
          startupHook = myStartupHook
        }

