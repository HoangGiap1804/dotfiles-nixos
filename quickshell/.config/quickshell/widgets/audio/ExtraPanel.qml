import Quickshell
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Services.Pipewire

import "../../colors"

PanelWindow {
    id: audioPanel 
    anchors {
        top: true
        right: true
    }
    aboveWindows: true 
    implicitHeight:400 
    implicitWidth:300 
    visible: false
    // exclusiveZone: 0
    color: "#00000000"

    Component.onCompleted: {
      AudioPanelSingleton.panel = audioPanel
      AudioPanelSingleton.panel.visibel = false
    }
    Rectangle{
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter
      width: 250
      height: 350
      color: WalColors.color6
      border.color: WalColors.background
      border.width: 3
      radius: 10

      ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: 10

          // get a list of nodes that output to the default sink
          PwNodeLinkTracker {
            id: linkTracker
            node: Pipewire.defaultAudioSink
          }

          MixerEntry {
            node: Pipewire.defaultAudioSink
          }

          Rectangle {
            Layout.fillWidth: true
            color: palette.active.text
            implicitHeight: 1
          }

          Repeater {
            model: linkTracker.linkGroups
            MixerEntry {
              required property PwLinkGroup modelData
              node: modelData.source
            }
          }
        }
      }
    }
}
