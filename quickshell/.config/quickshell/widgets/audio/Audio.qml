import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import Quickshell

Button {
    required property string colorBorder;
    required property string colorButtonUp;
    required property string colorButtonDown;
    required property string colorText;
	  property PwNode node: Pipewire.defaultAudioSink;

	  PwObjectTracker { objects: [ node ] }
	
    id: button
    onClicked: {
      // node.audio.muted = !node.audio.muted
      console.log('hello')
      AudioPanelSingleton.toggle()
    }
    background: Rectangle {
        implicitWidth: 70
        implicitHeight: 24
        color: button.down ? colorButtonDown : colorButtonUp
        border.color: colorBorder
        border.width: 1
        radius: 8
        RowLayout{
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter
          Text{
            text: (node && node.audio) ? (node.audio.muted ? " " : " ") : " "
            font.pixelSize: 14
          }
          Text{
            text: (node && node.audio) ? `${Math.floor(node.audio.volume * 100)}%` : "0%"
            font.pixelSize: 13
          }
        }
    }
}
