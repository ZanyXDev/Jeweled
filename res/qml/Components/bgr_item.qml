import QtQuick 2.15

Item {
    id: root
    property int animationTime:0
    Image {
        anchors.fill: parent
        opacity: 0.55
        source: "qrc:/res/images/tile_background.png"
        sourceSize.width: root.width
        sourceSize.height: root.width
        fillMode: Image.PreserveAspectFit

        Behavior on y {
            enabled: true
            PropertyAnimation {
                easing.type: Easing.OutBack
                duration: root.animationTime
            }
        }
    }
}
