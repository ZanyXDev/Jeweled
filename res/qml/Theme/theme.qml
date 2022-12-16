pragma Singleton

import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import Common 1.0

//https://material-theme.com/docs/reference/color-palette/
Item {
    id: root

    property int theme: Material.Dark

    property var primary: (root.theme === Material.Dark) ? "#003946" : "#d1cbb8"
    property var accent: (root.theme === Material.Dark) ? "#d13684" : "#cb4b16"
    property var background: (root.theme === Material.Dark) ? "#002B36" : "#fdf6e3"
    property var foreground: (root.theme === Material.Dark) ? "#839496" : "#586e75"

    function toggleTheme() {
        root.theme = (root.theme === Material.Dark ? Material.Light : Material.Dark)
    }

    function isDarkMode() {
        if (isDebugMode) {
            AppSingleton.toLog("Jeweled", `ead isDarkMode()->${root.theme}`)
        }
        return root.theme === Material.Dark
    }

    function setDarkMode() {
        root.theme = Material.Dark
    }
}
