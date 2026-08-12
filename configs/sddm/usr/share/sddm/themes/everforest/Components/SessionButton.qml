// Foxgrove — SessionButton.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Item {
    id: sessionButton
    height: root.font.pointSize * 2
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter

    property var selectedSession: selectSession.currentIndex
    property string textConstantSession
    property int loginButtonWidth
    property var exposeSession: selectSession

    ComboBox {
        id: selectSession
        hoverEnabled: true
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width

        Keys.onPressed: {
            if (event.key == Qt.Key_Up && loginButton.state != "enabled" && !popup.opened)
                revealSecret.focus = true
            if (event.key == Qt.Key_Up && loginButton.state == "enabled" && !popup.opened)
                loginButton.focus = true
            if (event.key == Qt.Key_Down && !popup.opened)
                systemButtons.children[0].focus = true
            if ((event.key == Qt.Key_Left || event.key == Qt.Key_Right) && !popup.opened)
                popup.open()
        }

        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        delegate: ItemDelegate {
            width: parent.width
            contentItem: Text {
                text: model.name
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.82
                color: selectSession.highlightedIndex === index ? "#0D1B2A" : root.palette.text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            highlighted: parent.highlightedIndex === index
            background: Rectangle {
                color: selectSession.highlightedIndex === index ? root.palette.highlight : "transparent"
            }
        }

        indicator { visible: false }

        contentItem: Text {
            id: displayedItem
            text: (config.TranslateSession || (textConstantSession + ":")) + "  " + selectSession.currentText
            color: selectSession.hovered || selectSession.visualFocus
                     ? root.palette.highlight
                     : Qt.rgba(root.palette.text.r, root.palette.text.g, root.palette.text.b, 0.5)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: root.font.family
            font.pointSize: root.font.pointSize * 0.72
            font.letterSpacing: root.font.pointSize * 0.2
            Behavior on color { PropertyAnimation { duration: 150 } }
        }

        background: Rectangle { color: "transparent" }

        popup: Popup {
            y: -implicitHeight - 4
            x: (sessionButton.width - width) / 2
            width: Math.min(sessionButton.width, 280)
            implicitHeight: contentItem.implicitHeight
            padding: 8

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight + 16
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
            }

            background: Rectangle {
                radius: 10
                color: Qt.rgba(0.05, 0.11, 0.18, 0.94)
                border.color: Qt.rgba(1, 1, 1, 0.10)
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0; verticalOffset: -8
                    radius: 20; samples: 41; cached: true
                    color: Qt.rgba(0, 0, 0, 0.5)
                }
            }

            enter: Transition { NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 120 } }
        }
    }
}
