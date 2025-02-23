import QtQuick 2.15
import QtQuick.Controls 2.15

Item
{
    Rectangle
    {
        id: rectangle
        color: "#232f4f"
        anchors.fill: parent

        Slider
        {
            id: hueSlider
            from: 0
            to: 359
            value: 180
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width * 0.3
            height: parent.height * 0.1
            background: Rectangle
            {
                height: 10
                width: hueSlider.width
                radius: 10
                anchors.centerIn: parent
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "red" }
                    GradientStop { position: 0.16; color: "yellow" }
                    GradientStop { position: 0.33; color: "green" }
                    GradientStop { position: 0.5; color: "cyan" }
                    GradientStop { position: 0.66; color: "blue" }
                    GradientStop { position: 0.83; color: "magenta" }
                    GradientStop { position: 1.0; color: "red" }
                }
            }
            handle: Rectangle
            {
                x: hueSlider.leftPadding  + hueSlider.visualPosition * (hueSlider.availableWidth- width)
                y: hueSlider.topPadding + hueSlider.availableHeight / 2 - height / 2
                width: hueSlider.height / 2
                height: hueSlider.height / 2
                radius: width / 2
                color: Qt.hsla(hueSlider.value / 359.0, 1, 0.5, 1)
            }
        }

        Image
        {
            id: ledStripModel
            source: "qrc:/Images/LedStripModel2.png"
            anchors.top: hueSlider.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Row
        {
            id: ledRow1
            anchors
            {
                top: ledStripModel.top
                topMargin: ledStripModel.height * 0.175
                left: ledStripModel.left
                leftMargin: ledStripModel.width * 0.061
            }
            spacing: ledStripModel.width * 0.006

            Repeater {
                id: repeater1

                model: 15

                Button
                {
                    id: ledBtn
                    width: ledStripModel.width * 0.053
                    height: ledStripModel.height * 0.165
                    text: index
                    background: Rectangle
                    {
                        id: bg
                        radius: 5
                    }

                    onClicked:
                    {
                        bg.color = hueSlider.handle.color
                        tcpClient.operation = "D1 " + index + " "
                                + bg.color.hsvHue * 359 + " 100 100"
                    }
                }
            }
        }
        Row
        {
            id: ledRow2
            anchors
            {
                top: ledStripModel.top
                topMargin: ledStripModel.height * 0.7
                left: ledStripModel.left
                leftMargin: ledStripModel.width * 0.061
            }
            spacing: ledStripModel.width * 0.006

            Repeater
            {
                id: repeater2

                model: 15

                Button
                {
                    id: ledBtn2
                    width: ledStripModel.width * 0.053
                    height: ledStripModel.height * 0.165
                    text: index + 15
                    background: Rectangle
                    {
                        id: bg2
                        radius: 5
                    }

                    onClicked:
                    {
                        bg2.color = hueSlider.handle.color
                        tcpClient.operation = "D1 " + (index + 15) + " "
                                + bg2.color.hsvHue * 359 + " 100 100"
                    }
                }
            }
        }
    }
}
