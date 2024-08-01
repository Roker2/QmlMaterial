pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import Qcm.Material as MD

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitHandleHeight + topPadding + bottomPadding)

    horizontalPadding: 0
    topInset: 0
    bottomInset: 0
    topPadding: 0
    bottomPadding: 0
    clip: false

    property vector2d overlay: new Qt.vector2d(0, 0)

    // The Slider is discrete if all of the following requirements are met:
    // * stepSize is positive
    // * snapMode is set to SnapAlways
    // * the difference between to and from is cleanly divisible by the stepSize
    // * the number of tick marks intended to be rendered is less than the width to height ratio, or vice versa for vertical sliders.
    readonly property real __steps: Math.abs(to - from) / stepSize
    readonly property bool __isDiscrete: stepSize >= Number.EPSILON && snapMode === Slider.SnapAlways && Math.abs(Math.round(__steps) - __steps) < Number.EPSILON && Math.floor(__steps) < (horizontal ? background.width / background.height : background.height / background.width)

    handle: MD.SliderHandle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        value: control.value
        handleHasFocus: control.visualFocus
        handlePressed: control.pressed
        handleHovered: control.hovered
    }

    background: Item {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : 4
        implicitHeight: control.horizontal ? 4 : 200

        Rectangle {
            anchors.centerIn: parent
            width: control.horizontal ? parent.width - (control.implicitHandleWidth - (control.__isDiscrete ? 4 : 0)) : 4
            height: control.horizontal ? 4 : parent.height - (control.implicitHandleHeight - (control.__isDiscrete ? 4 : 0))
            scale: control.horizontal && control.mirrored ? -1 : 1
            radius: Math.min(width, height) / 2
            color: control.trackInactiveColor

            Rectangle {
                visible: control.overlay.length() > 0
                x: control.horizontal ? control.overlay.x * parent.width : (parent.width - width) / 2
                y: control.horizontal ? (parent.height - height) / 2 : control.overlay.y * parent.height
                width: control.horizontal ? (control.overlay.y - control.overlay.x) * parent.width : 4
                height: control.horizontal ? 4 : (control.overlay.y - control.overlay.x) * parent.height
                radius: Math.min(width, height) / 2
                color: control.trackOverlayColor
                opacity: control.trackOverlayOpacity
            }

            Rectangle {
                x: control.horizontal ? 0 : (parent.width - width) / 2
                y: control.horizontal ? (parent.height - height) / 2 : control.visualPosition * parent.height
                width: control.horizontal ? control.position * parent.width : 4
                height: control.horizontal ? 4 : control.position * parent.height
                radius: Math.min(width, height) / 2
                color: control.trackColor
            }

            // Declaring this as a property (in combination with the parent binding below) avoids ids,
            // which prevent deferred execution.
            property Repeater repeater: Repeater {
                parent: control.background.children[0]
                model: control.__isDiscrete ? Math.floor(control.__steps) + 1 : 0
                delegate: Rectangle {
                    width: 2
                    height: 2
                    radius: 2
                    x: control.horizontal ? (parent.width - width * 2) * currentPosition + (width / 2) : (parent.width - width) / 2
                    y: control.horizontal ? (parent.height - height) / 2 : (parent.height - height * 2) * currentPosition + (height / 2)
                    color: active ? control.trackMarkColor : control.trackMarkInactiveColor

                    required property int index
                    readonly property real currentPosition: index / (parent.repeater.count - 1)
                    readonly property bool active: (control.horizontal && control.visualPosition > currentPosition) || (!control.horizontal && control.visualPosition <= currentPosition)
                }
            }
        }
    }
    property color trackColor: item_state.trackColor
    property color trackInactiveColor: item_state.trackInactiveColor
    property color trackOverlayColor: item_state.trackOverlayColor
    property real trackOverlayOpacity: 0.12

    property color trackMarkColor: MD.MatProp.supportTextColor
    property color trackMarkInactiveColor: item_state.trackMarkInactiveColor

    MD.MatProp.elevation: item_state.elevation
    MD.MatProp.textColor: item_state.textColor
    MD.MatProp.supportTextColor: item_state.supportTextColor
    MD.MatProp.backgroundColor: item_state.backgroundColor
    MD.MatProp.stateLayerColor: item_state.stateLayerColor

    MD.State {
        id: item_state
        item: control

        elevation: MD.Token.elevation.level0
        textColor: item_state.ctx.color.on_primary
        backgroundColor: item_state.ctx.color.primary
        supportTextColor: item_state.ctx.color.on_primary
        stateLayerColor: "#00000000"

        property color trackColor: MD.MatProp.backgroundColor
        property color trackOverlayColor: MD.MatProp.backgroundColor
        property color trackInactiveColor: item_state.ctx.color.surface_container_highest
        property color trackMarkInactiveColor: item_state.ctx.color.on_surface_variant

        states: [
            State {
                name: "Disabled"
                when: !control.enabled
                PropertyChanges {
                    item_state.textColor: item_state.ctx.color.on_surface
                    item_state.backgroundColor: item_state.ctx.color.on_surface
                    item_state.trackInactiveColor: item_state.ctx.color.on_surface

                    control.background.opacity: 0.38
                }
            },
            State {
                name: "Pressed"
                when: control.pressed || control.visualFocus
                PropertyChanges {
                    item_state.stateLayerColor: {
                        const c = item_state.ctx.color.primary;
                        return MD.Util.transparent(c, MD.Token.state.pressed.state_layer_opacity);
                    }
                }
            },
            State {
                name: "Hovered"
                when: control.hovered
                PropertyChanges {
                    item_state.stateLayerColor: {
                        const c = item_state.ctx.color.primary;
                        return MD.Util.transparent(c, MD.Token.state.hover.state_layer_opacity);
                    }
                }
            }
        ]
    }
}
