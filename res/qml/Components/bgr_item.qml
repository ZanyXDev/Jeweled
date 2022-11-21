import QtQuick 2.15

Image {
    id: root
    opacity: 0.75
    source: "qrc:/res/images/tile_background.png"

    fillMode: Image.PreserveAspectFit

    Behavior on y {
        enabled: true
        PropertyAnimation {
            easing.type: Easing.OutBack
            duration: 1000
        }
    }

    MouseArea {
        id: mA
        anchors.fill: parent
        onClicked: {
            console.log("bgr_item onClicked" + root.x)
        }
    }
}
