import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

import "../../colors"

ColumnLayout {
	required property PwNode node;

	// bind the node so we can read its properties
	PwObjectTracker { objects: [ node ] }

	RowLayout {
		Button {
      id: button
			text: node.audio.muted ? " " : " "
			onClicked: node.audio.muted = !node.audio.muted
      background: Rectangle {
        implicitWidth: 50
        implicitHeight: 30
        color: button.down ? WalColors.color6 : WalColors.color8
        border.color: colorBorder
        border.width: 2
        radius: 10
      }
		}
		Label {
			text: {
				// application.name -> description -> name
				const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
				const media = node.properties["media.name"];
				return media != undefined ? `${app} - ${media}` : app;
			}
		}
	}

	RowLayout {
		Label {
			Layout.preferredWidth: 50
			text: `${Math.floor(node.audio.volume * 100)}%`
		}

		Slider {
			Layout.preferredWidth: 150
			value: node.audio.volume
			onValueChanged: node.audio.volume = value
		}
	}
}
