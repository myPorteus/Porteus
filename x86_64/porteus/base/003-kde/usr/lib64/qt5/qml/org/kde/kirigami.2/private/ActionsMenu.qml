/*
 *   Copyright 2018 Aleix Pol Gonzalez <aleixpol@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.3
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.4 as Kirigami

Controls.Menu
{
    id: theMenu
    property alias actions: actionsInstantiator.model
    property Component submenuComponent
    //renamed to work on both Qt 5.9 and 5.10
    property Component itemDelegate: Component {ActionMenuItem {}}
    property Component separatorDelegate: Component {
        Controls.MenuSeparator {
            contentItem: Rectangle {
                implicitHeight: Math.floor(Kirigami.Units.devicePixelRatio)
                color: Qt.tint(Kirigami.Theme.textColor, Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.7))
            }
        }
    }

    Item {
        id: invisibleItems
        visible: false
    }
    Instantiator {
        id: actionsInstantiator

        active: theMenu.visible
        delegate: QtObject {
            readonly property QtObject action: modelData
            property QtObject item: null

            function create() {
                if (!action.children || action.children.length === 0) {
                    if (action.hasOwnProperty("separator") && action.separator) {
                        item = theMenu.separatorDelegate.createObject(null, {});
                    }
                    else {
                        item = theMenu.itemDelegate.createObject(null, { ourAction: action });
                    }
                    theMenu.addItem(item)
                } else if (theMenu.submenuComponent) {
                    item = theMenu.submenuComponent.createObject(null, { title: action.text, actions: action.children });
                    theMenu.addMenu(item)
                }
            }
            function remove() {
                if (!action.children || action.children.length === 0) {
                    theMenu.removeItem(item)
                } else if (theMenu.submenuComponent) {
                    theMenu.removeMenu(item)
                }
            }
        }

        onObjectAdded: object.create()
        onObjectRemoved: object.remove()
    }
}
