#include "UnityCG.cginc"

sampler2D _MainTex;
float4 _MainTex_TexelSize;

sampler2D _HighTex;
float4 _HighTex_TexelSize;

float _Threshold;
float _Intensity;
int _Xintense;
int _Yintense;
float _Blur;
half3 _Color;

// Prefilter: Shrink horizontally and apply threshold.
half4 frag_prefilter(v2f_img i) : SV_Target
{
    
    const float vscale = _Blur;
    const float dy = _MainTex_TexelSize.y * vscale / 2;

    half3 c0 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - dy));
    half3 c1 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + dy));
    half3 c = (c0 + c1) / 2;

    float br = max(c.r, max(c.g, c.b));
    c *= max(0, br - _Threshold) / max(br, 1e-5);

    return half4(c, 1);
}


half4 frag_down(v2f_img i) : SV_Target
{
 
    const float hscale = _Blur;
    const float dx = _MainTex_TexelSize.x * hscale;
     const float dy = _MainTex_TexelSize.y * hscale;

    float u0 = i.uv.x - dx * 8 * _Xintense;
    float u1 = i.uv.x - dx * 3* _Xintense;
    float u2 = i.uv.x - dx * 1* _Xintense;
    float u3 = i.uv.x + dx * 1* _Xintense;
    float u4 = i.uv.x + dx * 3* _Xintense;
    float u5 = i.uv.x + dx * 8* _Xintense;

    float y0 = i.uv.y - dy * 8 * _Yintense;
    float y1 = i.uv.y - dy * 3* _Yintense;
    float y2 = i.uv.y - dy * 1* _Yintense;
    float y3 = i.uv.y + dy * 1* _Yintense;
    float y4 = i.uv.y + dy * 3* _Yintense;
    float y5 = i.uv.y + dy * 8* _Yintense;

    half3 c0 = tex2D(_MainTex, float2(u0, y0));
    half3 c1 = tex2D(_MainTex, float2(u1, y1));
    half3 c2 = tex2D(_MainTex, float2(u2, y2));
    half3 c3 = tex2D(_MainTex, float2(u3, y3));
    half3 c4 = tex2D(_MainTex, float2(u4, y4));
    half3 c5 = tex2D(_MainTex, float2(u5, y5));


    half3 c = (c0 + c1 + c2 + c3 + c4 + c5) / 3;

    return half4(c, 1);
}

#if 1

half4 frag_up(v2f_img i) : SV_Target
{
    half3 c0 = tex2D(_MainTex, i.uv) / 4;
    half3 c1 = tex2D(_MainTex, i.uv) / 2;
    half3 c2 = tex2D(_MainTex, i.uv) / 4;
    half3 c3 = tex2D(_HighTex, i.uv);
    return half4(c0 + c1 + c2 + c3, 1);
}

half4 frag_composite(v2f_img i) : SV_Target
{
    half3 c0 = tex2D(_MainTex, i.uv) / 4;
    half3 c1 = tex2D(_MainTex, i.uv) / 2;
    half3 c2 = tex2D(_MainTex, i.uv) / 4;
    half3 c3 = tex2D(_HighTex, i.uv);
    return half4((c0 + c1 + c2) * _Color *_Intensity  + c3, 1);
}

#else

half4 frag_up(v2f_img i) : SV_Target
{
    half3 c0 = tex2D(_MainTex, i.uv) / 8;
    half3 c1 = tex2D(_MainTex, i.uv) / 4;
    half3 c2 = tex2D(_MainTex, i.uv) / 8;
    half3 c3 = tex2D(_HighTex, i.uv) / 2;
    return half4(c0 + c1 + c2 + c3, 1);
}

half4 frag_composite(v2f_img i) : SV_Target
{
    half3 c0 = tex2D(_MainTex, i.uv);
    half3 c1 = tex2D(_MainTex, i.uv) * 2;
    half3 c2 = tex2D(_MainTex, i.uv);
    half3 c3 = tex2D(_HighTex, i.uv);

    return half4((c0 + c1 + c2) / 4 * float3(0.04, 0.04, 0.3) * 8 + c3, 1);
}

#endif
