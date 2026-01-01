import QtQuick 2.15
import QtMultimedia 5.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: root
    width: 128
    height: 128

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    property bool isPlaying: false

    // 🎚 SETTINGS
    property real masterVolume:
        (plasmoid.configuration.volume ?? 100) / 100

    property real mikuChance:
        plasmoid.configuration.mikuChance ?? 0.5

    property real mikuVolume:
        (plasmoid.configuration.mikuVolume ?? 100) / 100

    property real engineerVolume:
        (plasmoid.configuration.engineerVolume ?? 100) / 100

    property url mikuSound:
        plasmoid.configuration.mikuSound && plasmoid.configuration.mikuSound !== ""
            ? plasmoid.configuration.mikuSound
            : Qt.resolvedUrl("../sounds/miku-fixed.wav")

    property url engineerSound:
        plasmoid.configuration.engineerSound && plasmoid.configuration.engineerSound !== ""
            ? plasmoid.configuration.engineerSound
            : Qt.resolvedUrl("../sounds/engineer.wav")

    AnimatedImage {
        id: display
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        playing: true
        source: Qt.resolvedUrl("../images/miku.png")
    }

    SoundEffect {
        id: sound
    }

    function resetToIdle() {
        root.isPlaying = false
        display.source = Qt.resolvedUrl("../images/miku.png")
        display.playing = true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.isPlaying)
                return

            root.isPlaying = true
            sound.stop()

            display.playing = false
            display.source = ""

            if (Math.random() < root.mikuChance) {
                // 💙 MIKU MODE
                display.speed = 4.0
                display.source = Qt.resolvedUrl("../images/4051639.gif")
                sound.volume = masterVolume * mikuVolume
                sound.source = mikuSound
            } else {
                // 🧰 ENGINEER MODE
                display.speed = 1.0
                display.source = Qt.resolvedUrl("../images/engineer-tf2.gif")
                sound.volume = masterVolume * engineerVolume
                sound.source = engineerSound
            }

            display.playing = true
            sound.play()
        }
    }

    Connections {
        target: sound
        function onPlayingChanged() {
            if (!sound.playing && root.isPlaying)
                resetToIdle()
        }
    }

    Component.onCompleted: {
        console.log("MIKU PLASMOID ONLINE 🟢")
        console.log("Miku sound:", mikuSound)
        console.log("Engineer sound:", engineerSound)
    }
}

