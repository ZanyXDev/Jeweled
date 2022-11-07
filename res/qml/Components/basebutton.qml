import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

QQC2.Button {
    id: control

    property color shadowColor: "black"

    layer.enabled: true
    layer.effect: DropShadow {
        // anchors.fill: control
        horizontalOffset: 3
        verticalOffset: 4
        radius: 5
        samples: 11
        color: control.shadowColor
        opacity: 0.75
    }

    state: pressed ? "buttonDown" : "buttonUp"

    states: [
        State {
            name: "buttonDown"
            PropertyChanges {
                target: control
                scale: 0.7
            }
        },
        State {
            name: "buttonUp"
            PropertyChanges {
                target: control
                scale: 1.0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: scale
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}
