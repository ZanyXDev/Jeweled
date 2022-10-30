import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

Item {
    id: control

    // ----- Property Declarations
    // Required properties should be at the top.
    property bool m_behaviorEnabled: false
    property bool m_timeToDie: false
    property bool m_shouldBeRemoved: false
    property bool m_explodedOnce: false
    property bool m_invincible: false
    property bool spawned: false
    property bool normalDying: false
    property bool explodeDying: false
    property bool explodable: false
    property bool selected: false

    property int behaviorPause: 0
    property int srcSize: 80
    property int type: 0

    enum Modifier {
        Normal,
        Explosive,
        HyperCube,
        RowColumnRemove
    }

    // ----- Signal declarations
    signal behaviorEnabledChanged
    signal timeToDieChanged
    signal shouldBeRemovedChanged
    signal explodedOnceChanged
    signal modifierChanged

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

    //Layout.fillWidth: true

    // ----- States and transitions.

    //    states: [
    //        State {

    //        }
    //    ]
    //    transitions: [
    //        Transitions {

    //        }
    //    ]

    // ----- Signal handlers
    onWidthChanged: {

        // Always use curly braces.
    }
    // onCompleted and onDestruction signal handlers are always the last in
    // the order.
    Component.onCompleted: {

    }
    Component.onDestruction: {

    }

    // ----- Visual children.
    Image {}

    // ----- Qt provided non-visual children

    // ----- Custom non-visual children

    // ----- JavaScript functions
    function isOpacity() {
        halfWidth = control.width / 2
        eightWidth = control.width * 8

        return ((control.x < -halfWidth) || (control.y < -halfWidth)
                || (control.x >= eightWidth)
                || (control.y >= eightWidth)) ? 0 : 1
    }
}
