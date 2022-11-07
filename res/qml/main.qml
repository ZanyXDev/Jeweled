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
import DataModels 1.0

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
                id: scorebox
                Layout.fillWidth: true
                appTitle: qsTr("FreeJeweled")
                gameBoardScore: gameBoard.score
                gameBoardLevel: gameBoard.level
                state: gameBoard.scoreBoxState
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
        // ----- Property Declarations
        // Required properties should be at the top.
        // ----- Signal declarations
        // ----- In this section, we group the size and position information together.
        anchors.fill: parent
        // If a single assignment, dot notation can be used.
        // ----- Then comes the other properties. There's no predefined order to these.
        // ----- Then attached properties and attached signal handlers.
        // ----- States and transitions.
        // ----- Signal handlers
        // ----- Visual children.

        //state: "stateMainMenu"
        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            anchors.leftMargin: 2 * DevicePixelRatio
            anchors.rightMargin: 2 * DevicePixelRatio

            spacing: 2 * DevicePixelRatio

            JProgressBar {
                id: pbLevelProgress
                Layout.fillWidth: true
                Layout.preferredHeight: 25 * DevicePixelRatio
                visible: true //screen.state == "stateGame"
                value: gameBoard.levelCap
                color: "white"
                secondColor: "green"
            }

            GameBoard {
                id: gameBoard
                Layout.fillWidth: true
                Layout.preferredHeight: 320 * DevicePixelRatio
            }
            QQC2.Frame {
                id: spacerFrame_3
                visible: true
                Layout.fillWidth: true
                Layout.preferredHeight: 2 * DevicePixelRatio
            }
            RowLayout {
                id: toolBarLayout
                Layout.fillWidth: true
                Layout.preferredHeight: 20 * DevicePixelRatio
                spacing: 10 * DevicePixelRatio
                Item {
                    Layout.fillWidth: true
                }
                BaseButton {
                    id: btnRemoveAll
                    text: qsTr("Run")
                    font {
                        family: global.fonts.buttonfont
                        pointSize: global.smallFontSize
                    }
                    onClicked: {
                        ///TODO need change state  screen item
                        gameBoard.state = "newGame"
                        //gameBoard.removeAll()
                    }
                }
                BaseButton {
                    id: btnReset
                    text: qsTr("Reset")
                    font {
                        family: global.fonts.buttonfont
                        pointSize: global.smallFontSize
                    }
                    onClicked: {

                        //gameBoard.resetBoard()
                    }
                }
                BaseButton {
                    id: btnShowHint
                    text: qsTr("Hint")
                    font {
                        family: global.fonts.buttonfont
                        pointSize: global.smallFontSize
                    }
                    onClicked: {

                        // gameBoard.showHint()
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
            }

            Component.onCompleted: {
                if (isDebugMode)
                    console.log("mainLayout.size:[" + mainLayout.width / 1.5
                                + "," + mainLayout.height / 1.5 + "]")
            }
        }
        // ----- Qt provided non-visual children
        // ----- Custom non-visual children
        // ----- JavaScript functions
    }
    AboutDialog {
        id: dlgAbout
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
    FontLoader {
        id: gameFont
        source: "qrc:/res/fonts/mailrays.ttf"
    }

    FontLoader {
        id: buttonFont
        source: "qrc:/res/fonts/pirulen.ttf"
    }

    FontLoader {
        id: aboutFont
        source: "qrc:/res/fonts/forgotte.ttf"
    }

    GemItemsModel {
        id: gemItemsModel
    }

    // ----- Custom non-visual children

    // a globally avalable utility object
    QtObject {
        id: global

        readonly property real winScale: Math.min(width / 1280.0,
                                                  height / 720.0)

        readonly property int largeFontSize: 36
        readonly property int middleFontSize: 24
        readonly property int smallFontSize: 12

        property QtObject fonts: QtObject {
            readonly property string gamefont: gameFont.name
            readonly property string buttonfont: buttonFont.name
            readonly property string aboutfont: aboutFont.name
        }
        readonly property int smallCellSize: 40
        readonly property int bigSellSize: 80
        readonly property int defaultRowCount: 8
        readonly property int defaultColumnCount: 8

        /* This is msecs. Half of second is enough for smooth animation. */
        readonly property int timerIterval: 500
        readonly property int enoughTimeToDie: 1000 // достаточноеВремяДляСмерти

        readonly property int animationStopTreshhold: 3
        readonly property int levelCapMultiplayer: 60

        readonly property int huperCubeMultiplayer: 2
        readonly property double difficultyMultiplayer: 1.07
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
