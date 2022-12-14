import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

Item {
    id: control

    // ----- Property Declarations
    // Required properties should be at the top.
    property point originPosition: mapToItem(parent, 0, 0)
    property bool myBehaviorEnabled: false
    property bool timeToDie: false
    property bool shouldBeRemoved: false
    property bool explodedOnce: false
    property bool invincible: false
    property bool spawned: false
    property bool normalDying: false
    property bool explodeDying: false
    property bool explodable: false
    property bool selected: false

    property int myBehaviorPause: 0
    property int srcSize: 40 * DevicePixelRatio
    property int type: 0
    property int modifer: Modifier.CellState.Normal
    property int index: 0

    // ----- Signal declarations
    //    signal myBehaviorEnabledChanged
    //    signal timeToDieChanged
    //    signal shouldBeRemovedChanged
    //    signal explodedOnceChanged
    //    signal modifierChanged

    // ----- In this section, we group the size and position information together.
    width: 40 * DevicePixelRatio
    height: 40 * DevicePixelRatio

    opacity: isOpacity()
    // If a single assignment, dot notation can be used.
    // If the item is an image, sourceSize is also set here.
    // sourceSize: Qt.size(12, 12)

    // ----- Then comes the other properties. There's no predefined order to these.

    // Do not use empty lines to separate the assignments. Empty lines are reserved
    // for separating type declarations.
    enabled: true
    layer.enabled: true

    // ----- Then attached properties and attached signal handlers.
    Behavior on x {
        enabled: spawned && myBehaviorEnabled
        PropertyAnimation {
            easing.type: Easing.OutBack
            duration: 400
        }
    }
    Behavior on y {
        enabled: myBehaviorEnabled
        SequentialAnimation {
            PauseAnimation {
                duration: calcRandomDuration()
            }
            PropertyAnimation {
                duration: 400
                easing.type: Easing.OutBack
            }

            ScriptAction {
                script: myBehaviorPause = 0
            }
        }
    }
    NumberAnimation {
        target: img
        running: isHyperCube()
        property: "rotation"
        to: 360
        duration: 4000
        loops: Animation.Infinite
    }

    // ----- States and transitions.
    states: [
        State {
            name: "Normal"
            when: (spawned === true && timeToDie === false
                   && explodedOnce === false)
            PropertyChanges {
                target: img
                opacity: 1
            }
        },
        State {
            name: "ExplodeDeathState"
            when: (timeToDie === true && explodedOnce === true)
            StateChangeScript {
                script: {
                    if (explodable) {

                        // particles.burst(100)
                    } else {

                        // particles.burst(50)
                    }
                }
            }
            PropertyChanges {
                target: img
                opacity: 0
            }
        },
        State {
            name: "NormalDeathState"
            when: (timeToDie == true && explodedOnce == false)
            PropertyChanges {
                target: img
                scale: 0.1
            }
            PropertyChanges {
                target: img
                opacity: 0
            }
        }
    ]

    // ----- Signal handlers

    // onCompleted and onDestruction signal handlers are always the last in
    // the order.
    Component.onCompleted: {

        //        if (isDebugMode) {
        //            console.log("Parent objectName:" + parent.objectName)
        //            console.log("GemCell x_y:", this.x + ":" + this.y)
        //            console.log("GemCell abs_pos:", originPosition)
        //            var globalCoordinates = mapToGlobal(0, 0)
        //            console.log("GlobalCoordinates X: " + globalCoordinates.x + " Y: "
        //                        + globalCoordinates.y)
        //            console.log("------------ debugRect ----------")
        //            console.log("parent.height:" + parent.height)
        //            console.log("parent.width:" + parent.width)

        //            for (var prop in control) {
        //                print(prop += " (" + typeof (control[prop]) + ") = " + control[prop])
        //            }
        //        }
    }
    // Component.onDestruction: {}

    // ----- Visual children.
    Image {
        id: img
        opacity: 1
        smooth: isHyperCube()
        source: getGemImageSource()
        sourceSize.width: control.srcSize
        sourceSize.height: control.srcSize

        Behavior on opacity {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InQuad
                properties: "opacity"
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InQuad
                properties: "scale"
            }
        }
    }

    // ----- Qt provided non-visual children

    // ----- Custom non-visual children

    // ----- JavaScript functions
    function isOpacity() {
        var halfWidth = control.width / 2
        var eightWidth = control.width * 8

        return ((control.x < -halfWidth) || (control.y < -halfWidth)
                || (control.x >= eightWidth)
                || (control.y >= eightWidth)) ? 0 : 1
    }

    function isHyperCube() {
        return (control.modifer === Modifier.CellState.HyperCube) ? 1 : 0
    }

    function calcRandomDuration() {
        var rnd = 1 + Math.random() * 0.4 - 0.2
        return Math.floor(control.myBehaviorPause * rnd)
    }

    function getGemImageSource() {
        var sourceImage

        if (isHyperCube()) {
            sourceImage = "qrc:/res/images/gems/hyperCube.svg"
        }

        switch (control.type) {
        case 0:
            sourceImage = "qrc:/res/images/gems/yellowGem.svg"
            break
        case 1:
            sourceImage = "qrc:/res/images/gems/redGem.svg"
            break
        case 2:
            sourceImage = "qrc:/res/images/gems/blueGem.svg"
            break
        case 3:
            sourceImage = "qrc:/res/images/gems/greenGem.svg"
            break
        case 4:
            sourceImage = "qrc:/res/images/gems/purpleGem.svg"
            break
        case 5:
            sourceImage = "qrc:/res/images/gems/whiteGem.svg"
            break
        case 6:
            sourceImage = "qrc:/res/images/gems/orangeGem.svg"
            break
        default:
            break
        }
        //        if (isDebugMode)
        //            console.log("GemCell sourceImage:" + sourceImage)
        return sourceImage
    }
}
