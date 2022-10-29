import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

Rectangle {
    id: button
    color: "white"s
    width: buttonLabel.width + 20 * DevicePixelRatio
    height: buttonLabel.height + 5 * DevicePixelRatio
    radius: button.height / 2.1
    smooth: true

    property alias caption: buttonLabel.text
    property alias textColor: buttonLabel.color
    property color borderColor: "transparent"
    property int borderWidth: 0
    property int fontSize: 12
    property bool enabled: true
    signal clicked

    border {
        width: borderWidth
        color: borderColor
    }

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: {
                if (!mouseArea.pressed || !button.enabled)
                    return button.color
                else
                    return Qt.darker(button.color)
            }
        }
        GradientStop {
            position: 0.2
            color: {
                if (!mouseArea.pressed || !button.enabled)
                    return Qt.lighter(button.color)
                else
                    return button.color
            }
        }
        GradientStop {
            position: 1.0
            color: {
                if (!mouseArea.pressed || !button.enabled)
                    return button.color
                else
                    return Qt.darker(button.color)
            }
        }
    }

    Text {
        id: buttonLabel
        anchors.centerIn: parent
        font.pointSize: fontSize
        font.family: buttonFont.name
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (button.enabled)
                button.clicked()
        }
    }
}
