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
        property bool itemFolded: true
        property int testCounter: 0

        anchors.fill: parent
        anchors.margins: 2 * DevicePixelRatio

        states: [
            State {
                name: "stateMainMenu"
                PropertyChanges {
                    target: screen
                    itemFolded: false
                }
                PropertyChanges {
                    target: gameTitle
                    opacity: 0
                }
            }
        ]

        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            spacing: 2 * DevicePixelRatio

            FadeItem {
                id: progressBarFadeItem
                Layout.fillWidth: true
                Layout.preferredHeight: 25 * DevicePixelRatio
                folded: screen.itemFolded
                inlineContent: JProgressBar {
                    id: pbItem
                    anchors.fill: parent
                    progress: screen.testCounter //gameBoard.levelCap
                    visible: true
                    /// TODO extract color to AppSingleton
                    color: "white"
                    secondColor: "green"
                }
            }

            FadeItem {
                id: gameBoardFadeItem
                Layout.fillWidth: true
                Layout.preferredHeight: 320 * DevicePixelRatio
                folded: screen.itemFolded
                inlineContent: GameBoard {
                    id: gameBoard
                    anchors.fill: parent
                    Binding {
                        target: scoreBox
                        property: "gameBoardScore"
                        value: gameBoard.score
                    }
                    Binding {
                        target: scoreBox
                        property: "gameBoardLevel"
                        value: gameBoard.level
                    }
                    Component.onCompleted: {

                        if (isDebugMode) {
                            gameBoard.score = 777
                        }
                    }
                }
            }

            QQC2.Frame {
                id: spacerFrame_3
                visible: !screen.itemFolded
                Layout.fillWidth: true
                Layout.preferredHeight: 2 * DevicePixelRatio
            }

            FadeItem {
                id: gameButtonFadeItem
                Layout.fillWidth: true
                Layout.preferredHeight: 32 * DevicePixelRatio

                folded: screen.itemFolded
                inlineContent: RowLayout {
                    id: toolBarLayout
                    anchors.fill: parent

                    spacing: 10 * DevicePixelRatio

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
            }

            RowLayout {
                id: infoRowLayout
                spacing: 2 * DevicePixelRatio
                Layout.fillWidth: true
                Layout.preferredHeight: 24 * DevicePixelRatio
                Layout.alignment: Qt.AlignBottom
                Layout.topMargin: 5 * DevicePixelRatio

                FadeItem {
                    id: fpsFadeItem
                    Layout.alignment: Qt.AlignLeft
                    Layout.fillHeight: true
                    Layout.preferredWidth: 140 * DevicePixelRatio
                    folded: !screen.itemFolded
                    inlineContent: FpsItem {
                        id: fpsItem
                        anchors.fill: parent
                        rowSpacing: 2 * DevicePixelRatio
                        textColor: Theme.accent
                    }
                }
                Item {
                    Layout.fillWidth: true
                }

                FadeItem {
                    id: appVersionFadeItem
                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: 140 * DevicePixelRatio
                    Layout.fillHeight: true
                    folded: !screen.itemFolded
                    inlineContent: AppVersionTxt {
                        id: appVerTxt
                        color: Theme.accent
                        text: g_appVersion
                    }
                }
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
