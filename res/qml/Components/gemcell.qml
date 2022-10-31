import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

Item {
    id: control

    // ----- Property Declarations
    // Required properties should be at the top.
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
    property int srcSize: 80 * DevicePixelRatio
    property int type: 0
    property int modifer: Modifier.CellState.Normal

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
    anchors.top: parent.top // If a single assignment, dot notation can be used.
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
        if (isDebugMode)
            console.log("GemCell modifier:" + modifer)
    }
    // Component.onDestruction: {}

    // ----- Visual children.
    Image {
        id: img
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
    function getGemsImageSource() {//qrc:/res/images/gems/blueGem.svg
    }
}
