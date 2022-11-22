import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import "qrc:/res/js/util.js" as Utils

Item {
    id: root

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
    property int srcSize: 0
    property int type: 0
    property int m_modifer: Modifier.CellState.Normal
    property int currentParentIndex: -1
    property int animTime: 0
    property alias sourceImage: img.source

    // ----- Signal declarations
    //    signal myBehaviorEnabledChanged
    //    signal timeToDieChanged
    //    signal shouldBeRemovedChanged
    //    signal explodedOnceChanged
    //    signal modifierChanged

    // ----- In this section, we group the size and position information together.
    width: srcSize
    height: srcSize
    opacity: Utils.isOpacity(root.width, root.x, root.y)
    enabled: true
    layer.enabled: true

    // ----- Then attached properties and attached signal handlers.
    Image {
        id: img
        opacity: 1
        smooth: isHyperCube()
        source: Utils.getGemImageSource(isHyperCube(), root.type)
        sourceSize.width: root.srcSize
        sourceSize.height: root.srcSize

        Behavior on opacity {
            NumberAnimation {
                duration: animTime
                easing.type: Easing.InQuad
                properties: "opacity"
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: animTime
                easing.type: Easing.InQuad
                properties: "scale"
            }
        }
    }

    Behavior on x {
        enabled: root.spawned && root.myBehaviorEnabled
        PropertyAnimation {
            easing.type: Easing.OutBack
            duration: 400
        }
    }
    Behavior on y {
        enabled: myBehaviorEnabled
        SequentialAnimation {
            PauseAnimation {
                duration: Utils.calcRandomDuration(root.myBehaviorPause)
            }
            PropertyAnimation {
                duration: 400
                easing.type: Easing.OutBack
            }

            ScriptAction {
                script: root.myBehaviorPause = 0
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

    // ----- JavaScript functions
    function isHyperCube() {
        console.trace()
        console.log("isHyperCube():" + root.m_modifer)
        return (root.m_modifer === Modifier.CellState.HyperCube) ? 1 : 0
    }
}
