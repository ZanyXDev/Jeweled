import QtQuick 2.15
import AppEffects 1.0

Item {
    id: control
    property string imageTitleSource: "qrc:/res/images/titleText.svg"
    property string imageGemSource: "qrc:/res/images/gems/orangeGem.svg"
    property double m_size: 50 * DevicePixelRatio
    Image {
        id: imgGameTitle
        source: imageTitleSource
        sourceSize {
            width: control.width
            height: control.height
        }

        Image {
            anchors.centerIn: parent
            width: m_size
            height: m_size
            sourceSize.width: width
            sourceSize.height: height
            visible: control.y > 0
            source: imageGemSource
            Shine {
                anchors {
                    leftMargin: 10 * DevicePixelRatio
                    topMargin: 10 * DevicePixelRatio
                }
            }
        }
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: global.timerIterval
            }
        }
    }
}
