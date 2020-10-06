Shader "Hidden/sciFiLensFlare / Sci-Fi Lens Flare"
{
    Properties
    {
        _MainTex("", 2D) = ""{}
        _HighTex("", 2D) = ""{}
        _Color("", Color) = (1, 1, 1)
        _Xintense ("", Int) = 0
        _Yintense ("", Int) = 0
        _Blur ("", Float) = 1
        [Gamma] _Intensity("", Float) = 1
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_prefilter
            #include "sciFiFlare.cginc"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_down
            #include "sciFiFlare.cginc"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_up
            #include "sciFiFlare.cginc"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_composite
            #include "sciFiFlare.cginc"
            ENDCG
        }
    }
}
