import QtQuick 2.15

Text {
    id: root

    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignRight

    font {
        pointSize: global.smallFontSize
        family: global.fonts.buttonfont
    }

    Behavior on opacity {
        NumberAnimation {
            duration: global.timerInterval
            easing.type: Easing.InQuad
        }
    }
}
