import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property alias color: label.color
    property int score: 0
    readonly property int buttonSize: 48
    property alias goalEnabled: goalButton.enabled

    signal goalScored

    ColumnLayout {
        anchors.fill: parent
        Label {
            id: label
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            text: "%1".arg(root.score)
            font.pixelSize: 500
        }
        Row {
            Button {
                text: "-"
                width: root.buttonSize
                height: root.buttonSize
                onClicked: {
                    if(score > 0) {
                        score--
                    }
                }
            }
            Button {
                text: "+"
                width: root.buttonSize
                height: root.buttonSize
                onClicked: {
                    score++
                }
            }
            Button {
                text: "↻"
                width: root.buttonSize
                height: root.buttonSize
                onClicked: {
                    score = 0
                }
            }
            Button {
                id: goalButton
                text: "GOAL"
                background: Rectangle {
                    color: "green"
                }
                width: root.buttonSize * 3
                height: root.buttonSize
                onClicked: {
                    score++
                    goalScored()
                }
            }
        }
    }
}
