﻿#ifndef PLANET_CGINC
#define PLANET_CGINC



#include "noiseSimplex.cginc"





// https://gamedev.stackexchange.com/questions/116205/terracing-mountain-features
float terrace(float h, float bandHeight) {
	float W = bandHeight; // width of terracing bands
	float k = floor(h / W);
	float f = (h - k*W) / W;
	float s = min(2 * f, 1.0);
	return (k + s) * W;
}


float snoise(float3 pos, int octaves, float modifier)
{
	float result = 0;
	float amp = 1;
	for (int i = 0; i < octaves; i++)
	{
		result += snoise(pos) * amp;
		pos *= modifier;
		amp /= modifier;
	}
	return result;
}


float GetProceduralHeight01(float3 dir)
{
	float result = 0;

	float2 w;
	float x;

	/*
	{ // terraces
	float3 pos = dir * 10;
	int octaves = 2;
	float freqModifier = 3;
	float ampModifier = 1/freqModifier;
	float amp = 1;
	for (int i = 0; i < octaves; i++)
	{
	float p = snoise(pos, 4, 10);
	result += terrace(p, 0.5) * amp;
	pos *= freqModifier;
	amp *= ampModifier;
	}
	}
	*/
	// small noise



	{ //big detail
	  //continents
		result += abs(snoise(dir*0.5, 5, 4));
		//w = worleyNoise(dir * 2);
		//result += (w.x - w.y) * 2;
		//oceans
		result -= abs(snoise(dir*2.2, 4, 4));
		//big rivers
		x = snoise(dir * 3, 3, 2);
		result += -exp(-pow(x * 55, 2)) * 0.2;
		//craters
		//w = worleyNoise(dir);
		//result += smoothstep(0.0, 0.1, w.x);
	}


	{ //small detail
		float p = snoise(dir * 10, 5, 10) * 100;
		float t = 0.3;
		t = clamp(snoise(dir * 2), 0.1, 1.0);
		result += terrace(p, 0.2)*0.005;
		result += p*0.005;
		//small rivers
		float x = snoise(dir * 3);
		//result += -exp(-pow(x*55,2)); 
	}


	{
		float p = snoise(dir * 10, 5, 10);
		//result += terrace(p, 0.15)*10;
		//result += p * 0.1;
	}

	{
		//float p = snoise(dir*10, 5, 10);
		//result += terrace(p, 0.1)/1;
	}



	/*
	{ // hill tops
	float p = snoise(dir * 10);
	if(p > 0) result -= p * 2;
	}
	*/

	/*
	{ // craters

	vec2 w = worleyNoise(dir*10, 1, false);
	result += smoothstep(0.0, 0.4, w.x) * 100;
	}
	*/

	return result;

}


#endif