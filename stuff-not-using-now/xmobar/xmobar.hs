Config
  { font = "xft:Cascadia Mono:weight=bold:pixelsize=13:antialias=true:hinting=true",
    additionalFonts = ["xft:Font Awesome 5 Free Solid:pixelsize=11:antialias=true:hinting:true"],
    borderColor = "black",
    border = TopB,
    bgColor = "#282c34",
    fgColor = "#abb2bf",
    alpha = 255,
    position = Static { xpos = 0 , ypos = 0, width = 1440, height = 22 },
    textOffset = -1,
    iconOffset = -1,
    lowerOnStart = True,
    pickBroadest = False,
    persistent = False,
    hideOnStart = False,
    iconRoot = "",
    allDesktops = True,
    overrideRedirect = True,
    commands =
      [
        Run Com "/home/unnat/.config/xmobar/scripts/network.sh" [] "network" 200,
        Run Com "/home/unnat/.config/xmobar/scripts/datetime.sh" [] "datetime" 600,
        Run PipeReader "/tmp/.volume-pipe" "volume",
        Run Com "/home/unnat/.config/xmobar/scripts/systraypad.sh" [] "systraypad" 60,
        Run UnsafeStdinReader
      ],
    sepChar = "%",
    alignSep = "}{",
    template = " %UnsafeStdinReader% }{ %datetime% | %network% | %volume%%systraypad%"
  }
