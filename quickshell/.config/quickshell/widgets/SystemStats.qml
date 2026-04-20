import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: systemStats
    visible: false
    property string cpuUsage: "0%"
    property string ramUsage: "0%"
    property string gpuUsage: "0%"
    property string wifiName: "Disconnected"

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuProc.running = true;
            ramProc.running = true;
            gpuProc.running = true;
            wifiProc.running = true;
        }
    }

    Process {
        id: cpuProc
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                systemStats.cpuUsage = text.trim() + "%"
                cpuProc.running = false
            }
        }
    }

    Process {
        id: ramProc
        command: ["sh", "-c", "free -m | awk '/Mem:/ { printf(\"%.0f%%\", $3/$2*100) }'"]
        stdout: StdioCollector {
            onStreamFinished: {
                systemStats.ramUsage = text.trim()
                ramProc.running = false
            }
        }
    }

    Process {
        id: gpuProc
        command: ["sh", "-c", "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{print $1\"%\"}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                systemStats.gpuUsage = text.trim()
                gpuProc.running = false
            }
        }
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
        stdout: StdioCollector {
            onStreamFinished: {
                let ssid = text.trim()
                systemStats.wifiName = ssid !== "" ? ssid : "Disconnected"
                wifiProc.running = false
            }
        }
    }
}
