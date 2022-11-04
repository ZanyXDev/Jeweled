import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Item {
    id: control

    property string appTitle: ""
    property int gameBoardLevel: 1
    property string gameBoardScore: ""

    component InfoLablel: QQC2.Label {
        anchors.fill: parent

        font {
            family: global.fonts.gamefont
            pointSize: global.middleFontSize
            bold: true
        }

        scale: 0

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        Behavior on scale {
            NumberAnimation {
                easing.type: Easing.InQuad
                duration: 300
            }
        }
    }

    InfoLablel {
        id: txtAppTitle
        text: appTitle
    }

    InfoLablel {
        id: txtScore
        text: gameBoardScore
    }

    InfoLablel {
        id: txtLevel
        text: "Level " + gameBoardLevel + " "
    }

    states: [
        // Explicit properties for default state (show AppTitle).
        State {
            name: ""
            PropertyChanges {
                target: control
                visible: true
                opacity: 1
            }
        },
        State {
            name: "stateShowAppTitle"
            PropertyChanges {
                target: txtAppTitle
                scale: 1
            }
            PropertyChanges {
                target: txtLevel
                scale: 0
            }
            PropertyChanges {
                target: txtScore
                scale: 0
            }
        },
        State {
            name: "stateShowLevel"
            PropertyChanges {
                target: txtAppTitle
                scale: 0
            }
            PropertyChanges {
                target: txtLevel
                scale: 1
            }
            PropertyChanges {
                target: txtScore
                scale: 0
            }
        },
        State {
            name: "stateShowScore"
            PropertyChanges {
                target: txtAppTitle
                scale: 0
            }
            PropertyChanges {
                target: txtLevel
                scale: 0
            }
            PropertyChanges {
                target: txtScore
                scale: 1
            }
        }
    ]
}
