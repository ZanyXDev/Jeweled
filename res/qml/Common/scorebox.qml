import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Item {
    id: control

    property string gameBoardScore: ""
    property int gameBoardLevel: 0

    width: parent.width
    height: 60 * DevicePixelRatio /* cellSize*1.5, actually */
    state: "stateHidden"

    anchors.top: parent.top

    Text {
        id: txtScore
        color: "white"
        font.family: global.fonts.gamefont
        font.pointSize: 16 * DevicePixelRatio
        font.bold: true
        text: gameBoardScore
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10 * DevicePixelRatio
        anchors.bottomMargin: 5 * DevicePixelRatio
    }

    Text {
        id: txtLevel
        color: "white"
        font.family: global.fonts.gamefont
        font.pointSize: 16 * DevicePixelRatio
        font.bold: true
        text: "Level " + gameBoardLevel + " "
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10 * DevicePixelRatio
        anchors.bottomMargin: 5 * DevicePixelRatio
    }

    states: [
        State {
            name: "stateNormal"
            AnchorChanges {
                target: txtScore
                anchors.left: control.left
            }
            AnchorChanges {
                target: txtLevel
                anchors.right: control.right
            }
        },
        State {
            name: "stateHidden"
            AnchorChanges {
                target: txtScore
                anchors.right: control.left
            }
            AnchorChanges {
                target: txtLevel
                anchors.left: control.right
            }
        }
    ]

    transitions: [
        Transition {
            from: "stateHidden"
            to: "stateNormal"
            AnchorAnimation {
                duration: 200
                easing.type: Easing.Linear
            }
        },
        Transition {
            from: "stateNormal"
            to: "stateHidden"
            AnchorAnimation {
                duration: 200
                easing.type: Easing.Linear
            }
        }
    ]
}
