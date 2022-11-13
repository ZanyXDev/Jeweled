import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import Components 1.0
import Common 1.0
import Theme 1.0

Item {
    id: control

    // ----- Property Declarations

    // Required properties should be at the top.
    property int hintX: 0
    property int hintY: 0
    property int level: 0
    property int score: 0
    property int selGemRow: 0 //READ selGemRow WRITE setSelGemRow NOTIFY selGemRowChanged)
    property int selGemColumn: 0 //READ selGemColumn WRITE setSelGemColumn NOTIFY selGemColumnChanged)
    property int m_currentStepDelay: 0
    property real levelCap: 0.0
    property bool hintVisible: false
    property bool gemSelected: false
    property bool gameLost: false
    property bool gameStarted: false

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
                target: control
                score: 0
            }
            PropertyChanges {
                target: control
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
                script: doFillBgrCells()
            }
            ScriptAction {
                script: calcLevelCap()
            }

            ScriptAction {
                script: oneSecondTimer.start()
            }
        }
    ]

    // ----- Signal handlers
    onScoreChanged: {

    }
    onLevelCapChanged: {

        ///TODO levelCap == 1.0 -> signal levelUp()!!!
    }

    // onCompleted and onDestruction signal handlers are always the last in
    // the order.
    Component.onCompleted: {

    }
    Component.onDestruction: {

    }
    // ----- Visual children.
    Rectangle {
        id: bgrRect
        anchors.fill: parent
        radius: 4 * DevicePixelRatio
        color: "transparent"
        z: -1
        opacity: 0
        visible: opacity > 0
        border.color: Theme.accent
        border.width: 1 * DevicePixelRatio

        Repeater {
            id: repeaterItem
            model: bgrItemsModel
            BgrItem {
                readonly property int idx: model.index
                x: model.x
                y: model.y
                visible: model.visible
                width: global.smallCellSize
                height: global.smallCellSize
                animationTime: global.timerInterval
            }
        }
        Behavior on opacity {
            NumberAnimation {
                duration: global.timerInterval
                easing.type: Easing.InQuad
            }
        }
    }

    // ----- Qt provided non-visual children
    ListModel {
        id: bgrItemsModel
        Component.onCompleted: {
            fillBackgroundModel(bgrItemsModel)
        }
    }
    ListModel {
        id: gemsModel
        Component.onCompleted: {
            createEmptyGems(gemsModel)
        }
    }
    // ----- Custom non-visual children
    Timer {
        id: oneSecondTimer
        interval: 1000
        repeat: true
        running: false
        onTriggered: control.score++
        //control.score = Qt.binding(function () {  return 77     })
    }

    // ----- JavaScript functions
    function newGame() {
        state = "newGame"
    }

    function fillBackgroundModel(m_model) {
        // All item placed left corner
        var cnt = (control.colums * control.rows)
        for (var x = 0; x < cnt; x++) {
            m_model.append({
                               "x": -100,
                               "y": -100,
                               "visible": false
                           })
        }
    }

    function doFillBgrCells() {
        console.log("doFillBgrCells()")
        var cnt = (control.colums * control.rows)
        for (var index = 0; index < cnt; index++) {
            bgrItemsModel.setProperty(index, "x", getXFromIndex(index))
            bgrItemsModel.setProperty(index, "y", getYFromIndex(index))
            bgrItemsModel.setProperty(index, "visible", true)
        }
    }

    function createEmptyGems(m_model) {
        var cnt = (control.colums * control.rows)
        for (var x = 0; x < cnt; x++) {
            m_model.append({
                               "type": generateCellType(),
                               "width": control.cellSize,
                               "height": control.cellSize,
                               "x"// "startRow": startRow,
                               // "behaviorPause": Math.abs(
                               //                      startRow) * 50 + control.m_currentStepDelay,
                               : -100,
                               "y": -100,
                               "spawned": true,
                               "srcSize": control.cellSize,
                               "modifier": Modifier.CellState.Normal
                           })
        }
    }


    /**
      * @brief Resets board for new level.
      * Saves gem modifiers and restores it after new board is created.
      * Also  checks for combos in newly created board and changes
      * gem types so there are no combos
      */
    function resetBoard() {}
    // -------------------Utility function to use in different places. --------

    // Generate random cell type.
    function generateCellType() {
        return Math.floor(Math.random() * 7.0)
    }

    function getXFromIndex(index) {
        if (index < 0) {
            return -1
        }
        var m_col = index % 8
        var x = m_col * (control.cellSize + 3 * DevicePixelRatio)
        x += 2 * DevicePixelRatio
        return x
    }

    function getYFromIndex(index) {
        if (index < 0) {
            return -1
        }
        var m_col = index % 8
        var m_row = (index > 7) ? ((index - m_col) / 8) : 0
        var y = m_row * (control.cellSize + 3 * DevicePixelRatio)

        y += 2 * DevicePixelRatio
        return y
    }

    function calcLevelCap() {
        var max_cap = (5 * level * (level + 3) / 2 * global.levelCapMultiplayer * Math.pow(
                           global.difficultyMultiplayer, level - 1))
        levelCap = score / max_cap
    }
}
