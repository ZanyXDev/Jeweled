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

QQC2.ApplicationWindow {
    id: appWnd
    // ----- Property Declarations
    property bool isMoreMenuNeed: true

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

    // ----- Visual children
    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: bgrMainMenu
        anchors.fill: parent
        source: "qrc:/res/images/backgrounds/bgr00.jpg"
    }

    AboutDialog {
        id: dlgAbout
        visible: opacity > 0
        opacity: 0.0
        MouseArea {
            anchors.fill: parent
            onClicked: screen.state = "stateSettings"
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
    }

    Rectangle {
        id: screen
        // ----- Property Declarations
        // Required properties should be at the top.
        property int cellSize: 80
        // ----- Signal declarations

        // ----- In this section, we group the size and position information together.
        width: 8 * cellSize
        height: 12 * cellSize
        visible: true
        // ----- Then comes the other properties. There's no predefined order to these.

        // Do not use empty lines to separate the assignments. Empty lines are reserved
        // for separating type declarations.
        z: -10
        // ----- Then attached properties and attached signal handlers.

        // ----- States and transitions.
        state: "stateMainMenu"

        //    states: [
        //        State {
        //            name: "stateMainMenu"
        //            /* Main menu elements anchors */
        //            AnchorChanges {
        //                target: gameTitle
        //                anchors.top: screen.top
        //            }
        //            AnchorChanges {
        //                target: btnClassic
        //                anchors.horizontalCenter: screen.horizontalCenter
        //            }
        //            AnchorChanges {
        //                target: btnEndless
        //                anchors.horizontalCenter: screen.horizontalCenter
        //            }
        //            AnchorChanges {
        //                target: btnAction
        //                anchors.horizontalCenter: screen.horizontalCenter
        //            }
        //            AnchorChanges {
        //                target: btnAbout
        //                anchors.horizontalCenter: screen.horizontalCenter
        //            }

        //            /* Game elements anchors */
        //            AnchorChanges {
        //                target: toolBar
        //                anchors.top: screen.bottom
        //            }
        //            AnchorChanges {
        //                target: gameBoard
        //                anchors.left: screen.right
        //            }
        //        },
        //        State {
        //            name: "stateGame"
        //            /* Main menu elements anchors */
        //            AnchorChanges {
        //                target: gameTitle
        //                anchors.bottom: screen.top
        //            }
        //            AnchorChanges {
        //                target: btnClassic
        //                anchors.right: screen.left
        //            }
        //            AnchorChanges {
        //                target: btnEndless
        //                anchors.left: screen.right
        //            }
        //            AnchorChanges {
        //                target: btnAction
        //                anchors.right: screen.left
        //            }
        //            AnchorChanges {
        //                target: btnAbout
        //                anchors.left: screen.right
        //            }

        //            /* Game elements anchors */
        //            AnchorChanges {
        //                target: toolBar
        //                anchors.top: pbLevelProgress.bottom
        //            }
        //            AnchorChanges {
        //                target: gameBoard
        //                anchors.left: screen.left
        //            }
        //        },
        //        State {
        //            name: "stateSettings"
        //            /* Main menu elements anchors */
        //            AnchorChanges {
        //                target: gameTitle
        //                anchors.bottom: screen.top
        //            }
        //            AnchorChanges {
        //                target: btnClassic
        //                anchors.right: screen.left
        //            }
        //            AnchorChanges {
        //                target: btnEndless
        //                anchors.left: screen.right
        //            }
        //            AnchorChanges {
        //                target: btnAction
        //                anchors.right: screen.left
        //            }
        //            AnchorChanges {
        //                target: btnAbout
        //                anchors.left: screen.right
        //            }

        //            /* Game elements anchors */
        //            AnchorChanges {
        //                target: toolBar
        //                anchors.top: screen.bottom
        //            }

        //            /* Showing Settings and hiding About dialog */
        //            PropertyChanges {
        //                target: dlgSettings
        //                opacity: 1.0
        //            }
        //            PropertyChanges {
        //                target: dlgAbout
        //                opacity: 0.0
        //            }
        //        },
        //        State {
        //            name: "stateAbout"
        //            /* Showing About and hiding Settings dialogs */
        //            PropertyChanges {
        //                target: dlgSettings
        //                opacity: 0.0
        //            }
        //            PropertyChanges {
        //                target: dlgAbout
        //                opacity: 1.0
        //            }

        //            /* Showing info about app version */
        //            PropertyChanges {
        //                target: txtAppVersion
        //                opacity: 1.0
        //            }

        //            /* Game elements anchors */
        //            AnchorChanges {
        //                target: toolBar
        //                anchors.top: screen.bottom
        //            }
        //        }
        //    ]

        //    transitions: [
        //        Transition {
        //            from: "stateMainMenu"
        //            to: "stateGame"
        //            SequentialAnimation {
        //                AnchorAnimation {
        //                    targets: [gameTitle, btnClassic, btnEndless, btnAction, btnAbout]
        //                    duration: 500
        //                    easing.type: Easing.InOutQuad
        //                }

        //                ScriptAction {
        //                    script: {
        //                        setBackgroundSource()
        //                        if (gameBoard.hasSave()) {
        //                            dlgLoadSave.show()
        //                        } else {
        //                            gameBoard.newGame()
        //                        }
        //                    }
        //                }

        //                ScriptAction {
        //                    script: txtAppVersion.opacity = 0.0
        //                }
        //                PropertyAction {
        //                    target: bgrMainMenu
        //                    property: "visible"
        //                    value: false
        //                }
        //                PropertyAction {
        //                    target: gameBoard
        //                    property: "opacity"
        //                    value: 1.0
        //                }
        //                AnchorAnimation {
        //                    duration: 500
        //                    targets: gameBoard
        //                }

        //                ParallelAnimation {
        //                    PropertyAction {
        //                        target: scoreBox
        //                        property: "state"
        //                        value: "stateNormal"
        //                    }
        //                    AnchorAnimation {
        //                        targets: toolBar
        //                        duration: 200
        //                    }
        //                }
        //            }
        //        },
        //        Transition {
        //            from: "stateMainMenu"
        //            to: "stateSettings"
        //            AnchorAnimation {
        //                duration: 500
        //                easing.type: Easing.InOutQuad
        //            }
        //            PropertyAction {
        //                target: scoreBox
        //                property: "state"
        //                value: "stateHidden"
        //            }
        //            ScriptAction {
        //                script: txtAppVersion.opacity = 0.0
        //            }
        //        },
        //        Transition {
        //            from: "stateSettings"
        //            to: "stateMainMenu"
        //            SequentialAnimation {
        //                ScriptAction {
        //                    script: dlgSettings.opacity = 0.0
        //                }
        //                ScriptAction {
        //                    script: txtAppVersion.opacity = 1.0
        //                }
        //                AnchorAnimation {
        //                    duration: 500
        //                    easing.type: Easing.InOutQuad
        //                }
        //            }
        //        },
        //        Transition {
        //            from: "stateGame"
        //            to: "stateMainMenu"
        //            SequentialAnimation {
        //                ScriptAction {
        //                    script: {
        //                        if (!gameBoard.gameLost)
        //                            gameBoard.saveBoardStateToFile()
        //                    }
        //                }
        //                ScriptAction {
        //                    script: txtAppVersion.opacity = 1.0
        //                }
        //                PropertyAction {
        //                    target: gameBoard
        //                    property: "opacity"
        //                    value: 0.0
        //                }
        //                PropertyAction {
        //                    target: scoreBox
        //                    property: "state"
        //                    value: "stateHidden"
        //                }
        //                AnchorAnimation {
        //                    targets: toolBar
        //                    duration: 400
        //                }
        //                PropertyAction {
        //                    target: bgrMainMenu
        //                    property: "visible"
        //                    value: true
        //                }
        //                AnchorAnimation {
        //                    targets: [gameTitle, btnClassic, btnEndless, btnAction, btnAbout]
        //                    duration: 500
        //                    easing.type: Easing.InOutQuad
        //                }
        //                //                ScriptAction {
        //                //                    script: {
        //                //                        gameBoard.clearBoard();
        //                //                        pbLevelProgress.minimum = 0;
        //                //                        pbLevelProgress.maximum = gameBoard.levelCap(1);
        //                //                    }
        //                //                }
        //            }
        //        }
        //    ]

        //    // ----- Signal handlers
        // Always use curly braces.

        // onCompleted and onDestruction signal handlers are always the last in
        // the order.
        Component.onCompleted: {

        }
        Component.onDestruction: {

        }

        // ----- Visual children.

        // ----- Qt provided non-visual children
        SystemPalette {
            id: activePalette
        }

        //    SettingsDialog {
        //        id: dlgSettings
        //        visible: opacity > 0
        //        opacity: 0.0
        //        canIncreaseSize: gameBoard.cellSize < 80
        //        canDecreaseSize: gameBoard.cellSize > 40
        //        Behavior on opacity {
        //            NumberAnimation {
        //                duration: 500
        //            }
        //        }
        //        onSizeDecrease: gameBoard.cellSize -= 10
        //        onSizeIncrease: gameBoard.cellSize += 10
        //        onBackPressed: screen.state = "stateMainMenu"
        //        onAboutPressed: screen.state = "stateAbout"
        //    }
        //    Rectangle {
        //        id: topGameBoardBorder
        //        visible: screen.state == "stateGame"
        //        color: "white"
        //        opacity: 0.5
        //        anchors.top: scoreBox.bottom
        //        height: 5 * DevicePixelRatio
        //        width: parent.width
        //    }

        //    Rectangle {
        //        id: bottomGameBoardBorder
        //        visible: screen.state == "stateGame"
        //        color: "white"
        //        opacity: 0.5
        //        anchors.top: gameBoard.bottom
        //        height: 5 * DevicePixelRatio
        //        width: parent.width
        //    }

        //    GameBoard {
        //        id: gameBoard
        //        width: 8 * gameBoard.cellSize
        //        height: 8 * gameBoard.cellSize
        //        anchors.top: topGameBoardBorder.bottom
        //        visible: opacity > 0
        //        opacity: 0
        //        property int hintX: 0
        //        property int hintY: 0
        //        property bool hintVisible: false

        //        MouseArea {
        //            anchors.fill: parent
        //            onClicked: gameBoard.handleClick(mouse.x, mouse.y)
        //        }

        //        Image {
        //            id: gbBackground
        //            source: ":/pics/field.svg"
        //            anchors.fill: parent
        //            sourceSize.width: gbBackground.width
        //            sourceSize.height: gbBackground.height
        //        }

        //        Item {
        //            id: selectionRect
        //            width: gameBoard.cellSize
        //            height: gameBoard.cellSize
        //            visible: gameBoard.gemSelected
        //            x: gameBoard.selGemColumn * width
        //            y: gameBoard.selGemRow * width

        //            Image {
        //                anchors.fill: parent
        //                source: ":/pics/selectionBorder.png"
        //                opacity: 0.8
        //                fillMode: Image.PreserveAspectCrop
        //            }
        //        }

        //        Image {
        //            id: hintImage
        //            source: ":/pics/hintArrow.svg"
        //            x: gameBoard.hintX
        //            y: gameBoard.hintY - height / 4
        //            width: gameBoard.cellSize
        //            height: gameBoard.cellSize / 2
        //            sourceSize.width: width
        //            sourceSize.height: height

        //            visible: gameBoard.hintVisible
        //            z: 5
        //            ParallelAnimation {
        //                running: hintImage.visible
        //                SequentialAnimation {
        //                    loops: Animation.Infinite
        //                    PropertyAnimation {
        //                        target: hintImage
        //                        property: "y"
        //                        to: gameBoard.hintY - 3 * hintImage.height / 4
        //                        duration: 300
        //                        easing.type: Easing.InOutQuad
        //                    }
        //                    PropertyAnimation {
        //                        target: hintImage
        //                        property: "y"
        //                        to: gameBoard.hintY - hintImage.height / 4
        //                        duration: 300
        //                        easing.type: Easing.InOutQuad
        //                    }
        //                }
        //                SequentialAnimation {
        //                    PauseAnimation {
        //                        duration: 3000
        //                    }
        //                    ScriptAction {
        //                        script: gameBoard.hintVisible = false
        //                    }
        //                }
        //            }
        //        }

        //        onLevelUp: levelUpAnimation.start()

        //        onNoMoreMoves: {
        //            msgText.text = "NO MORE MOVES"
        //            msgText.font.pointSize = 30 * DevicePixelRatio
        //            msgText.show()
        //            dlgEndGame.show()
        //        }
        //    }
        SequentialAnimation {
            id: levelUpAnimation
            ScriptAction {
                script: {
                    msgText.text = "LEVEL UP!"
                    msgText.font.pointSize = 38 * DevicePixelRatio
                    msgText.show()
                    gameBoard.dropGemsDown()
                }
            }
            PauseAnimation {
                duration: 3000
            }
            ScriptAction {
                script: {
                    msgText.text = "LEVEL " + gameBoard.level
                    msgText.font.pointSize = 38 * DevicePixelRatio
                    msgText.show()
                    pbLevelProgress.minimum = gameBoard.levelCap(
                                gameBoard.level - 1)
                    pbLevelProgress.maximum = gameBoard.levelCap(
                                gameBoard.level)
                    setBackgroundSource()
                    gameBoard.resetBoard()
                }
            }
        }

        //    EndOfGameDialog {
        //        id: dlgEndGame
        //        anchors.centerIn: gameBoard
        //        z: 10
        //        onClosed: screen.state = "stateMainMenu"
        //    }

        //    LoadSavedGameDialog {
        //        id: dlgLoadSave
        //        anchors.centerIn: screen
        //        z: 10
        //        onCancel: screen.state = "stateMainMenu"
        //        onLoadSaved: {
        //            gameBoard.loadBoardStateFromFile()
        //            pbLevelProgress.minimum = gameBoard.levelCap(gameBoard.level - 1)
        //            pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level)
        //        }
        //        onNewGame: gameBoard.newGame()
        //    }

        //    ProgressBar {
        //        id: pbLevelProgress
        //        visible: screen.state == "stateGame"
        //        anchors.horizontalCenter: screen.horizontalCenter
        //        anchors.top: bottomGameBoardBorder.bottom
        //        color: "white"
        //        secondColor: "green"
        //        height: 20 * DevicePixelRatio
        //        maximum: gameBoard.levelCap(gameBoard.level)
        //        value: gameBoard.score
        //    }

        //    Item {
        //        id: scoreBox

        //        width: parent.width
        //        height: 60 * DevicePixelRatio /* cellSize*1.5, actually */
        //        state: "stateHidden"

        //        anchors.top: parent.top

        //        Text {
        //            id: txtScore
        //            color: "white"
        //            font.family: gameFont.name
        //            font.pointSize: 16 * DevicePixelRatio
        //            font.bold: true
        //            text: gameBoard.score
        //            anchors.bottom: parent.bottom
        //            anchors.leftMargin: 10 * DevicePixelRatio
        //            anchors.bottomMargin: 5 * DevicePixelRatio
        //        }

        //        Text {
        //            id: txtLevel
        //            color: "white"
        //            font.family: gameFont.name
        //            font.pointSize: 16 * DevicePixelRatio
        //            font.bold: true
        //            text: "Level " + gameBoard.level + " "
        //            anchors.bottom: parent.bottom
        //            anchors.rightMargin: 10 * DevicePixelRatio
        //            anchors.bottomMargin: 5 * DevicePixelRatio
        //        }

        //        states: [
        //            State {
        //                name: "stateNormal"
        //                AnchorChanges {
        //                    target: txtScore
        //                    anchors.left: scoreBox.left
        //                }
        //                AnchorChanges {
        //                    target: txtLevel
        //                    anchors.right: scoreBox.right
        //                }
        //            },
        //            State {
        //                name: "stateHidden"
        //                AnchorChanges {
        //                    target: txtScore
        //                    anchors.right: scoreBox.left
        //                }
        //                AnchorChanges {
        //                    target: txtLevel
        //                    anchors.left: scoreBox.right
        //                }
        //            }
        //        ]

        //        transitions: [
        //            Transition {
        //                from: "stateHidden"
        //                to: "stateNormal"
        //                AnchorAnimation {
        //                    duration: 200
        //                    easing.type: Easing.Linear
        //                }
        //            },
        //            Transition {
        //                from: "stateNormal"
        //                to: "stateHidden"
        //                AnchorAnimation {
        //                    duration: 200
        //                    easing.type: Easing.Linear
        //                }
        //            }
        //        ]
        //    }

        //    MsgText {
        //        id: msgText
        //    }

        //    Item {
        //        id: toolBar
        //        width: parent.width
        //        height: parent.height - scoreBox.height - topGameBoardBorder.height
        //                - gameBoard.height - bottomGameBoardBorder.height - pbLevelProgress.height
        //        anchors.top: pbLevelProgress.bottom
        //        visible: opacity > 0

        //        InGameButton {
        //            id: btnReset
        //            anchors.top: parent.top
        //            anchors.left: parent.left
        //            color: "red"
        //            caption: "Reset"

        //            onClicked: gameBoard.resetBoard()
        //        }

        //        InGameButton {
        //            id: btnRemoveAll
        //            anchors.top: parent.top
        //            anchors.left: btnReset.right
        //            caption: "Run"
        //            color: "steelblue"

        //            onClicked: gameBoard.removeAll()
        //        }

        //        InGameButton {
        //            id: btnLevelUp
        //            anchors.top: parent.top
        //            anchors.left: btnRemoveAll.right
        //            caption: "LevelUp"
        //            color: "blue"

        //            onClicked: {
        //                gameBoard.score = gameBoard.levelCap(gameBoard.level)
        //                gameBoard.removeAll()
        //            }
        //        }

        //        /* Second row of buttons */
        //        InGameButton {
        //            id: btnLoadTest
        //            anchors.bottom: parent.bottom
        //            anchors.left: parent.left
        //            caption: "Test"
        //            color: "royalblue"

        //            onClicked: gameBoard.loadTestBoard()
        //        }

        //        InGameButton {
        //            id: btnShowHint
        //            anchors.bottom: parent.bottom
        //            anchors.left: btnLoadTest.right
        //            caption: "Hint"
        //            color: "green"

        //            onClicked: gameBoard.showHint()
        //        }

        //        InGameButton {
        //            id: btnMenu
        //            anchors.bottom: parent.bottom
        //            anchors.left: btnShowHint.right
        //            caption: "Menu"
        //            color: "red"

        //            onClicked: screen.state = "stateMainMenu"
        //        }
        //    }

        //    Image {
        //        id: gameTitle
        //        anchors.topMargin: 30 * DevicePixelRatio
        //        anchors.horizontalCenter: parent.horizontalCenter
        //        width: parent.width * 0.9
        //        height: 126. / 346. * width
        //        source: ":/pics/titleText.svg"
        //        sourceSize {
        //            width: gameTitle.width
        //            height: gameTitle.height
        //        }

        //        Image {
        //            anchors.centerIn: parent
        //            width: 50 * DevicePixelRatio
        //            height: 50 * DevicePixelRatio
        //            sourceSize.width: width
        //            sourceSize.height: height
        //            visible: gameTitle.y > 0
        //            source: ":/pics/gems/orangeGem.svg"
        //            Shine {
        //                anchors {
        //                    leftMargin: 10 * DevicePixelRatio
        //                    topMargin: 10 * DevicePixelRatio
        //                }
        //            }
        //        }
        //    }

        //    MainMenuButton {
        //        id: btnClassic
        //        caption: "CLASSIC"
        //        anchors.top: screen.top
        //        anchors.margins: gameTitle.height + gameTitle.anchors.topMargin + 40 * DevicePixelRatio
        //        color: "steelblue"
        //        onClicked: screen.state = "stateGame"
        //    }

        //    MainMenuButton {
        //        id: btnEndless
        //        enabled: false
        //        caption: "ENDLESS"
        //        anchors.top: btnClassic.bottom
        //        anchors.margins: 10 * DevicePixelRatio
        //        color: "gray"
        //    }

        //    MainMenuButton {
        //        id: btnAction
        //        enabled: false
        //        caption: "Action"
        //        anchors.top: btnEndless.bottom
        //        anchors.margins: 10 * DevicePixelRatio
        //        color: "gray"
        //    }

        //    MainMenuButton {
        //        id: btnAbout
        //        caption: "settings"
        //        anchors.top: btnAction.bottom
        //        anchors.margins: 10 * DevicePixelRatio
        //        color: "steelblue"
        //        onClicked: screen.state = "stateSettings"
        //    }
    }

    Text {
        id: txtAppVersion
        text: g_appVersion
        font.pointSize: 14 * DevicePixelRatio
        font.family: buttonFont.name
        color: "lightgray"
        visible: opacity > 0
        anchors {
            bottom: screen.bottom
            right: screen.right
            margins: 3 * DevicePixelRatio
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
    }
    // ----- Qt provided non-visual children
    QQC2.Action {
        id: optionsMenuAction
        //text: qsTr("&Options...")
        //icon.name: "menu"
        onTriggered: {
            //optionsMenu.open()
            if (isDebugMode)
                console.log("optionsMenuAction click")
            Qt.quit()
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
