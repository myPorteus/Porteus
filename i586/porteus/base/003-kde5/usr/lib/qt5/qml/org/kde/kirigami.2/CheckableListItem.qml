/*
 *  SPDX-FileCopyrightText: 2020 Nate Graham <nate@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as QQC2
import org.kde.kirigami 2.14 as Kirigami

/**
 * A simple subclass of BasicListItem that adds a checkbox on the left side of
 * the layout. The list item's own checked: property controls the check state
 * of the checkbox.
 *
 * When the list item or its checkbox is clicked, the QQC2 action specified in
 * the' list item's actions: property will be triggered.
 *
 * @note Due to the way BasicListItem works, the QQC2 action MUST contain the
 * line "checked = !checked" as the first line within its "onTriggered:" handler.
 *
 * Example usage:
 *
 * @code{.qml}
 * import org.kde.kirigami 2.14 as Kirigami
 *
 * ListView {
 *     id: listView
 *     model: [...]
 *     delegate: Kirigami.CheckableListItem {
 *         label: model.display
 *
 *         checked: model.checked
 *
 *         action: Action {
 *             onTriggered: {
 *                 checked = !checked
 *                 [ do something amazing ]
 *             }
 *         }
 *     }
 * }
 * @endcode
 * @since 2.14
 * @inherit org::kde::kirigami::BasicListItem
 */
Kirigami.BasicListItem {
    id: checkableListItem

    checkable: true
    activeBackgroundColor: "transparent"
    activeTextColor: Kirigami.Theme.textColor

    leading: QQC2.CheckBox {
        checked: checkableListItem.checked
        onToggled: {
            checkableListItem.action.trigger();
        }
    }
}
