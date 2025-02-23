import QtQuick 2.15
import QtQuick.Controls 2.15
// import Qt5Compat.GraphicalEffects

Button
{
    id: sideBtn
    text: qsTr("Left Menu Text")
    icon.color: "#ffffff"
    font.pointSize: 14

    // CUSTOM PROPERTIES
    property url btnIconSource: "qrc:/UI/Assets/custom_button.png"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    property int iconWidth: 30
    property int iconHeight: 30
    property color activeMenuColor: "#55aaff"
    property color activeMenuColorRight: "#2c313c"
    property bool isActiveMenu: false

    QtObject{
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor:
            if(sideBtn.down)
            {
                sideBtn.down ? btnColorClicked : btnColorDefault
            }
            else
            {
                sideBtn.hovered ? btnColorMouseOver : btnColorDefault
            }

    }

    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Rectangle{
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 3
            visible: isActiveMenu
        }

        Rectangle{
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuColorRight
            width: 5
            visible: isActiveMenu
        }

    }

    contentItem: Item{
        anchors.fill: parent
        id: content
        Image {
            id: imageBtn
            source: btnIconSource
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: true
            antialiasing: true
        }

        Text{
            color: "#ffffff"
            text: sideBtn.text
            font: sideBtn.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }
}
