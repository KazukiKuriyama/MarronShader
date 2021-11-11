Shader "Holistic/CutoffWithDiffuse" {
    Properties {
      _MainTex ("Base (RGB)", 2D) = "white" { }
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
      _StripeWidth ("StripeWidth", Range(1,20)) = 10
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float2 uv_MainTex;
          float3 viewDir;
          float3 worldPos;
      };

      sampler2D _MainTex;
      float4 _RimColor;
      float _RimPower;
      float _StripeWidth;

      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
          half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
          o.Emission = frac(IN.worldPos.y*(20-_StripeWidth) * 0.5) > 0.4 ? 
                          float3(0,1,0)*rim: float3(1,0,0)*rim;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }