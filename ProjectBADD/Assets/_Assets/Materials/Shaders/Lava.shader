Shader "ShaderEditor/EditorShaderCache"
{
	Properties 
	{
_MeshTexture("_MeshTexture", 2D) = "black" {}
_MeshNormals("_MeshNormals", 2D) = "black" {}
_MeshSpec("_MeshSpec", 2D) = "black" {}
_ElementTexture("_ElementTexture", 2D) = "bump" {}
_ElementNormals("_ElementNormals", 2D) = "white" {}
_ReflectionColor("_ReflectionColor", Color) = (0.5970149,0.5970149,0.5970149,1)
_SpecularColor("_SpecularColor", Color) = (0.8955224,0.5736166,0.07351302,1)
_Shininess("_Shininess", Range(0.1,4) ) = 4
_ElementSpeed("_ElementSpeed", Float) = -0.3
_ElementTextureStrength("_ElementTextureStrength", Range(0,1) ) = 0.024
_MeshBumpStrength("_MeshBumpStrength", Range(0,2) ) = 0.288
_MeshTextureStrength("_MeshTextureStrength", Range(0,1) ) = 0.5
_EditorTime("_EditorTime",Vector) = (0.0,0.0,0.0,0.0)

	}
	
	SubShader 
	{
		Tags
		{
"Queue"="Transparent"
"IgnoreProjector"="False"
"RenderType"="Transparent"

		}

		
Cull Back
ZWrite On
ZTest LEqual
ColorMask RGBA
Blend SrcColor Zero
Fog{
}


		CGPROGRAM
#pragma surface surf BlinnPhongEditor  exclude_path:prepass vertex:vert
#pragma target 3.0


sampler2D _MeshTexture;
sampler2D _MeshNormals;
sampler2D _MeshSpec;
sampler2D _ElementTexture;
sampler2D _ElementNormals;
float4 _ReflectionColor;
float4 _SpecularColor;
float _Shininess;
float _ElementSpeed;
float _ElementTextureStrength;
float _MeshBumpStrength;
float _MeshTextureStrength;
float4 _EditorTime;

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
				float2 uv_MeshTexture;
float2 uv_ElementTexture;
float2 uv_MeshNormals;
float2 uv_ElementNormals;
float2 uv_MeshSpec;

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
				
float4 Tex2D2=tex2D(_MeshTexture,(IN.uv_MeshTexture.xyxy).xy);
float4 Multiply3=_ElementSpeed.xxxx * _EditorTime;
float4 UV_Pan1=float4((IN.uv_ElementTexture.xyxy).x + Multiply3.x,(IN.uv_ElementTexture.xyxy).y + Multiply3.x,(IN.uv_ElementTexture.xyxy).z,(IN.uv_ElementTexture.xyxy).w);
float4 Tex2D4=tex2D(_ElementTexture,UV_Pan1.xy);
float4 Multiply4=Tex2D4 * _ElementTextureStrength.xxxx;
float4 Add1=Tex2D2 + Multiply4;
float4 Tex2DNormal0=float4(UnpackNormal( tex2D(_MeshNormals,(IN.uv_MeshNormals.xyxy).xy)).xyz, 1.0 );
float4 Multiply5=Tex2DNormal0 * _MeshBumpStrength.xxxx;
float4 Multiply2=_ElementSpeed.xxxx * _EditorTime;
float4 UV_Pan0=float4((IN.uv_ElementNormals.xyxy).x + Multiply2.x,(IN.uv_ElementNormals.xyxy).y + Multiply2.x,(IN.uv_ElementNormals.xyxy).z,(IN.uv_ElementNormals.xyxy).w);
float4 Tex2D0=tex2D(_ElementNormals,UV_Pan0.xy);
float4 UnpackNormal0=float4(UnpackNormal(Tex2D0).xyz, 1.0);
float4 Add0=Multiply5 + UnpackNormal0;
float4 Tex2D3=tex2D(_MeshSpec,(IN.uv_MeshSpec.xyxy).xy);
float4 Multiply6=Tex2D3 * _MeshTextureStrength.xxxx;
float4 Multiply0=_ReflectionColor * Multiply6;
float4 Multiply7=_ElementSpeed.xxxx * _EditorTime;
float4 UV_Pan2=float4((IN.uv_ElementTexture.xyxy).x + Multiply7.x,(IN.uv_ElementTexture.xyxy).y + Multiply7.x,(IN.uv_ElementTexture.xyxy).z,(IN.uv_ElementTexture.xyxy).w);
float4 Tex2D1=tex2D(_ElementTexture,UV_Pan2.xy);
float4 Multiply1=_Shininess.xxxx * Tex2D3;
float4 Master0_5_NoInput = float4(1,1,1,1);
float4 Master0_7_NoInput = float4(0,0,0,0);
float4 Master0_6_NoInput = float4(1,1,1,1);
o.Albedo = Add1;
o.Normal = Add0;
o.Emission = Multiply0;
o.Specular = Tex2D1.aaaa;
o.Gloss = Multiply1;

				o.Normal = normalize(o.Normal);
			}
		ENDCG
	}
	Fallback "Diffuse"
}