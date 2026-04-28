pragma Singleton
import QtQuick 
import Quickshell

PersistentProperties {
    id: singleton

    property bool active: false
    property PanelWindow panel: null

    function toggle() {
        active = !active
        console.log("Audio panel active:", active)
    }

    function show() {
        active = true
    }

    function hide() {
        active = false
    }
}
