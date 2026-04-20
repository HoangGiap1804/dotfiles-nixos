import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import QtQuick.Controls.Basic
import Quickshell.Services.Pipewire

import "../../colors"

PanelWindow {
    id: audioPanel 
    
    property bool active: AudioPanelSingleton.active

    anchors {
        top: true
        right: true
    }
    
    margins {
        top: 15
        right: 15
    }
    
    aboveWindows: true 
    implicitHeight: 500
    implicitWidth: 320
    
    // Window is visible as long as the animation is running
    visible: active || (contentRect.opacity > 0)
    color: "transparent"
    exclusionMode: ExclusionMode.None

    Component.onCompleted: {
      AudioPanelSingleton.panel = audioPanel
    }

    Rectangle {
      id: contentRect
      anchors.top: parent.top
      anchors.right: parent.right
      width: 300
      height: Math.min(450, mainLayout.implicitHeight + 40)
      
      color: WalColors.background
      border.color: WalColors.color6
      border.width: 1
      radius: 12
      
      opacity: audioPanel.active ? 0.98 : 0
      scale: audioPanel.active ? 1 : 0.95
      
      Behavior on opacity { NumberAnimation { duration: 150 } }
      Behavior on scale { 
          NumberAnimation { 
              duration: 250
              easing.type: Easing.OutBack
          } 
      }

      /* layer.enabled: true
      layer.effect: MultiEffect {
          shadowEnabled: true
          shadowBlur: 0.8
          shadowColor: "#80000000"
          shadowVerticalOffset: 4
      } */

      ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: 15
        spacing: 12

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Volume Mixer"
                font.pixelSize: 16
                font.bold: true
                color: WalColors.foreground
                Layout.fillWidth: true
            }
            Text {
                text: "󰓃"
                font.pixelSize: 18
                color: WalColors.color4
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: WalColors.color8
            opacity: 0.2
        }

        ScrollView {
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true
          ScrollBar.vertical: ScrollBar { 
              policy: ScrollBar.AsNeeded
          }

          ColumnLayout {
            width: mainLayout.width - 30
            spacing: 16

            PwNodeLinkTracker {
              id: linkTracker
              node: Pipewire.defaultAudioSink
            }

            MixerEntry {
              node: Pipewire.defaultAudioSink
            }

            Rectangle {
              Layout.fillWidth: true
              color: WalColors.color8
              opacity: 0.1
              implicitHeight: 1
              Layout.topMargin: 4
              Layout.bottomMargin: 4
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
    
    // Close when clicking outside
    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: AudioPanelSingleton.active = false
    }
}
