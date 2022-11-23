import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import Components 1.0
import Common 1.0
import Theme 1.0
import "qrc:/res/js/util.js" as Utils
import "qrc:/res/js/game_logic.js" as Logic

Item {
    id: root

    // ----- Property Declarations

    // Required properties should be at the top.
    property int hintX: 0
    property int hintY: 0
    property int level: 0
    property int score: 0
    property int m_selGemRow: 0 //READ selGemRow WRITE setSelGemRow NOTIFY selGemRowChanged)
    property int m_selGemColumn: 0 //READ selGemColumn WRITE setSelGemColumn NOTIFY selGemColumnChanged)
    property int m_currentStepDelay: 0
    property real levelCap: 0.0
    property bool hintVisible: false
    property bool m_gemSelected: false
    property bool m_gameLost: false
    property bool m_gameStarted: false
    property bool m_gemMovedByUser: false
    property bool m_userInteractionAccepted: false

    //    property ListModel modelBgr: ListModel {}
    //    property ListModel modelGem: ListModel {}

    // ----- Signal declarations
    // ----- In this section, we group the size and position information together.
    // If the item is an image, sourceSize is also set here.
    // sourceSize: Qt.size(12, 12)
    // ----- Then comes the other properties. There's no predefined order to these.
    // Do not use empty lines to separate the assignments. Empty lines are reserved
    // for separating type declarations.
    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    states: [
        State {
            name: "newGame"
            PropertyChanges {
                target: root
                score: 0
            }
            PropertyChanges {
                target: root
                level: 1
            }
            PropertyChanges {
                target: bgrRect
                opacity: 1.0
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "newGame"

            ScriptAction {
                script: Utils.moveBackgroundTile(bgrModel)
            }
            ScriptAction {
                script: calcLevelCap()
            }

            ScriptAction {
                script: oneHalfSecondTimer.start()
            }
        }
    ]

    // ----- Signal handlers
    onScoreChanged: {

    } // ----- Property Declarations
    // Required properties should be at the top.
    property point originPosition: mapToItem(parent, 0, 0)
    onLevelCapChanged: {

        ///TODO levelCap == 1.0 -> signal levelUp()!!!
    }

    // onCompleted and onDestruction signal handlers are always the last in
    // the order.
    Component.onCompleted: {
        root.level = 1
        root.score = 0

        //m_selectedGem = NULL
        m_gemSelected = false
        m_selGemRow = 0
        m_selGemColumn = 0
        m_gemMovedByUser = false
        m_userInteractionAccepted = true
        m_gameStarted = false
        m_gameLost = false
        // m_cellSize = SMALL_CELL_SIZE
    }

    Component.onDestruction: {

    }

    // ----- Visual children.
    Rectangle {
        id: bgrRect
        objectName: "bgrRect"
        anchors.fill: parent
        radius: 4 * DevicePixelRatio
        color: "transparent"
        z: -1
        opacity: 0
        visible: (opacity > 0) && (isDebugMode)
        border.color: Theme.accent
        border.width: 1 * DevicePixelRatio

        Repeater {

            id: bgrRepeater
            model: bgrModel
            BgrItem {
                readonly property int index: model.index
                x: model.x
                y: model.y
                height: model.m_size
                width: model.m_size
            }
        }

        Repeater {
            id: gemRepeater
            model: gemsModel
            delegate: GemItem {
                readonly property int index: model.index
                id: index
                type: model.type
                spawned: model.spawned
                gmodifier: model.gmodifier
                srcSize: model.srcSize
                behaviorPause:model.behaviorPause

            }
        }
    }

    // ----- Qt provided non-visual children
    ListModel {
        id: gemsModel

        Component.onCompleted: {
            Utils.fillGemsModel(gemsModel, global.cellCount,
                                global.smallCellSize)
        }
    }

    ListModel {
        id: bgrModel
        Component.onCompleted: {
            Utils.fillBgrModel(bgrModel, global.cellCount,
                               global.smallCellSize, DevicePixelRatio)
        }
    }

    // ----- Custom non-visual children
    Timer {
        id: oneHalfSecondTimer
        interval: 500
        repeat: true
        running: false
        onTriggered: root.score++
        //root.score = Qt.binding(function () {  return 77     })
    }

    // ----- JavaScript functions
    function newGame() {
        state = "newGame"
        console.log("newGame()")
    }


    /**
      * @brief Resets board for new level.
      * Saves gem modifiers and restores it after new board is created.
      * Also  checks for combos in newly created board and changes
      * gem types so there are no combos
      */
    function resetBoard() {}

    // -------------------Utility function to use in different places. --------
    function calcLevelCap() {
        var max_cap = (5 * level * (level + 3) / 2 * global.levelCapMultiplayer * Math.pow(
                           global.difficultyMultiplayer, level - 1))
        levelCap = score / max_cap
    }
}
