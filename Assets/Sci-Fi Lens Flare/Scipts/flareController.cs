using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flareController : MonoBehaviour {
	public SciFiFlare _sciFiFlare;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void Intensity (float i){
		_sciFiFlare.intensity = i;
	}

	public void Colors(int c){
	
		if (c == 1) {
		
			_sciFiFlare.color = new Color (0.55f, 0.55f, 1);
		
		}

		if (c == 2) {

			_sciFiFlare.color = Color.red;

		}

		if (c == 3) {

			_sciFiFlare.color = new Color32(0,159,0,255) ;

		}

		if (c == 4) {

			_sciFiFlare.color = Color.white ;

		}
	
	}

	public void Modes(int m){
	
		_sciFiFlare._mode = m+1;
	
	}
	public void Length(float l){
	
		_sciFiFlare._length = l;
	
	}

	public void Xintense(float x){

		_sciFiFlare._xIntense = (int)x;

	}

	public void Yintense(float y){

		_sciFiFlare._yIntense = (int)y;

	}
}
