import QtQuick 2.15
import QtQuick.Layouts 1.15
import Common 1.0


/**
  @note based on https://stackoverflow.com/questions/35553792/show-fps-in-qml/35557449#35557449
  */
Item {
    id: root
    property alias textColor: fpsText.color

    property int frameCounter: 0
    property int frameCounterAvg: 0
    property int counter: 0
    property int fps: 0
    property int fpsAvg: 0

    property int animTime: 800
    property int timerInterval: 2000
    property alias rowSpacing: mainLayout.spacing

    visible: opacity > 0

    Behavior on opacity {
        NumberAnimation {
            duration: AppSingleton.timerInterval
            easing.type: Easing.InQuad
        }
    }

    RowLayout {
        id: mainLayout
        spacing: rowSpacing
        Image {
            id: spinnerImage
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            source: "qrc:/res/images/effects/spinner.png"
            fillMode: Image.PreserveAspectFit
            sourceSize {
                width: root.height
                height: root.height
            }

            NumberAnimation on rotation {
                from: 0
                to: 360
                duration: root.animTime
                loops: Animation.Infinite
            }
            onRotationChanged: frameCounter++
        }

        Text {
            id: fpsText

            Layout.fillWidth: true

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft

            font {
                pointSize: AppSingleton.tinyFontSize
                family: AppSingleton.buttonFont.name
            }
            text: root.fpsAvg + " | " + root.fps + " fps"
        }
    }

    Timer {
        interval: root.timerInterval
        repeat: true
        running: true
        onTriggered: {
            frameCounterAvg += frameCounter
            root.fps = frameCounter / 2
            counter++
            frameCounter = 0
            if (counter >= 3) {
                root.fpsAvg = frameCounterAvg / (2 * counter)
                frameCounterAvg = 0
                counter = 0
            }
        }
    }
}
