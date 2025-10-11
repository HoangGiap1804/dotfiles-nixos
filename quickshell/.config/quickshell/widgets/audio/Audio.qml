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
        implicitHeight: 30
        color: button.down ? colorButtonDown : colorButtonUp
        border.color: colorBorder
        border.width: 2
        radius: 10
        RowLayout{
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter
          Text{
            text: node.audio.muted ? " " : " "
          }
          Text{
			      text: `${Math.floor(node.audio.volume * 100)}%`
          }
        }
    }
}
