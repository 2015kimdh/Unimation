using UnityEngine;
using System.Collections;

public class CameraRigForMouse : MonoBehaviour {

private MouseLook _mouseLook;
private bool _lookOn;
private bool _drawFinished;
private Quaternion _lockRotation;
	// Use this for initialization
	void Start () {
	_mouseLook = this.GetComponent<MouseLook>();
	//EventManager.DrawFinished += DrawFinished;
_lockRotation = Quaternion.Euler(15,0,0);

	}
	
	// Update is called once per frame
	void Update () {
	
	if(Input.GetMouseButton(1)&&!_drawFinished){
_lookOn = true;

	}
if(!Input.GetMouseButton(1)){
_lookOn = false;
}

if(_lookOn){
	_mouseLook.enabled = true;
}

if(!_lookOn){
	_mouseLook.enabled = false;
}

if(_drawFinished){
this.transform.rotation = Quaternion.Lerp(this.transform.rotation, _lockRotation, 5* Time.unscaledDeltaTime);
}
	}

	void DrawFinished(){
Debug.Log("Camera Locked");
_drawFinished = true;

this.transform.parent = GameObject.Find("Parent").transform;

	}
}
