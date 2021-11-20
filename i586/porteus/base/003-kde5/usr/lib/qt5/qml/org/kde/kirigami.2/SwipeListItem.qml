/*
 *  SPDX-FileCopyrightText: 2010 Marco Martin <notmart@gmail.com>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.5
import "private"
import "templates" as T

/**
 * An item delegate Intended to support extra actions obtainable
 * by uncovering them by dragging away the item with the handle
 * This acts as a container for normal list items.
 * @code
 * ListView {
 *     model: myModel
 *     delegate: SwipeListItem {
 *         QQC2.Label {
 *             text: model.text
 *         }
 *         actions: [
 *              Action {
 *                  icon.name: "document-decrypt"
 *                  onTriggered: print("Action 1 clicked")
 *              },
 *              Action {
 *                  icon.name: model.action2Icon
 *                  onTriggered: //do something
 *              }
 *         ]
 *     }
 *
 * }
 * @endcode
 * @inherit org::kde::kirigami::templates::SwipeListItem
 */
T.SwipeListItem {
    id: listItem

    background: DefaultListItemBackground {}
}
