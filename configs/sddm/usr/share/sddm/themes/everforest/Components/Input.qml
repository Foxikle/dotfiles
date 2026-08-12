// Foxgrove — Input.qml
// Clean underline text fields with aurora highlight states.

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Column {
  id: inputContainer
  focus: true
    spacing: root.font.pointSize * 0.3
    Layout.fillWidth: true

    property var exposeSession: sessionSelect.exposeSession
    property bool failed

    // ── Username row ──────────────────────────────────────────────
    Item {
        id: usernameField
        height: root.font.pointSize * 4
        width: parent.width

        // User avatar icon / dropdown trigger
        ComboBox {
            id: selectUser
            width: parent.height * 0.7
            height: parent.height * 0.7
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: root.font.pointSize * 0.25
            z: 2

            property var popkey: config.ForceRightToLeft == "true" ? Qt.Key_Right : Qt.Key_Left
            Keys.onPressed: {
                if (event.key == Qt.Key_Down && !popup.opened) username.forceActiveFocus()
                if ((event.key == Qt.Key_Up || event.key == popkey) && !popup.opened) popup.open()
            }
            KeyNavigation.down: username
            KeyNavigation.right: username

            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"
            hoverEnabled: true
            onActivated: { username.text = currentText }

            delegate: ItemDelegate {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                contentItem: Text {
                    text: model.name
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 0.85
                    font.capitalization: Font.Capitalize
                    color: selectUser.highlightedIndex === index ? "#0D1B2A" : root.palette.text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                highlighted: parent.highlightedIndex === index
                background: Rectangle {
                    color: selectUser.highlightedIndex === index ? root.palette.highlight : "transparent"
                }
            }

            indicator: Button {
                id: usernameIcon
                width: selectUser.height
                height: selectUser.height
                anchors.centerIn: parent
                enabled: false
                background: Rectangle { color: "transparent" }
                Behavior on icon.color { PropertyAnimation { duration: 150 } }
            }

            background: Rectangle { color: "transparent"; border.color: "transparent" }

            popup: Popup {
                y: parent.height + 4
                x: config.ForceRightToLeft == "true" ? -loginButton.width + selectUser.width : 0
                width: usernameField.width
                implicitHeight: contentItem.implicitHeight
                padding: 8

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight + 16
                    model: selectUser.popup.visible ? selectUser.delegateModel : null
                    currentIndex: selectUser.highlightedIndex
                }

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(0.05, 0.11, 0.18, 0.92)
                    border.color: Qt.rgba(1,1,1,0.10)
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0; verticalOffset: 8
                        radius: 18; samples: 37; cached: true
                        color: Qt.rgba(0,0,0,0.5)
                    }
                }
                enter: Transition { NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 120 } }
            }
        }

        // Username text field — underline style
        TextField {
            id: username
            text: config.ForceLastUser == "true" ? selectUser.currentText : null
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            font.capitalization: config.AllowBadUsernames == "false" ? Font.Capitalize : Font.MixedCase
            anchors.left: selectUser.right
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: root.font.pointSize * 0.5
            height: root.font.pointSize * 3
            placeholderText: config.TranslatePlaceholderUsername || textConstants.userName
            selectByMouse: true
            horizontalAlignment: TextInput.AlignLeft
            renderType: Text.QtRendering
            color: root.palette.text
            selectionColor: root.palette.highlight
            selectedTextColor: "#0D1B2A"

            onFocusChanged: { if (focus) selectAll() }

            background: Item {
                // Bottom underline only
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: username.activeFocus ? 2 : 1
                    color: username.activeFocus ? root.palette.highlight : Qt.rgba(1,1,1,0.28)
                    Behavior on color { PropertyAnimation { duration: 150 } }
                    Behavior on height { NumberAnimation { duration: 120 } }
                }
            }

            onAccepted: loginButton.clicked()
            KeyNavigation.down: password
            z: 1
        }
    }

    // ── Password row ──────────────────────────────────────────────
    Item {
        id: passwordField
        height: root.font.pointSize * 4
        width: parent.width

        TextField {
            id: password
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: selectUser.width + root.font.pointSize * 0.5
            anchors.verticalCenter: parent.verticalCenter
            height: root.font.pointSize * 3
            font.family: root.font.family
            font.pointSize: root.font.pointSize
            focus: config.ForcePasswordFocus == "true" ? true : false
            selectByMouse: true
            echoMode: revealSecret.checked ? TextInput.Normal : TextInput.Password
            placeholderText: config.TranslatePlaceholderPassword || textConstants.password
            horizontalAlignment: TextInput.AlignLeft
            passwordCharacter: "•"
            passwordMaskDelay: config.ForceHideCompletePassword == "true" ? undefined : 1000
            renderType: Text.QtRendering
            color: root.palette.text
            selectionColor: root.palette.highlight
            selectedTextColor: "#0D1B2A"

            background: Item {
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: password.activeFocus ? 2 : 1
                    color: password.activeFocus ? root.palette.highlight : Qt.rgba(1,1,1,0.28)
                    Behavior on color { PropertyAnimation { duration: 150 } }
                    Behavior on height { NumberAnimation { duration: 120 } }
                }
            }

            onAccepted: loginButton.clicked()
            KeyNavigation.down: revealSecret
        }
    }

    // ── Show password toggle ──────────────────────────────────────
    Item {
        id: secretCheckBox
        height: root.font.pointSize * 2.5
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: selectUser.width + root.font.pointSize * 0.5

        CheckBox {
            id: revealSecret
            hoverEnabled: true
            anchors.left: parent.left

            indicator: Rectangle {
                id: indicator
                implicitWidth: root.font.pointSize
                implicitHeight: root.font.pointSize
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                border.color: revealSecret.hovered || revealSecret.activeFocus
                                ? root.palette.highlight : Qt.rgba(1,1,1,0.4)
                border.width: 1
                radius: 3
                Rectangle {
                    id: dot
                    anchors.centerIn: parent
                    width: parent.width - 6; height: parent.height - 6
                    color: root.palette.highlight
                    radius: 2
                    opacity: revealSecret.checked ? 1 : 0
                    Behavior on opacity { NumberAnimation { duration: 120 } }
                }
            }

            contentItem: Text {
                id: indicatorLabel
                text: config.TranslateShowPassword || "Show Password"
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.78
                color: revealSecret.hovered || revealSecret.activeFocus
                         ? root.palette.highlight : Qt.rgba(root.palette.text.r, root.palette.text.g, root.palette.text.b, 0.65)
                anchors.left: indicator.right
                anchors.leftMargin: indicator.width * 0.6
                anchors.verticalCenter: indicator.verticalCenter
                Behavior on color { PropertyAnimation { duration: 150 } }
            }

            background: Rectangle { color: "transparent" }

            Keys.onReturnPressed: toggle()
            Keys.onEnterPressed: toggle()
            KeyNavigation.down: loginButton
        }
    }

    // ── Error / CapsLock message ──────────────────────────────────
    Item {
        height: root.font.pointSize * 2
        width: parent.width

        Label {
            id: errorMessage
            width: parent.width
            text: failed
                    ? (config.TranslateLoginFailedWarning || textConstants.loginFailed + "!")
                    : keyboard.capsLock
                        ? (config.TranslateCapslockWarning || textConstants.capslockWarning)
                        : ""
            horizontalAlignment: Text.AlignHCenter
            font.family: root.font.family
            font.pointSize: root.font.pointSize * 0.8
            font.italic: true
            color: "#E06C75"
            opacity: (failed || keyboard.capsLock) ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }
    }

    // ── Login button ──────────────────────────────────────────────
    Item {
        id: loginRow
        height: root.font.pointSize * 3.5
        width: parent.width

        Button {
            id: loginButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: config.TranslateLogin || textConstants.login
            height: root.font.pointSize * 3.2
            implicitWidth: parent.width * 0.72
            enabled: config.AllowEmptyPassword == "true" || (username.text != "" && password.text != "")
            hoverEnabled: true

            contentItem: Text {
                text: parent.text
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.9
                font.letterSpacing: root.font.pointSize * 0.35
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: loginButton.enabled
                         ? (loginButton.hovered || loginButton.activeFocus ? "#0D1B2A" : root.palette.highlight)
                         : Qt.rgba(root.palette.text.r, root.palette.text.g, root.palette.text.b, 0.35)
                Behavior on color { PropertyAnimation { duration: 200 } }
            }

            background: Rectangle {
                id: btnBg
                radius: config.RoundCorners || 12
                color: loginButton.enabled
                         ? (loginButton.down         ? Qt.darker(root.palette.highlight, 1.15)
                            : loginButton.hovered || loginButton.activeFocus
                                                      ? root.palette.highlight
                                                      : Qt.rgba(root.palette.highlight.r,
                                                                root.palette.highlight.g,
                                                                root.palette.highlight.b, 0.12))
                         : Qt.rgba(1, 1, 1, 0.07)
                border.color: loginButton.enabled
                                ? root.palette.highlight
                                : Qt.rgba(1, 1, 1, 0.15)
                border.width: 1
                Behavior on color { PropertyAnimation { duration: 200 } }
            }

            onClicked: config.AllowBadUsernames == "false"
                         ? sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession)
                         : sddm.login(username.text, password.text, sessionSelect.selectedSession)
            Keys.onReturnPressed: clicked()
            Keys.onEnterPressed: clicked()
            KeyNavigation.down: sessionSelect.exposeSession
        }
    }

    // ── Session selector ──────────────────────────────────────────
    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
        loginButtonWidth: loginButton.background.width
    }

    // ── Connections ───────────────────────────────────────────────
    Connections {
        target: sddm
        function onLoginSucceeded() {}
        function onLoginFailed() {
            failed = true
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2500
        onTriggered: failed = false
        running: false
    }
}
