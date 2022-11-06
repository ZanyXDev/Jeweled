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

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio
        QQC2.Frame {
            id: spacerFrame
            visible: true
            Layout.fillWidth: true
            Layout.preferredHeight: 2 * DevicePixelRatio
        }

        GameBoard {
            id: gameBoard
            Layout.fillWidth: true
            Layout.preferredHeight: 320 * DevicePixelRatio
        }

        Item {
            id: debugRect
            Layout.fillWidth: true
            Layout.preferredHeight: 48 * DevicePixelRatio

            RowLayout {
                id: testButton
                anchors.fill: parent
                spacing: 8 * DevicePixelRatio
                Item {
                    Layout.fillHeight: true
                }
                QQC2.Button {
                    id: tstButton1
                    text: "stateShowLevel"
                    onClicked: {
                        scorebox.state = "stateShowLevel"
                    }
                }

                QQC2.Button {
                    id: tstButton2
                    text: "stateShowScore"
                    onClicked: {
                        scorebox.state = "stateShowScore"
                    }
                }
                QQC2.Button {
                    id: tstButton3
                    text: "showAbout"
                    onClicked: {
                        dlgAbout.open()
                    }
                }
                QQC2.Button {
                    id: tstButton4
                    text: "moveGem"
                    onClicked: {
                        gameBoard.state = "beginRound"
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }
        }

        Component.onCompleted: {
            if (isDebugMode)
                console.log("mainLayout.size:[" + mainLayout.width / 1.5 + ","
                            + mainLayout.height / 1.5 + "]")
        }
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
        readonly property int smallFontSize: 16

        property QtObject fonts: QtObject {
            readonly property string gamefont: gameFont.name
            readonly property string buttonfont: buttonFont.name
            readonly property string aboutfont: aboutFont.name
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

    function logRepeaterItems(repeaterItem) {
        var new_place = Math.floor(Math.random() * 63 + 1)
        testGem_1.parent = repeaterItem.itemAt(new_place)

        //        for (var i = 0; i < repeaterItem.count; i++) {
        //        console.log("repeaterItem:" + 5 + " Properties\n")
        //        var item = repeaterItem.itemAt(i)
        //        for (var p in item)
        //            console.log(p + ": " + item[p] + "\n")
        //        }
    }

    function updatePos(item_orig, item_dest) {
        var pos_abs = appWnd.mapFromItem(item_orig.parent, item_orig.x,
                                         item_orig.y)
        if (isDebugMode)
            console.log("updatePos() pos_abs:" + pos_abs)
        return appWnd.mapToItem(item_dest.parent, pos_abs.x, pos_abs.y)
    }

    function debugPos(item, dp) {
        console.log("---------- Item pos -------------")
        console.log("Item parent:" + item.parent)
        console.log("Item index:" + item.r_index)

        console.log("size:[" + item.width / dp + "," + item.height / dp + "]")
        console.log("pos:[" + item.x + "," + item.y + "]")
        console.log("mapToItem abs_pos:", item.mapToItem(item.parent, 0, 0))
        console.log("mapFromItem abs_pos:", item.mapFromItem(item.parent, 0, 0))
        console.log("mapToGlobal pos: " + item.mapToGlobal(0, 0))
    }
}
