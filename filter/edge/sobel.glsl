/*
author: Brad Larson
description: |
    Adapted version of Sobel edge detection from https://github.com/BradLarson/GPUImage2.
use: edgeSobel(<sampler2D> texture, <vec2> st, <vec2> pixels_scale)
options:
    EDGESOBEL_TYPE: Return type, defaults to float
    EDGESOBEL_SAMPLER_FNC: Function used to sample the input texture, defaults to texture2D(tex,POS_UV).r
license:
    Copyright (c) 2015, Brad Larson.
    All rights reserved.
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are
    met

    Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

    Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
    HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#ifndef EDGESOBEL_TYPE
#define EDGESOBEL_TYPE float
#endif

#ifndef EDGESOBEL_SAMPLER_FNC
#define EDGESOBEL_SAMPLER_FNC(POS_UV) texture2D(tex,POS_UV).r
#endif

#ifndef FNC_EDGESOBEL
#define FNC_EDGESOBEL
EDGESOBEL_TYPE edgeSobel(in sampler2D tex, in vec2 st, in vec2 offset) {
    // get samples around pixel
    EDGESOBEL_TYPE tleft = EDGESOBEL_SAMPLER_FNC(st + vec2(-offset.x, offset.y));
    EDGESOBEL_TYPE left = EDGESOBEL_SAMPLER_FNC(st + vec2(-offset.x, 0.));
    EDGESOBEL_TYPE bleft = EDGESOBEL_SAMPLER_FNC(st + vec2(-offset.x, -offset.y));
    EDGESOBEL_TYPE top = EDGESOBEL_SAMPLER_FNC(st + vec2(0., offset.y));
    EDGESOBEL_TYPE bottom = EDGESOBEL_SAMPLER_FNC(st + vec2(0., -offset.y));
    EDGESOBEL_TYPE tright = EDGESOBEL_SAMPLER_FNC(st + offset);
    EDGESOBEL_TYPE right = EDGESOBEL_SAMPLER_FNC(st + vec2(offset.x, 0.));
    EDGESOBEL_TYPE bright = EDGESOBEL_SAMPLER_FNC(st + vec2(offset.x, -offset.y));
    EDGESOBEL_TYPE x = tleft + 2. * left + bleft - tright - 2. * right - bright;
    EDGESOBEL_TYPE y = -tleft - 2. * top - tright + bleft + 2. * bottom + bright;
    return sqrt((x * x) + (y * y));
}
#endif
