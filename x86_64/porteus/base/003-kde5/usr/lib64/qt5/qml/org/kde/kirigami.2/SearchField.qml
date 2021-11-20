/*
 *  SPDX-FileCopyrightText: 2019 Carl-Lucien Schwan <carl@carlschwan.eu>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.6
import QtQuick.Controls 2.1 as Controls
import org.kde.kirigami 2.16 as Kirigami

/**
 * This is a standard textfield following KDE HIG. Using Ctrl+F as focus
 * sequence and "Search..." as placeholder text.
 *
 * Example usage for the search field component:
 * @code
 * import org.kde.kirigami 2.8 as Kirigami
 *
 * Kirigami.SearchField {
 *     id: searchField
 *     onAccepted: console.log("Search text is " + searchField.text)
 * }
 * @endcode
 *
 * @inherit org::kde::kirgami::ActionTextField
 */
Kirigami.ActionTextField
{
    id: root
    /**
     * Determines whether the accepted signal will be fired automatically
     * when the text is changed. Setting this to false will require that
     * the user presses return or enter (the same way a QML.TextInput
     * works).
     *
     * The default value is true
     *
     * @since 5.81
     * @since org.kde.kirigami 2.16
     */
    property bool autoAccept: true
    /**
     * Delays the automatic acceptance of the input further (by 2.5 seconds).
     * Set this to true if your search is expensive (such as for online
     * operations or in exceptionally slow data sets).
     *
     * \note If you must have immediate feedback (filter-style), use the
     * text property directly instead of accepted()
     *
     * The default value is false
     *
     * @since 5.81
     * @since org.kde.kirigami 2.16
     */
    property bool delaySearch: false

    placeholderText: qsTr("Search…")

    Accessible.name: qsTr("Search")
    Accessible.searchEdit: true

    focusSequence: "Ctrl+F"
    rightActions: [
        Kirigami.Action {
            icon.name: root.LayoutMirroring.enabled ? "edit-clear-locationbar-ltr" : "edit-clear-locationbar-rtl"
            visible: root.text.length > 0
            onTriggered: {
                root.text = "";
                // Since we are always sending the accepted signal here (whether or not the user has requested
                // that the accepted signal be delayed), stop the delay timer that gets started by the text changing
                // above, so that we don't end up sending two of those in rapid succession.
                fireSearchDelay.stop();
                root.accepted();
            }
        }
    ]

    Timer {
        id: fireSearchDelay
        interval: root.delaySearch ? Kirigami.Units.humanMoment : Kirigami.Units.shortDuration
        running: false; repeat: false;
        onTriggered: {
            root.accepted();
        }
    }
    onAccepted: {
        fireSearchDelay.running = false
    }
    onTextChanged: {
        if (root.autoAccept) {
            fireSearchDelay.restart();
        } else {
            fireSearchDelay.stop();
        }
    }
}
