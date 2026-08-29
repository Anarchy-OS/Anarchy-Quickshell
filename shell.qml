import Quickshell
import Quickshell.Io
import "PillBar"
import "Notifications"
import "WallpaperSelector"
import "PowerMenu"
import "AppLauncher"
import "Keybinds"
import "CalendarApp"
import "Theme"

ShellRoot {
    IpcHandler {
        target: "theme-manager"
        function reload(): void {
            Theme.reloadTheme()
        }
    }

    Bar {}
    Notification {}
    WallpaperSelector {}
    PowerMenu {}
    AppLauncher {}
    Keybinds {}
    CalendarWindow {}
}