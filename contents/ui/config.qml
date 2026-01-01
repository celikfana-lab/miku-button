import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import Qt.labs.platform 1.1 as Platform

Kirigami.FormLayout {
    id: page

    // 🧠 config bindings
    property alias cfg_volume: volumeSlider.value
    property alias cfg_mikuChance: mikuChanceSlider.value
    property alias cfg_mikuVolume: mikuVolumeSlider.value
    property alias cfg_engineerVolume: engineerVolumeSlider.value
    property alias cfg_mikuSound: mikuSoundPath.text
    property alias cfg_engineerSound: engineerSoundPath.text

    // 🔊 MASTER
    Slider {
        id: volumeSlider
        from: 0
        to: 100
        stepSize: 1
        Kirigami.FormData.label: "Master volume"
    }

    // 🎲 RNG
    Slider {
        id: mikuChanceSlider
        from: 0
        to: 1
        stepSize: 0.05
        Kirigami.FormData.label: "Miku chance"
    }

    Label {
        text: Math.round(mikuChanceSlider.value * 100) + "% Miku"
        opacity: 0.6
    }

    // 🔊 MIKU VOL
    Slider {
        id: mikuVolumeSlider
        from: 0
        to: 100
        stepSize: 1
        Kirigami.FormData.label: "Miku volume"
    }

    // 🔊 ENGINEER VOL
    Slider {
        id: engineerVolumeSlider
        from: 0
        to: 100
        stepSize: 1
        Kirigami.FormData.label: "Engineer volume"
    }

    // 🎧 MIKU AUDIO PICKER
    Row {
        spacing: 6
        Kirigami.FormData.label: "Miku audio"

        TextField {
            id: mikuSoundPath
            readOnly: true
            width: 260
            placeholderText: "Select audio file"
        }

        Button {
            text: "Browse"
            onClicked: mikuDialog.open()
        }
    }

    PlasmaComponents.FileDialog {
        id: mikuDialog
        title: "Choose Miku audio"
        folder: Platform.StandardPaths.writableLocation(
                    Platform.StandardPaths.HomeLocation)
        nameFilters: ["Audio files (*.wav *.ogg *.mp3)"]
        onAccepted: {
            mikuSoundPath.text = file
            console.log("MIKU AUDIO:", file)
        }
    }

    // 🎧 ENGINEER AUDIO PICKER
    Row {
        spacing: 6
        Kirigami.FormData.label: "Engineer audio"

        TextField {
            id: engineerSoundPath
            readOnly: true
            width: 260
            placeholderText: "Select audio file"
        }

        Button {
            text: "Browse"
            onClicked: engineerDialog.open()
        }
    }

    PlasmaComponents.FileDialog {
        id: engineerDialog
        title: "Choose Engineer audio"
        folder: Platform.StandardPaths.writableLocation(
                    Platform.StandardPaths.HomeLocation)
        nameFilters: ["Audio files (*.wav *.ogg *.mp3)"]
        onAccepted: {
            engineerSoundPath.text = file
            console.log("ENGINEER AUDIO:", file)
        }
    }
}



