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
    property int cellSize: 40

    property bool gemSelected: false //READ gemSelected WRITE setGemSelected NOTIFY gemSelectedChanged)
    property bool gameLost: false //READ gameLost)
    property bool hintVisible: false
}
