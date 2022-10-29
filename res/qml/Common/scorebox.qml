import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Item {
    id: control

    property string gameBoardScore: ""
    property int gameBoardLevel: 1

    width: parent.width
    height: 60 * DevicePixelRatio /* cellSize*1.5, actually */
    state: "stateHidden"

    Text {
        id: txtScore

        font.family: global.fonts.gamefont
        font.pointSize: 16 * DevicePixelRatio
        font.bold: true
        color: "white"

        anchors.margins: 15 * DevicePixelRatio
        text: gameBoardScore
        scale: 0
    }

    Text {
        id: txtLevel
        color: "white"
        font.family: global.fonts.gamefont
        font.pointSize: 16 * DevicePixelRatio
        font.bold: true
        text: "Level " + gameBoardLevel + " "
        anchors.margins: 15 * DevicePixelRatio
        scale: 1
    }

    states: [
        State {
            name: "stateNormal"
        },
        State {
            name: "stateHidden"
        }
    ]

    transitions: [
        Transition {
            from: "stateHidden"
            to: "stateNormal"

            ScaleAnimator {
                target: txtScore
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutQuad
            }
            ScaleAnimator {
                target: txtLevel
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.OutQuad
            }
        },
        Transition {
            from: "stateNormal"
            to: "stateHidden"

            ScaleAnimator {
                target: txtScore
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.OutQuad
            }
            ScaleAnimator {
                target: txtLevel
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    ]
}
