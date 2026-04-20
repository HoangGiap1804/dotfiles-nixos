pragma Singleton
import QtQuick 
import Quickshell

PersistentProperties {
    id: singleton
    property bool active: false
    function toggle() { active = !active }
}
