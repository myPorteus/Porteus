/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import org.kde.kirigami 2.12

Rectangle {
    id: background
    color: listItem.checked || listItem.highlighted || (listItem.supportsMouseEvents && listItem.pressed && !listItem.checked && !listItem.sectionDelegate)
        ? listItem.activeBackgroundColor
        : (listItem.alternatingBackground && index%2 ? listItem.alternateBackgroundColor : listItem.backgroundColor)

    visible: listItem.ListView.view ? listItem.ListView.view.highlight === null : true
    Rectangle {
        id: internal
        property bool indicateActiveFocus: listItem.pressed || Settings.tabletMode || listItem.activeFocus || (listItem.ListView.view ? listItem.ListView.view.activeFocus : false)
        anchors.fill: parent
        visible: !Settings.tabletMode && listItem.supportsMouseEvents
        color: listItem.activeBackgroundColor
        opacity: (listItem.hovered || listItem.highlighted || listItem.activeFocus) && !listItem.pressed ? 0.5 : 0
    }
                                               // Don't show separator when...
    readonly property bool __separatorVisible: listItem.separatorVisible
                                               // There's a colored rectangle
                                               && !listItem.highlighted
                                               && !listItem.pressed
                                               && !listItem.checked
                                               // ...Unless the colored rectangle is transparent
                                               && (!listItem.hovered || listItem.activeBackgroundColor.a == 0)
                                               // It would touch the section header
                                               && !listItem.sectionDelegate
                                               && (!!listItem.ListView.view ? listItem.ListView.nextSection == listItem.ListView.section : true)
                                               // This is the last item in the list
                                               // TODO: implement this

    property var leadingWidth

    Separator {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: Units.largeSpacing
            rightMargin: Units.largeSpacing
        }
        visible: background.__separatorVisible
        weight: Separator.Weight.Light
    }
}

