/*
 Copyright (c) 2008-2023, Benoit AUTHEMAN All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author or Destrat.io nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL AUTHOR BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//-----------------------------------------------------------------------------
// This file is a part of the QuickQanava software library.
//
// \file	RectShadowEffect.qml
// \author	benoit@destrat.io
// \date	2017 11 17
//-----------------------------------------------------------------------------

import QtQuick
import QtQuick.Effects

import QuickQanava    2.0 as Qan
import "qrc:/QuickQanava" as Qan

/*! \brief Node or group background component with solid fill, shadow effect and backOpacity style support
 *
 */
Item {
    id: shadowEffect

    // PUBLIC /////////////////////////////////////////////////////////////////
    property var    style: undefined

    // PRIVATE ////////////////////////////////////////////////////////////////
    // Default settings for rect radius, shadow margin is the _maximum_ shadow radius (+vertical or horizontal offset).
    readonly property real   borderWidth:   style ? style.borderWidth : 1.
    readonly property real   borderWidth2:  borderWidth / 2.
    readonly property real   shadowOffset:  style ? style.effectOffset : 3.
    readonly property real   shadowRadius:  style ? style.effectRadius : 3.
    readonly property color  shadowColor:   style ? style.effectColor : Qt.rgba(0.7, 0.7, 0.7, 0.7)
    readonly property real   backRadius:    style ? style.backRadius : 4.

    Rectangle {         // Hidden item used to generate shadow
        id: border
        anchors.fill: parent
        anchors.margins: 1
        visible: false
        radius: backRadius - 1      // -1 to avoid margin issue
        color: Qt.rgba(1, 1, 1, 1)
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 1)
    }

    MultiEffect {
        anchors.fill: parent
        anchors.margins: 1
        source: border
        autoPaddingEnabled: false
        paddingRect: Qt.rect(shadowOffset, shadowOffset,
                             parent.width + shadowOffset,
                             parent.height + shadowOffset)
        shadowEnabled: shadowEffect.style?.effectEnabled || false
        shadowColor: shadowColor
        shadowBlur: 0.9
        //shadowOpacity: 0.7
        blurMax: shadowRadius
        shadowHorizontalOffset: shadowOffset
        shadowVerticalOffset: shadowOffset
    }
}  // Item: shadowEffect
