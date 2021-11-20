/*
 *  SPDX-FileCopyrightText: 2019 Carl-Lucien Schwan <carl@carlschwan.eu>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.6
import QtQuick.Controls 2.1 as Controls
import org.kde.kirigami 2.7 as Kirigami

/**
 * This is advanced textfield. It is recommanded to us this class when there
 * is a need to create a create a textfield with action buttons(e.g a clear
 * action).
 *
 * Example usage for a search field:
 * @code
 * import org.kde.kirigami 2.7 as Kirigami
 *
 * Kirigami.ActionTextField {
 *     id: searchField
 *
 *     placeholderText: i18n("Search...")
 *
 *     focusSequence: "Ctrl+F"
 *
 *     rightActions: [
 *         Kirigami.Action {
 *             icon.name: "edit-clear"
 *             visible: searchField.text !== ""
 *             onTriggered: {
 *                 searchField.text = ""
 *                 searchField.accepted()
 *             }
 *         }
 *     ]
 *
 *     onAccepted: console.log("Search text is " + searchField.text)
 * }
 * @endcode
 *
 * @inherit QtQuick.Controls.TextField
 */
Controls.TextField
{
    id: root

    /**
     * focusSequence: keysequence
     * This property hold the a list of shortcut sequence that put the text
     * field into focus.
     */
    property string focusSequence

    /**
     * leftActions: list<QtObject>
     * This propery hold the action that is left in the field. By default this
     * field is null.
     */
    property list<QtObject> leftActions

    /**
     * rightActions: list<QtObject>
     * This propery hold the action that is right in the field. By default this
     * field is null.
     */
    property list<QtObject> rightActions

    hoverEnabled: true

    leftPadding: leftActionsRow.width + Kirigami.Units.smallSpacing
    rightPadding: rightActionsRow.width + Kirigami.Units.smallSpacing

    Shortcut {
        id: focusShortcut
        enabled: root.focusSequence
        sequence: root.focusSequence
        onActivated: {
            root.forceActiveFocus()
            root.selectAll()
        }
    }

    Controls.ToolTip {
        visible: root.focusSequence && root.text.length === 0 && !rightActionsRow.hovered && !leftActionsRow.hovered && hovered
        text: root.focusSequence ? root.focusSequence : ""
    }

    Row {
        id: leftActionsRow
        padding: Kirigami.Units.smallSpacing
        anchors.left: parent.left
        anchors.leftMargin: Kirigami.Units.smallSpacing
        anchors.verticalCenter: parent.verticalCenter
        height: root.implicitHeight - 2 * Kirigami.Units.smallSpacing
        Repeater {
            model: root.leftActions
            Kirigami.Icon {
                // this is Kirigami.Units.iconSizes.small, but avoids being scaled x1.5 on mobile
                implicitWidth: Kirigami.Units.iconSizes.sizeForLabels
                implicitHeight: Kirigami.Units.iconSizes.sizeForLabels

                anchors.verticalCenter: parent.verticalCenter

                source: modelData.icon.name.length > 0 ? modelData.icon.name : modelData.icon.source
                visible: modelData.visible
                enabled: modelData.enabled
                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.trigger()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    Row {
        id: rightActionsRow
        padding: Kirigami.Units.smallSpacing
        layoutDirection: Qt.RightToLeft
        anchors.right: parent.right
        anchors.rightMargin: Kirigami.Units.smallSpacing
        anchors.verticalCenter: parent.verticalCenter
        height: root.implicitHeight - 2 * Kirigami.Units.smallSpacing
        Repeater {
            model: root.rightActions
            Kirigami.Icon {
                implicitWidth: Kirigami.Units.iconSizes.sizeForLabels
                implicitHeight: Kirigami.Units.iconSizes.sizeForLabels

                anchors.verticalCenter: parent.verticalCenter

                source: modelData.icon.name.length > 0 ? modelData.icon.name : modelData.icon.source
                active: actionArea.containsPress
                visible: modelData.visible
                enabled: modelData.enabled
                MouseArea {
                    id: actionArea
                    anchors.fill: parent
                    onClicked: modelData.trigger()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
