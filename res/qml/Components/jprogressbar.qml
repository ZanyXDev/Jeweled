import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.12
import Common 1.0

QQC2.ProgressBar {
    id: root
    property color proBackgroundColor: "darkgrey"
    property alias color: gradient1.color
    property alias secondColor: gradient2.color

    property int proWidth: 2
    property real progress: 0
    property real proRadius: 2 * DevicePixelRatio
    property int proPadding: 2 * DevicePixelRatio

    value: (progress / 100)

    padding: proPadding

    background: Rectangle {
        implicitWidth: 200 * DevicePixelRatio
        implicitHeight: 16 * DevicePixelRatio
        color: root.proBackgroundColor
        radius: root.proRadius
    }

    contentItem: Item {
        implicitWidth: 200 * DevicePixelRatio
        implicitHeight: 10 * DevicePixelRatio

        Rectangle {
            property int widthDest: root.visualPosition * parent.width
            width: widthDest
            height: parent.height
            radius: root.proRadius
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
