import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.12

QQC2.ProgressBar {
    id: control
    property color proBackgroundColor: "darkgrey"
    property alias color: gradient1.color
    property alias secondColor: gradient2.color

    property int proWidth: 2
    property real progress: 0
    property real proRadius: 2
    property int proPadding: 2

    value: (progress / 100)

    padding: proPadding

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 16
        color: control.proBackgroundColor
        radius: control.proRadius
    }

    contentItem: Item {
        implicitWidth: 200
        implicitHeight: 10

        Rectangle {
            property int widthDest: control.visualPosition * parent.width
            width: widthDest
            height: parent.height
            radius: proRadius
            smooth: true
            gradient: Gradient {
                GradientStop {
                    id: gradient1
                    position: 0.0
                }
                GradientStop {
                    id: gradient2
                    position: 1.0
                }
            }

            Behavior on width {
                SmoothedAnimation {
                    velocity: 1200
                }
            }
        }
    }
}
