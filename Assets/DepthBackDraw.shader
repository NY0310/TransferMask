Shader "Hidden/DepthBackDraw"
{
	SubShader
	{
		// No culling or depth
		ZTest Always
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry + 2000" }
		//	ZWrite On
			
       //Blend SrcAlpha OneMinusSrcAlpha 
		Pass
		{
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			sampler2D _CameraDepthTexture;
			float4 _CameraDepthTexture_ST;

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 screenPos : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.screenPos = ComputeScreenPos(o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 uv = i.screenPos.xy / i.screenPos.w;
				float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv);
				//depth = Linear01Depth(depth);
				float vertexDepth = i.vertex.z / i.vertex.w;
				return fixed4(depth,0,0,1);
			}
			ENDCG
		}
	}
}
