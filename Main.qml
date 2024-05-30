import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import BeerLeague

ApplicationWindow {
    id: root
    width: 640
    height: 480
    visible: true
    visibility: "FullScreen"
    title: qsTr("Beer League Scoreboard")

    FontLoader {
        id: ledFont
        source: "qrc:/ledfont.ttf"
    }

    MediaPlayer {
        id: hornMediaplayer
        property int indexSong: 0
        source: "qrc:/horn%1.mp3".arg(indexSong)
        audioOutput: AudioOutput {}
        onPlayingChanged: () => {
            if(!playing) {
                indexSong = (indexSong + 1) % 4
            }
        }
    }

    Row {
        id: scoresLayout
        anchors.centerIn: parent

        MediaPlayer {
            id: introMediaplayer
            property int indexSong: 0
            source: "qrc:/intro%1.mp3".arg(indexSong)
            audioOutput: AudioOutput {}
            onPlayingChanged: () => {
                if(!introMediaplayer.playing) {
                    indexSong = (indexSong + 1) % 4
                    if(introButton.playing) {
                        // Continue playing
                        play()
                    }
                }

                console.log("MEDIA PLAYING CHANGED " + playing)
            }
        }
        Column {

            Button {
                id: introButton
                text: playing ? "STOP INTRO" : "INTRO"
                implicitWidth: 128
                implicitHeight: 64
                property bool playing: false
                onClicked: {
                    if(!playing) {
                        introButton.playing = true
                        introMediaplayer.play()
                    } else {
                        introButton.playing = false
                        introMediaplayer.stop()
                    }
                }
            }
            Button {
                id: lineupButton
                text: "LINEUP"
                implicitWidth: 128
                implicitHeight: 64
                property bool playing: false
                onClicked: {
                    if(!playing) {
                        introButton.playing = true
                        introMediaplayer.play()
                    } else {
                        introButton.playing = false
                        introMediaplayer.stop()
                    }
                }
            }
        }

        Score {
            color: "red"
            implicitWidth: root.width * 0.4
            implicitHeight: root.height * 0.8
            goalEnabled: !hornMediaplayer.playing
            onGoalScored: () => {
                hornMediaplayer.play()
            }
        }

        Score {
            color: "white"
            implicitWidth: root.width * 0.4
            implicitHeight: root.height * 0.8
            goalEnabled: !hornMediaplayer.playing
            onGoalScored: () => {
                hornMediaplayer.play()
            }
        }
    }
}
