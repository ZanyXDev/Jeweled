import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.LocalStorage 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15
import QtQuick.Controls.impl 2.15
import QtGraphicalEffects 1.0

import Common 1.0
import Theme 1.0
import Dialogs 1.0
import Components 1.0
import AppEffects 1.0

import "qrc:/res/js/util.js" as Utils

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Fade in / Fade out demo by raymii.org")

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20 * DevicePixelRatio
        spacing: 20 * DevicePixelRatio

        QQC2.Button {
            text: fadeItem.folded ? "Fade in" : "Fade out"
            onClicked: {

                fadeItem.folded = !fadeItem.folded
                fadeItem2.folded = !fadeItem2.folded
            }
        }

        FadeItem {
            id: fadeItem
            Layout.fillWidth: true
            Layout.preferredHeight: 80 * DevicePixelRatio
            bgrColor: "#efefef"
            inlineContent: QQC2.Label {
                text: "World"
                background: Rectangle {
                    color: "#30dd0000"
                }
            }
        }
        FadeItem {
            id: fadeItem2
            Layout.fillWidth: true
            Layout.preferredHeight: 80 * DevicePixelRatio
            bgrColor: "green"
        }
        Rectangle {
            color: "red"
            Layout.fillWidth: true
            Layout.preferredHeight: 80 * DevicePixelRatio
        }
    }
}

/**
QQC2.ApplicationWindow {
    id: appWnd
    // ----- Property Declarations

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation
    readonly property bool appInForeground: Qt.application.state === Qt.ApplicationActive
    readonly property real winScale: Math.min(width / 1280.0, height / 720.0)
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

    background: Image {
        id: background
        anchors.fill: parent
        source: Utils.getBackgroundSource()

        fillMode: Image.PreserveAspectCrop
    }

    // ----- Visual children
    header: QQC2.ToolBar {
        id: pageHeader
        background: Rectangle {
            color: "transparent"
        }
        RowLayout {
            anchors.fill: parent
            spacing: 2 * DevicePixelRatio
            QQC2.ToolButton {
                id: btnHelp
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                icon.source: "qrc:/res/images/icons/ic_help.svg"
                action: changeThemeMenuAction
            }

            Item {
                Layout.fillHeight: true
            }

            ScoreBox {
                id: scoreBox
                Layout.fillWidth: true
                appTitle: qsTr("FreeJeweled")
                gameBoardScore: gameBoard.score
                gameBoardLevel: gameBoard.level
                state: "stateShowAppTitle"
            }

            Item {
                Layout.fillHeight: true
            }

            QQC2.ToolButton {
                id: btnMoreMenu
                visible: true
                icon.source: "qrc:/res/images/icons/ic_bullet.svg"
                action: optionsMenuAction
            }
        }
        Component.onCompleted: {
            if (isDebugMode)
                console.log("pageHeader.size:[" + pageHeader.width / 1.5 + ","
                            + pageHeader.height / 1.5 + "]")
        }
    }

    Item {
        id: screen
        anchors.fill: parent
        anchors.margins: 2 * DevicePixelRatio
        states: [
            State {
                name: "*"
                PropertyChanges {
                    target: gameTitle
                    opacity: 1.0
                }
                PropertyChanges {
                    target: appVerTxt
                    opacity: 1.0
                }
                PropertyChanges {
                    target: fpsItem
                    opacity: 1.0
                }
                PropertyChanges {
                    target: btnRun
                    enabled: false
                }
                PropertyChanges {
                    target: btnReset
                    enabled: false
                }
                PropertyChanges {
                    target: btnShowHint
                    enabled: false
                }
            },
            State {
                name: "stateMainMenu"
                PropertyChanges {
                    target: gameTitle
                    opacity: 0.0
                }
                PropertyChanges {
                    target: appVerTxt
                    opacity: 0.0
                }
                PropertyChanges {
                    target: fpsItem
                    opacity: 0.0
                }
            },
            State {
                name: "stateGame"
                PropertyChanges {
                    target: scoreBox
                    state: "stateShowScore"
                }
            }
        ]

        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            spacing: 2 * DevicePixelRatio

            FpsItem {
                id: fpsItem
                Layout.fillWidth: true
                Layout.preferredHeight: 25 * DevicePixelRatio

                rowSpacing: 2 * DevicePixelRatio
                textColor: Theme.accent

                visible: opacity > 0
            }
            JProgressBar {
                id: pbLevelProgress
                Layout.fillWidth: true
                Layout.preferredHeight: 25 * DevicePixelRatio
                visible: screen.state === "stateGame"
                value: gameBoard.levelCap
                color: "white"
                secondColor: "green"
            }
            GameBoard {
                id: gameBoard
                Layout.fillWidth: true
                Layout.preferredHeight: 320 * DevicePixelRatio
                visible: screen.state == "stateGame"
            }
            QQC2.Frame {
                id: spacerFrame_3
                visible: screen.state == "stateGame"
                Layout.fillWidth: true
                Layout.preferredHeight: 2 * DevicePixelRatio
            }

            RowLayout {
                id: toolBarLayout

                Layout.fillWidth: true
                Layout.preferredHeight: 20 * DevicePixelRatio
                Layout.alignment: Qt.AlignBottom
                Layout.bottomMargin: 15 * DevicePixelRatio

                spacing: 10 * DevicePixelRatio
                visible: screen.state === "stateMainMenu"
                Item {
                    Layout.fillWidth: true
                }

                BaseButton {
                    id: btnRun
                    text: qsTr("Run")
                    enabled: screen.state === "stateMainMenu"
                    onClicked: {
                        screen.state = "stateGame"
                    }
                }
                BaseButton {
                    id: btnReset
                    enabled: !btnRun.enabled
                    text: qsTr("Reset")
                    onClicked: {

                        //  gameBoard.resetBoard()
                    }
                }
                BaseButton {
                    id: btnShowHint
                    enabled: !btnRun.enabled
                    text: qsTr("Hint")
                    onClicked: {

                        // gameBoard.showHint()
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
            }
            AppVersionTxt {
                id: appVerTxt
                Layout.fillWidth: true
                Layout.preferredHeight: 25 * DevicePixelRatio
                color: Theme.accent
                visible: opacity > 0
                text: g_appVersion
            }
        }
    }

    GameTitle {
        id: gameTitle
        width: parent.width * 0.9
        height: 126. / 346. * width
        anchors.topMargin: 30 * DevicePixelRatio
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 1
        MouseArea {
            id: gameTitleMouseArea
            anchors.fill: parent
            onClicked: {
                screen.state = "stateMainMenu"
            }
        }
        Component.onCompleted: {
            autoStartTimer.start()
        }
    }
    //        // ----- Custom non-visual children
    //        // ----- JavaScript functions
    AboutDialog {
        id: dlgAbout
    }
    // ----- Qt provided non-visual children
    QQC2.Action {
        id: optionsMenuAction

        onTriggered: {

            //background.source = Utils.getBackgroundSource(background.source)
        }
    }
    QQC2.Action {
        id: changeThemeMenuAction

        onTriggered: {
            Theme.toggleTheme()
            AppSingleton.toLog("Jeweled", "changeThemeMenuAction click")
        }
    }

    // ----- Custom non-visual children
    Timer {
        id: autoStartTimer
        interval: AppSingleton.enoughTimeToDie * 3
        repeat: false
        running: gameTitle.opacity > 0
        onTriggered: {
            screen.state = "stateMainMenu"
            autoStartTimer.stop()
        }
    }

    // ----- JavaScript functions
    /// TODO move to Utils.js
}

*/

