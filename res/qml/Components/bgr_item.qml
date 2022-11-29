import QtQuick 2.15
import Common 1.0

Image {
    id: root
    opacity: 0.75
    source: "qrc:/res/images/tile_background.png"

    fillMode: Image.PreserveAspectFit

    Behavior on y {
        enabled: true
        PropertyAnimation {
            easing.type: Easing.OutBack
            duration: AppSingleton.timerInterval * 2
        }
    }

    MouseArea {
        id: mA
        anchors.fill: parent
        onClicked: {
            AppSingleton.toLog("Jeweled", `bgr_item onClicked:${root.x}`)
        }
    }
}
