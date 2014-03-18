Shader "RimLighting"
{
	Properties 
	{
_Texture("_Texture", 2D) = "black" {}
_Normals("_Normals", 2D) = "black" {}
_SpecularColor("_SpecularColor", Color) = (0.3006994,1,0,1)
_TextureStrength("_TextureStrength", Range(0,1) ) = 0.5
_BumpStrength("_BumpStrength", Range(0,10) ) = 0.5
_SpecularStrength("_SpecularStrength", Range(0,5) ) = 0.5
_Glossiness("_Glossiness", Range(0.1,1) ) = 0.4300518
_ColorOverlay("_ColorOverlay", Color) = (1,1,1,1)
_ColorOverlayStrength("_ColorOverlayStrength", Range(0,5) ) = 0.5

	}
	
	SubShader 
	{
		Tags
		{
"Queue"="Geometry"
"IgnoreProjector"="False"
"RenderType"="Opaque"

		}

		
Cull Back
ZWrite On
ZTest LEqual
ColorMask RGBA
Fog{
}


		CGPROGRAM
#pragma surface surf BlinnPhongEditor  vertex:vert
#pragma target 2.0


sampler2D _Texture;
sampler2D _Normals;
float4 _SpecularColor;
float _TextureStrength;
float _BumpStrength;
float _SpecularStrength;
float _Glossiness;
float4 _ColorOverlay;
float _ColorOverlayStrength;

			struct EditorSurfaceOutput {
				half3 Albedo;
				half3 Normal;
				half3 Emission;
				half3 Gloss;
				half Specular;
				half Alpha;
				half4 Custom;
			};
			
			inline half4 LightingBlinnPhongEditor_PrePass (EditorSurfaceOutput s, half4 light)
			{
half3 spec = light.a * s.Gloss;
half4 c;
c.rgb = (s.Albedo * light.rgb + light.rgb * spec);
c.a = s.Alpha;
return c;

			}

			inline half4 LightingBlinnPhongEditor (EditorSurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
			{
				half3 h = normalize (lightDir + viewDir);
				
				half diff = max (0, dot ( lightDir, s.Normal ));
				
				float nh = max (0, dot (s.Normal, h));
				float spec = pow (nh, s.Specular*128.0);
				
				half4 res;
				res.rgb = _LightColor0.rgb * diff;
				res.w = spec * Luminance (_LightColor0.rgb);
				res *= atten * 2.0;

				return LightingBlinnPhongEditor_PrePass( s, res );
			}
			
			struct Input {
				float2 uv_Texture;
float2 uv_Normals;

			};

			void vert (inout appdata_full v, out Input o) {
float4 VertexOutputMaster0_0_NoInput = float4(0,0,0,0);
float4 VertexOutputMaster0_1_NoInput = float4(0,0,0,0);
float4 VertexOutputMaster0_2_NoInput = float4(0,0,0,0);
float4 VertexOutputMaster0_3_NoInput = float4(0,0,0,0);


			}
			

			void surf (Input IN, inout EditorSurfaceOutput o) {
				o.Normal = float3(0.0,0.0,1.0);
				o.Alpha = 1.0;
				o.Albedo = 0.0;
				o.Emission = 0.0;
				o.Gloss = 0.0;
				o.Specular = 0.0;
				o.Custom = 0.0;
				
float4 Multiply3=_ColorOverlayStrength.xxxx * _ColorOverlay;
float4 Tex2D0=tex2D(_Texture,(IN.uv_Texture.xyxy).xy);
float4 Multiply2=Tex2D0 * _TextureStrength.xxxx;
float4 Add0=Multiply3 + Multiply2;
float4 Tex2DNormal0=float4(UnpackNormal( tex2D(_Normals,(IN.uv_Normals.xyxy).xy)).xyz, 1.0 );
float4 Multiply1=Tex2DNormal0 * _BumpStrength.xxxx;
float4 Multiply0=_SpecularColor * _SpecularStrength.xxxx;
float4 Master0_2_NoInput = float4(0,0,0,0);
float4 Master0_7_NoInput = float4(0,0,0,0);
float4 Master0_6_NoInput = float4(1,1,1,1);
o.Albedo = Add0;
o.Normal = Multiply1;
o.Specular = _Glossiness.xxxx;
o.Gloss = Multiply0;
o.Alpha = Tex2D0.aaaa;

				o.Normal = normalize(o.Normal);
			}
		ENDCG
	}
	Fallback "Diffuse"
}