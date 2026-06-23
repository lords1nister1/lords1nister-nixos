{ pkgs, wallpaper ? null }:

pkgs.stdenv.mkDerivation {
  name = "sddm-blurry-bw";
  src = pkgs.emptyDirectory;
  dontUnpack = true;

  dontWrapQtApps = true;

  propagatedBuildInputs = [ pkgs.qt6.qt5compat ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes/blurry-bw
    
    ${if wallpaper != null then ''
      cp "${wallpaper}" $out/share/sddm/themes/blurry-bw/background.jpg
    '' else ""}

    cat << 'EOF' > $out/share/sddm/themes/blurry-bw/theme.conf
    [General]
    background=${if wallpaper != null then "background.jpg" else ""}
    blurRadius=60
    textColor="#ffffff"
    accentColor="#ffffff"
    boxBackgroundColor="#1a1a1a"
    EOF

    cat << 'EOF' > $out/share/sddm/themes/blurry-bw/metadata.desktop
    [Desktop Entry]
    General=
    Name=Blurry Black & White
    Comment=A minimalist blurry black and white SDDM theme
    Type=sddm-theme
    Version=1.0
    Author=AI Creator
    EOF

    cat << 'EOF' > $out/share/sddm/themes/blurry-bw/Main.qml
    import QtQuick
    import QtQuick.Controls
    import QtQuick.Layouts
    import Qt5Compat.GraphicalEffects

    Rectangle {
        id: container
        width: 1600
        height: 900
        color: "#000000"

        LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
        LayoutMirroring.childrenInherit: true

        Image {
            id: backgroundImage
            anchors.fill: parent
            source: config.background || ""
            fillMode: Image.PreserveAspectCrop
            visible: false
        }

        Desaturate {
            id: bwEffect
            anchors.fill: parent
            source: backgroundImage
            desaturation: 1.0
            visible: false
        }

        FastBlur {
            id: blurEffect
            anchors.fill: parent
            source: bwEffect
            radius: parseInt(config.blurRadius) || 50
        }

        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.4
        }

        Rectangle {
            id: loginBox
            width: 360
            height: 400
            radius: 12
            color: config.boxBackgroundColor || "#1a1a1a"
            border.color: config.accentColor || "#ffffff"
            border.width: 1
            anchors.centerIn: parent

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 35
                spacing: 20

                Text {
                    text: "ANMELDEN"
                    font.pixelSize: 22
                    font.bold: true
                    letterSpacing: 2
                    color: config.textColor || "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }

                Item { Layout.fillHeight: true }

                TextField {
                    id: usernameField
                    placeholderText: "Benutzername"
                    text: userModel.lastUser
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    color: "#ffffff"
                    placeholderTextColor: "#888888"
                    background: Rectangle {
                        color: "#000000"
                        radius: 6
                        border.color: usernameField.activeFocus ? config.accentColor : "#444444"
                    }
                }

                TextField {
                    id: passwordField
                    placeholderText: "Passwort"
                    echoMode: TextInput.Password
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    color: "#ffffff"
                    placeholderTextColor: "#888888"
                    focus: true
                    background: Rectangle {
                        color: "#000000"
                        radius: 6
                        border.color: passwordField.activeFocus ? config.accentColor : "#444444"
                    }
                    onAccepted: sddm.login(usernameField.text, passwordField.text, sessionIndex)
                }

                Item { Layout.fillHeight: true }

                Button {
                    id: loginButton
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: "LOGIN"
                        color: "#000000"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        color: config.accentColor || "#ffffff"
                        radius: 6
                    }
                    onClicked: sddm.login(usernameField.text, passwordField.text, sessionIndex)
                }
            }
        }
    }
    EOF
  '';
}

