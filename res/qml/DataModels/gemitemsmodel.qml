import QtQuick 2.15

ListModel {
    id: control

    ListElement {
        type: 0
        x: 0
        y: 0
        spawned: false
        normal_dying: false
        explode_dying: false
        explodable: false
        exploded_once: false

        selected: false
        behavior_pause: 0
        behavior_enabled: false
        time_to_die: false
        should_be_removed: false
        invincible: false
        modifier: 0
        src_size: 40
    }
    ListElement {
        type: 1
        x: 0
        y: 0
        spawned: false
        normal_dying: false
        explode_dying: false
        explodable: false
        exploded_once: false

        selected: false
        behavior_pause: 0
        behavior_enabled: false
        time_to_die: false
        should_be_removed: false
        invincible: false
        modifier: 0
        src_size: 40
    }
}
