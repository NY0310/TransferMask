using UnityEngine;
using UnityEngine.Rendering;

[RequireComponent (typeof (Camera))]
public class DepthTexture : MonoBehaviour {

    [SerializeField]
    private Shader _shader;

    private void Awake () {
        GetComponent<Camera> ().depthTextureMode |= DepthTextureMode.Depth;
    }

    private void Initialize () {

    }
}