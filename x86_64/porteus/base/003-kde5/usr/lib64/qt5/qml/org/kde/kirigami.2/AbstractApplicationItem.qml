/*
 *  SPDX-FileCopyrightText: 2017 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.12
import QtQml 2.14
import QtQuick.Templates 2.12 as T
import QtQuick.Window 2.12
import "templates/private"
import org.kde.kirigami 2.14

/**
 * An item that provides the features of AbstractApplicationWindow without the window itself.
 * This allows embedding into a larger application.
 * Unless you need extra flexibility it is recommended to use ApplicationItem instead.
 *
 * Example usage:
 * @code
 * import org.kde.kirigami 2.4 as Kirigami
 *
 * Kirigami.AbstractApplicationItem {
 *  [...]
 *     globalDrawer: Kirigami.GlobalDrawer {
 *         actions: [
 *            Kirigami.Action {
 *                text: "View"
 *                icon.name: "view-list-icons"
 *                Kirigami.Action {
 *                        text: "action 1"
 *                }
 *                Kirigami.Action {
 *                        text: "action 2"
 *                }
 *                Kirigami.Action {
 *                        text: "action 3"
 *                }
 *            },
 *            Kirigami.Action {
 *                text: "Sync"
 *                icon.name: "folder-sync"
 *            }
 *         ]
 *     }
 *
 *     contextDrawer: Kirigami.ContextDrawer {
 *         id: contextDrawer
 *     }
 *
 *     pageStack: Kirigami.PageRow {
 *         ...
 *     }
 *  [...]
 * }
 * @endcode
 *
 * @inherit QtQuick.Item
 */
Item {
    id: root

    /**
     * pageStack: StackView
     * 
     * The stack used to allocate the pages and to manage the transitions
     * between them.
     * 
     * Put a container here, such as QQuickControls StackView
     */
    property Item pageStack
    LayoutMirroring.enabled: Qt.application.layoutDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property alias overlay: overlayRoot
    Item {
        anchors.fill: parent
        parent: root.parent || root
        z: 999999
        Rectangle {
            z: -1
            anchors.fill: parent
            color: "black"
            visible: contextDrawer && contextDrawer.modal
            parent: contextDrawer ? contextDrawer.background.parent.parent : overlayRoot
            opacity: contextDrawer ? contextDrawer.position * 0.6 : 0
        }
        Rectangle {
            z: -1
            anchors.fill: parent
            color: "black"
            visible: globalDrawer && globalDrawer.modal
            parent: contextDrawer ? globalDrawer.background.parent.parent : overlayRoot
            opacity: contextDrawer ? globalDrawer.position * 0.6 : 0
        }
        Item {
            id: overlayRoot
            z: -1
            anchors.fill: parent
        }
        Window.onWindowChanged: {
            if (globalDrawer) {
                globalDrawer.visible = globalDrawer.drawerOpen;
            }
            if (contextDrawer) {
                contextDrawer.visible = contextDrawer.drawerOpen;
            }
        }
    }

    /**
     * This property exists for compatibility with Applicationwindow
     */
    readonly property Item activeFocusItem: Window.activeFocusItem

    /**
     * Shows a little passive notification at the bottom of the app window
     * lasting for few seconds, with an optional action button.
     *
     * @param message The text message to be shown to the user.
     * @param timeout How long to show the message:
     *            possible values: "short", "long" or the number of milliseconds
     * @param actionText Text in the action button, if any.
     * @param callBack A JavaScript function that will be executed when the
     *            user clicks the button.
     */
    function showPassiveNotification(message, timeout, actionText, callBack) {
        if (!internal.__passiveNotification) {
            var component = Qt.createComponent("templates/private/PassiveNotification.qml");
            internal.__passiveNotification = component.createObject(root);
        }

        internal.__passiveNotification.showNotification(message, timeout, actionText, callBack);
    }

    /**
     * font: font
     * 
     * This property holds the font for this item.
     */
    property font font: Theme.defaultFont

    /**
     * palette: palette
     * 
     * This property holds the palette for this item.
     */
    property var palette: Theme.palette

    /**
     * locale: Locale
     * 
     * This property holds the locale for this item.
     */
    property Locale locale

   /**
    * Hide the passive notification, if any is shown
    */
    function hidePassiveNotification() {
        if(internal.__passiveNotification) {
           internal.__passiveNotification.hideNotification();
        }
    }


    /**
     * @returns a pointer to this item.
     * 
     * It can be used anywhere in the application.
     */
    function applicationWindow() {
        return root;
    }

    /**
     * menuBar: Item
     * 
     * An item that can be used as a menuBar for the application.
     */
    property Item menuBar
    onMenuBarChanged: {
        menuBar.parent = root.contentItem
        if (menuBar.z === undefined) {
            menuBar.z = 1;
        }
        if (menuBar instanceof T.ToolBar) {
            menuBar.position = T.ToolBar.Footer
        } else if (menuBar instanceof T.TabBar) {
            menuBar.position = T.TabBar.Footer
        } else if (menuBar instanceof T.DialogButtonBox) {
            menuBar.position = T.DialogButtonBox.Footer
        }
        menuBar.width = Qt.binding(() => root.contentItem.width)
        //FIXME: (root.header.height ?? 0) when we can depend from 5.15
        menuBar.y = Qt.binding(() => -menuBar.height - (root.header.height ? root.header.height : 0))
    }

   /**
    * header: ApplicationHeader
    * 
    * An item that can be used as a title for the application.
    * 
    * Scrolling the main page will make it taller or shorter (trough the point of going away).
    * 
    * It's a behavior similar to the typical mobile web browser addressbar.
    * 
    * The minimum, preferred and maximum heights of the item can be controlled with
    * 
    * * Layout.minimumHeight: default is 0, i.e. hidden
    * * Layout.preferredHeight: default is Units.gridUnit * 1.6
    * * Layout.maximumHeight: default is Units.gridUnit * 3
    *
    * To achieve a titlebar that stays completely fixed, just set the 3 sizes as the same.
    */
    property Item header
    onHeaderChanged: {
        header.parent = root.contentItem
        if (header.z === undefined) {
            header.z = 1;
        }
        if (header instanceof T.ToolBar) {
            header.position = T.ToolBar.Header
        } else if (header instanceof T.TabBar) {
            header.position = T.TabBar.Header
        } else if (header instanceof T.DialogButtonBox) {
            header.position = T.DialogButtonBox.Header
        }
        header.width = Qt.binding(() => root.contentItem.width)
        header.y = Qt.binding(() => -header.height)
    }

    /**
     * footer: Item
     * 
     * An item that can be used as a footer for the application.
     */
    property Item footer
    onFooterChanged: {
        footer.parent = root.contentItem
        if (footer.z === undefined) {
            footer.z = 1;
        }
        if (footer instanceof T.ToolBar) {
            footer.position = T.ToolBar.Footer
        } else if (footer instanceof T.TabBar) {
            footer.position = T.TabBar.Footer
        } else if (footer instanceof T.DialogButtonBox) {
            footer.position = T.DialogButtonBox.Footer
        }
        footer.width = Qt.binding(() => root.contentItem.width)
        footer.y = Qt.binding(() => root.contentItem.height)
    }

    /**
     * controlsVisible: bool
     * 
     * This property controls whether the standard chrome of the app, such
     * as the Action button, the drawer handles and the application
     * header should be visible or not.
     */
    property bool controlsVisible: true

    /**
     * globalDrawer: OverlayDrawer
     * 
     * The drawer for global actions, that will be opened by sliding from the
     * left screen edge or by dragging the ActionButton to the right.
     * 
     * It is recommended to use the GlobalDrawer class here.
     */
    property OverlayDrawer globalDrawer

    /**
     * wideScreen: bool
     * 
     * If true the application is considered to be in "widescreen" mode, such as on desktops or horizontal tablets.
     * Different styles can have their own logic for deciding this.
     */
    property bool wideScreen: width >= Units.gridUnit * 60

    /**
     * contextDrawer: OverlayDrawer
     * 
     * The drawer for context-dependent actions, that will be opened by sliding from the
     * right screen edge or by dragging the ActionButton to the left.
     * It is recommended to use the ContextDrawer class here.
     * The contents of the context drawer should depend from what page is
     * loaded in the main pageStack
     *
     * Example usage:
     * @code
     * import org.kde.kirigami 2.4 as Kirigami
     *
     * Kirigami.ApplicationItem {
     *  [...]
     *     contextDrawer: Kirigami.ContextDrawer {
     *         id: contextDrawer
     *     }
     *  [...]
     * }
     * @endcode
     *
     * @code
     * import org.kde.kirigami 2.4 as Kirigami
     *
     * Kirigami.Page {
     *   [...]
     *     contextualActions: [
     *         Kirigami.Action {
     *             icon.name: "edit"
     *             text: "Action text"
     *             onTriggered: {
     *                 // do stuff
     *             }
     *         },
     *         Kirigami.Action {
     *             icon.name: "edit"
     *             text: "Action text"
     *             onTriggered: {
     *                 // do stuff
     *             }
     *         }
     *     ]
     *   [...]
     * }
     * @endcode
     *
     * When this page will be the current one, the context drawer will visualize
     * contextualActions defined as property in that page.
     */
    property OverlayDrawer contextDrawer

    /**
     * reachableMode: bool
     * 
     * When true the application is in reachable mode for single hand use.
     * 
     * The whole content of the application is moved down the screen to be
     * reachable with the thumb. If wideScreen is true, or reachableModeEnabled is false,
     * this property has no effect.
     */
    property bool reachableMode: false

    /**
     * When true the application will go into reachable mode on pull down
     */
    property bool reachableModeEnabled: true

    MouseArea {
        parent: root
        z: -1
        anchors.fill: parent
        onClicked: root.reachableMode = false;
        visible: root.reachableMode && root.reachableModeEnabled
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.3)
            opacity: 0.15
            Icon {
                anchors.horizontalCenter: parent.horizontalCenter
                y: x
                width: Units.iconSizes.large
                height: width
                source: "go-up"
            }
        }
    }

    /**
     * __data: list<Object>
     * 
     * This holds the list of all children of this item.
     */
    default property alias __data: contentItemRoot.data

    /**
     * contentItem: Item
     * 
     * This property holds the Item of the main part of the Application UI
     */
    readonly property Item contentItem: Item {
        id: contentItemRoot
        parent: root
        anchors {
            fill: parent
            topMargin: controlsVisible ? (root.header ? root.header.height : 0) + (root.menuBar ? root.menuBar.height : 0) : 0
            bottomMargin: controlsVisible && root.footer ? root.footer.height : 0
            leftMargin: root.globalDrawer && root.globalDrawer.modal === false ? root.globalDrawer.contentItem.width * root.globalDrawer.position : 0
            rightMargin: root.contextDrawer && root.contextDrawer.modal === false ? root.contextDrawer.contentItem.width * root.contextDrawer.position : 0
        }

        transform: Translate {
            Behavior on y {
                NumberAnimation {
                    duration: Units.longDuration
                    easing.type: Easing.InOutQuad
                }
            }
            y: root.reachableMode && root.reachableModeEnabled && !root.wideScreen ? root.height/2 : 0
            x: root.globalDrawer && root.globalDrawer.modal === true && root.globalDrawer.toString().indexOf("SplitDrawer") === 0 ? root.globalDrawer.contentItem.width * root.globalDrawer.position : 0
        }
    }

    /**
     * color: color
     * 
     * This property holds the color for the background.
     */
    property color color: Theme.backgroundColor

    /**
     * background: Item
     * 
     * This property holds the background of the Application UI
     */
    property Item background
    onBackgroundChanged: {
        background.parent = root.contentItem
        if (background.z === undefined) {
            background.z = -1;
        }
        background.anchors.fill = background.parent
    }

    //Don't want overscroll in landscape mode
    onWidthChanged: {
        if (width > height) {
            root.reachableMode = false;
        }
    }

    Binding {
        when: globalDrawer !== undefined && root.visible
        target: globalDrawer
        property: "parent"
        value: overlay
        restoreMode: Binding.RestoreBinding
    }
    Binding {
        when: contextDrawer !== undefined && root.visible
        target: contextDrawer
        property: "parent"
        value: overlay
        restoreMode: Binding.RestoreBinding
    }
    onPageStackChanged: pageStack.parent = root.contentItem;

    implicitWidth: Units.gridUnit * 30
    implicitHeight: Units.gridUnit * 45
    visible: true

    QtObject {
        id: internal
        property QtObject __passiveNotification
    }
}
