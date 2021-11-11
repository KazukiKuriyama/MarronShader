Shader "Marron/Rim" {
  // Inspectorからアクセス可能にする
  Properties {
    _texture("Texture", 2D) = "white" {}
    _RimColor("RimColor", Color) = (0.5,0.5,0.5,0.0)
    _RimPower("RimPower", Range(0.5,8.0)) = 3.0
  }
  // シェーダー本体
  SubShader {
    // 記述言語
    CGPROGRAM // C for Graphic

    // Surface Shader関数の関数名をsurfとして定義、
    #pragma surface surf Lambert
    sampler2D _texture; // プロパティの"Texture"をシェーダー内で仕様できるようにする
    float4 _RimColor; // プロパティの"RimColor"をシェーダー内で仕様できるようにする
    float _RimPower; // プロパティの"RimPower"をシェーダー内で仕様できるようにする
    // surf関数内で使用できるInput構造体の定義、
    struct Input {
      float3 viewDir;     // ビュー方向
      float2 uv_texture;  // "sampler2D _texture"の反映先の座標
    };

    void surf (Input IN, inout SurfaceOutput o) {
      half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal)); // 法線が横に向いているもの程、値が大きくなるようにする
      o.Emission = _RimColor.rgb * pow(rim, _RimPower); // リムを設定
      o.Albedo = tex2D(_texture, IN.uv_texture);        // _textureの色情報をuv座標に反映
    }
    ENDCG
  }
  Fallback "Diffuse" // エラーが発生したらピンク表示
}