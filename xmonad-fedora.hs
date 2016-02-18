-- PrDE XMonad Config

import System.Posix.Env (getEnv, putEnv)
import Data.Maybe (maybe)
import Control.Monad
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import qualified Data.Map        as M 

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $           
    -- launch a terminal                                               
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)                
    -- launch dmenu                                                    
    -- , ((modm,               xK_p     ), spawn myDmenuCommand)  
                                                                       
    -- close focused window                                            
    , ((modm .|. shiftMask, xK_c     ), kill) 

    , ((modm,               xK_Tab   ), windows W.focusDown)           
                                                                       
    -- Move focus to the next window                                   
    , ((modm,               xK_j     ), windows W.focusDown)           
                                                                       
    -- Move focus to the previous window                               
    , ((modm,               xK_k     ), windows W.focusUp  )           
                                                                       
    -- Move focus to the master window                                 
    , ((modm,               xK_m     ), windows W.focusMaster  ) 

    , ((modm, xK_e), spawn "emacs")
    --, ((modm, xK_Left), prevWS)
    --, ((modm, xK_Right), nextWS)

    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) 
                                                                       
    -- Restart xmonad                                                  
    -- , ((modm              , xK_q     ), restart "xmonad" True)

    , ((modm .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    ]
    ++

    [((m .|. modm, k), windows $ f i)    
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]        
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


main = do
     session <- getEnv "DESKTOP_SESSION"
     putEnv "_JAVA_AWT_WM_NONREPARENTING=1"
     xmonad  $ gnomeConfig  -- maybe desktopConfig desktop session
        {
        modMask = mod4Mask
        , focusFollowsMouse = True
        , focusedBorderColor = "green"
        , normalBorderColor = "#444"
        , keys = myKeys
        , terminal = "gnome-terminal"
        }

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig