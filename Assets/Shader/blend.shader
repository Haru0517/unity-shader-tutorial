Shader "Custom/blend"
{
    Properties {
		_MainTex ("Main Texture", 2D) = "white" {}
		_SubTex ("Sub Texture", 2D) = "white" {}
		_MaskTex ("Mask Texture", 2D) = "white" {}	
        _Strength ("Strength", float) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		Cull off
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SubTex;
		sampler2D _MaskTex;
        float _Strength;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c1 = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 c2 = tex2D (_SubTex,  IN.uv_MainTex);
			fixed4 p  = tex2D (_MaskTex, IN.uv_MainTex);
			o.Albedo = lerp(c1, c2, clamp(p*_Strength, 0, 1));			
		}
		ENDCG
	}
	FallBack "Diffuse"
}