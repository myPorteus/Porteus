/*
 *   Copyright 2018 Marco Martin <mart@kde.org>
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

import QtQuick 2.6
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.5 as Kirigami
import "private"

/**
 * This is a simple toolbar built out of a list of actions
 * each action is represented by a ToolButton, those that won't fit
 * the size will go in a menu under a button with the overflow ... icon
 *
 * @inherits Item
 * @since 2.5
 */
Item {
    id: root
    /**
    * actions: list<Action>
    * if the card should provide clickable actions, put them in this property,
    * they will be put in the footer as a list of ToolButtons plus an optional
    * overflow menu, when not all of them will fit in the available Card width.
    */
    property list<QtObject> actions

    /**
    * actions: hiddenActions<Action>
    * This list of actions is for those you always want in the menu, even if there
    * is enough space.
    * @since 2.6
    */
    property list<QtObject> hiddenActions

    /**
     * flat: bool
     * Wether we want our buttons to have a flat appearance. Default: true
     */
    property bool flat: true

    implicitHeight: actionsLayout.implicitHeight

    implicitWidth: {
        var width = 0;
        for (var i = 0; i < actionsLayout.children.length; ++i) {
            if (actionsLayout.children[i].kirigamiAction && actionsLayout.children[i].kirigamiAction.visible) {
                width += actionsLayout.children[i].implicitWidth + actionsLayout.spacing;
            }
        }
        width += moreButton.width;
        return width;
    }

    Layout.maximumWidth: implicitWidth
    Layout.fillWidth: true

    RowLayout {
        id: actionsLayout
        anchors.fill: parent
        //anchors.rightMargin: moreButton.width
        
        spacing: Kirigami.Units.smallSpacing
        property var overflowSet: []

        // TODO use Array.findIndex once we depend on Qt 5.9
        function findIndex(array, cb) {
            for (var i = 0, length = array.length; i < length; ++i) {
                if (cb(array[i])) {
                    return i;
                }
            }
            return -1;
        }

        Repeater {
            model: root.actions
            delegate: PrivateActionToolButton {
                id: actionDelegate
                flat: root.flat
                readonly property bool fits: {
                    var minX = 0;
                    for (var i = 0; i < index; ++i) {
                        if (actionsLayout.children[i].visible) {
                            minX += actionsLayout.children[i].implicitWidth + actionsLayout.spacing;
                        }
                    }
                    return minX + implicitWidth < actionsLayout.width - moreButton.width
                }

                visible: modelData.visible && fits
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                Layout.minimumWidth: implicitWidth
                kirigamiAction: modelData
                onFitsChanged: updateOverflowSet()
                function updateOverflowSet() {
                    var index = actionsLayout.findIndex(actionsLayout.overflowSet, function(act) {
                        return act === modelData});

                    if ((fits || !modelData.visible) && index > -1) {
                        actionsLayout.overflowSet.splice(index, 1);
                    } else if (!fits && modelData.visible && index === -1) {
                        actionsLayout.overflowSet.push(modelData);
                    }
                    actionsLayout.overflowSetChanged();
                }
                Connections {
                    target: modelData
                    onVisibleChanged: actionDelegate.updateOverflowSet();
                }
                Component.onCompleted: {
                    actionDelegate.updateOverflowSet();
                }
            }
        }
        Controls.ToolButton {
            id: moreButton

            Layout.alignment: Qt.AlignRight
            Kirigami.Icon {
                anchors.fill: parent
                source: "overflow-menu"
                anchors.margins: 4
            }

            //checkable: true
            checked: menu.visible
            visible: hiddenActions.length > 0 || actionsLayout.overflowSet.length > 0;
            onClicked: menu.visible ? menu.close() : menu.open()

            ActionsMenu {
                id: menu
                y: -height
                x: -width + moreButton.width
                actions: root.actions
                submenuComponent: Component {
                    ActionsMenu {}
                }
                itemDelegate: ActionMenuItem {
                    visible: actionsLayout.findIndex(actionsLayout.overflowSet, function(act) {return act === ourAction}) > -1 && (ourAction.visible === undefined || ourAction.visible)
                }
                Instantiator {

                    model: root.hiddenActions
                    delegate: QtObject {
                        readonly property QtObject action: modelData
                        property QtObject item: null

                        Component.onDestruction: if (item) item.destroy()

                        function create() {
                            if (!action.children || action.children.length === 0) {
                                item = menu.itemDelegate.createObject(null, { ourAction: action });
                                menu.addItem(item)
                            } else if (menu.submenuComponent) {
                                item = menu.submenuComponent.createObject(null, { title: action.text, actions: action.children });
                                menu.addMenu(item)
                            }
                            //break the binding
                            item.visible = true;
                        }
                        function remove() {
                            if (!action.children || action.children.length === 0) {
                                menu.removeItem(item)
                            } else if (menu.submenuComponent) {
                                menu.removeMenu(item)
                            }
                        }
                    }

                    onObjectAdded: object.create()
                    onObjectRemoved: object.remove()
                }
            }
        }
    }
}
