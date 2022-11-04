import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Item {
    id: control

    property int hintX: 0
    property int hintY: 0
    property int level: 1 //READ level WRITE setLevel NOTIFY levelChanged)
    property int score: 0 //READ score WRITE setScore NOTIFY scoreChanged)
    property int selGemRow: 0 //READ selGemRow WRITE setSelGemRow NOTIFY selGemRowChanged)
    property int selGemColumn: 0 //READ selGemColumn WRITE setSelGemColumn NOTIFY selGemColumnChanged)
    property int cellSize: 38 * DevicePixelRatio
    property int colums: 8
    property int rows: 8

    property bool gemSelected: false //READ gemSelected WRITE setGemSelected NOTIFY gemSelectedChanged)
    property bool gameLost: false //READ gameLost)
    property bool hintVisible: false
    Rectangle {
        id: bgrItem
        anchors.fill: parent
        radius: 4 * DevicePixelRatio
        border.color: "black"
        border.width: 2 * DevicePixelRatio
        color: "transparent"
        z: -1

        Repeater {
            id: repeaterItem
            model: 2 //colums * rows
            Image {
                //TODO Move to separeted file
                id: bgrImg
                readonly property int idx: model.index
                Behavior on x {
                    enabled: true
                    PropertyAnimation {
                        easing.type: Easing.OutBack
                        duration: 300
                    }
                }
                Behavior on y {
                    enabled: true
                    PropertyAnimation {
                        easing.type: Easing.OutBack
                        duration: 300
                    }
                }
                opacity: 0.55
                visible: true
                width: control.cellSize
                height: control.cellSize
                source: "qrc:/res/images/tile_background.png"
                sourceSize.width: control.cellSize
                sourceSize.height: control.cellSize
            }
        }
    }
    Component.onCompleted: {
        reOrderBackgroundCells(repeaterItem)
    }

    function reOrderBackgroundCells(repeaterItem) {
        for (var i = 0; i < repeaterItem.count; i++) {
            console.log("repeaterItem:" + 5 + " Properties\n")
            var item = repeaterItem.itemAt(i)
            if (i == 1) {
                item.x = 23
                item.y = 33
            }

            for (var p in item)
                console.log(p + ": " + item[p] + "\n")
        }
    }
}
