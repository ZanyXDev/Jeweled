import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.LocalStorage 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import Common 1.0
import Theme 1.0
import Dialogs 1.0
import Components 1.0

QQC2.ApplicationWindow {
    id: appWnd
    // ----- Property Declarations

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation
    readonly property bool appInForeground: Qt.application.state === Qt.ApplicationActive
    property bool appInitialized: false
    // ----- Signal declarations
    signal screenOrientationUpdated(int screenOrientation)

    // ----- Size information
    width: 320 * DevicePixelRatio
    height: 480 * DevicePixelRatio
    // ----- Then comes the other properties. There's no predefined order to these.
    visible: true
    visibility: (isMobile) ? Window.FullScreen : Window.Windowed
    flags: Qt.Dialog
    title: qsTr(" ")
    Screen.orientationUpdateMask: Qt.PortraitOrientation | Qt.LandscapeOrientation
                                  | Qt.InvertedPortraitOrientation | Qt.InvertedLandscapeOrientation
    Material.theme: Theme.theme
    Material.primary: Theme.primary
    Material.accent: Theme.accent
    Material.background: Theme.background
    Material.foreground: Theme.foreground

    // ----- Then attached properties and attached signal handlers.

    // ----- States and transitions.
    // ----- Signal handlers
    onScreenOrientationChanged: {
        screenOrientationUpdated(screenOrientation)
    }
    onClosing: {

    } //appCore.uninitialize()
    onAppInForegroundChanged: {
        if (appInForeground) {
            if (!appInitialized) {
                appInitialized = true
                // Theme.setDarkMode()
                //appCore.initialize()
            }
        } else {
            if (isDebugMode)
                console.log("onAppInForegroundChanged-> [appInForeground:"
                            + appInForeground + ", appInitialized:" + appInitialized + "]")
        }
    }
    Component.onCompleted: {

    }

    background: Image {
        id: background
        anchors.fill: parent
        source: "qrc:/res/images/backgrounds/bgr00.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    // ----- Visual children
    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio

        ScoreBox {
            id: scorebox
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 40 * DevicePixelRatio /* cellSize*1.5, actually */

            gameBoardScore: "0000"
            gameBoardLevel: 1
        }

        QQC2.Frame {
            id: spacerFrame
            visible: true
            Layout.fillWidth: true
            Layout.preferredHeight: 2 * DevicePixelRatio
        }

        Item {
            id: gameScreen
            Layout.fillWidth: true
            Layout.preferredHeight: 420 * DevicePixelRatio

            RowLayout {
                id: testButton
                anchors.fill: parent
                spacing: 8 * DevicePixelRatio
                QQC2.Button {
                    id: tstButton1
                    text: "stateNormal"
                    onClicked: {
                        scorebox.state = "stateNormal"
                    }
                }

                QQC2.Button {
                    id: tstButton2
                    text: "stateHidden"
                    onClicked: {
                        scorebox.state = "stateHidden"
                    }
                }
            }
        }
    }
    // ----- Qt provided non-visual children
    QQC2.Action {
        id: optionsMenuAction

        onTriggered: {
            //optionsMenu.open()
            if (isDebugMode)
                console.log("optionsMenuAction click")
            Qt.quit()
        }
    }

    QQC2.Action {
        id: changeThemeMenuAction

        onTriggered: {
            Theme.toggleTheme()
            if (isDebugMode)
                console.log("changeThemeMenuAction click")
        }
    }
    // ----- Custom non-visual children
    FontLoader {
        id: gameFont
        source: "qrc:/res/fonts/mailrays.ttf"
    }

    FontLoader {
        id: buttonFont
        source: "qrc:/res/fonts/pirulen.ttf"
    }

    // a globally avalable utility object
    QtObject {
        id: global

        readonly property real winScale: Math.min(width / 1280.0,
                                                  height / 720.0)

        property QtObject fonts: QtObject {
            readonly property string gamefont: gameFont.name
            readonly property string buttonfont: buttonFont.name
        }
    }

    // ----- JavaScript functions
    function setBackgroundSource() {
        var source = generateBackgroundFileName()
        while (source === background.source) {
            source = generateBackgroundFileName()
            if (isDebugMode)
                console.log("setBackgroundSource() return:" + source)
        }
        background.source = source
    }

    function generateBackgroundFileName() {
        var bgrStr = Math.floor(Math.random() * 20 + 1).toString()
        if (bgrStr.length === 1) {
            bgrStr = "0" + bgrStr
        }
        return "qrc:/res/images/backgrounds/bgr" + bgrStr + ".jpg"
    }
}
