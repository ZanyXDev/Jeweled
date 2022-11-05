import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

Item {
    id: control

    property int hintX: 0
    property int hintY: 0
    property int level: 1 //READ level WRITE setLevel NOTIFY levelChanged)
    property int score: 0 //READ score WRITE setScore NOTIFY scoreChanged)
    property int selGemRow: 0 //READ selGemRow WRITE setSelGemRow NOTIFY selGemRowChanged)
    property int selGemColumn: 0 //READ selGemColumn WRITE setSelGemColumn NOTIFY selGemColumnChanged)
    property int cellSize: 37 * DevicePixelRatio
    property int colums: 8
    property int rows: 8
    property int nextBgrItem: -1

    property bool gemSelected: false //READ gemSelected WRITE setGemSelected NOTIFY gemSelectedChanged)
    property bool gameLost: false //READ gameLost)
    property bool hintVisible: false
    property bool startNewGame: false

    Rectangle {
        id: bgrRect
        anchors.fill: parent
        radius: 4 * DevicePixelRatio
        color: "transparent"
        z: -1

        Repeater {
            id: repeaterItem
            model: bgrItemsModel
            Image {
                //TODO Move to separeted file
                id: bgrImg
                readonly property int idx: model.index
                x: model.x
                y: model.y
                visible: model.visible
                width: control.cellSize
                height: control.cellSize
                source: "qrc:/res/images/tile_background.png"
                sourceSize.width: control.cellSize
                sourceSize.height: control.cellSize
                fillMode: Image.PreserveAspectFit

                Behavior on x {
                    enabled: true
                    PropertyAnimation {
                        easing.type: Easing.OutBack
                        duration: 150
                    }
                }
                Behavior on y {
                    enabled: true
                    PropertyAnimation {
                        easing.type: Easing.OutBack
                        duration: 150
                    }
                }

                opacity: 0.55
            }
        }
    }

    onStartNewGameChanged: {
        if (isDebugMode)
            console.log("startNewGame:" + startNewGame)
        if (startNewGame) {
            startNewGame = false
            hideBgrItem()
            var cnt = (control.colums * control.rows)
            for (var index = 0; index < cnt; index++) {
                control.nextBgrItem++
            }
            control.nextBgrItem = -1
        }
    }

    onNextBgrItemChanged: {
        setupBgrItem(nextBgrItem) // move background item for here place
    }

    ListModel {
        id: bgrItemsModel
        Component.onCompleted: {
            fillBackgroundModel(bgrItemsModel)
        }
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

    function setupBgrItem(index) {
        if (index < 0) {
            return
        }
        var m_col = index % 8
        var m_row = (index > 7) ? ((index - m_col) / 8) : 0
        var x = m_col * (control.cellSize + 3 * DevicePixelRatio)
        var y = m_row * (control.cellSize + 3 * DevicePixelRatio)

        x += 2 * DevicePixelRatio
        y += 2 * DevicePixelRatio

        bgrItemsModel.setProperty(index, "x", x)
        bgrItemsModel.setProperty(index, "y", y)
        bgrItemsModel.setProperty(index, "visible", true)
    }

    function hideBgrItem() {
        var cnt = (control.colums * control.rows)
        for (var index = 0; index < cnt; index++) {
            bgrItemsModel.setProperty(index, "x", -100)
            bgrItemsModel.setProperty(index, "y", -100)
            bgrItemsModel.setProperty(index, "visible", false)
        }
    }
}
