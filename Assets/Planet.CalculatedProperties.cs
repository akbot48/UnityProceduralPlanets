﻿using UnityEngine;

public partial class Planet
{
	public int NumberOfVerticesNeededTotal { get { return (((chunkNumberOfVerticesOnEdge - 1) * chunkNumberOfVerticesOnEdge) / 2) + chunkNumberOfVerticesOnEdge; } }

	/// <summary>
	/// top vertex index
	/// </summary>
	public int AIndex { get { return 0; } }
	/// <summary>
	/// bottom left vertex index
	/// </summary>
	public int BIndex { get { return ((chunkNumberOfVerticesOnEdge - 1) * chunkNumberOfVerticesOnEdge) / 2; } }
	/// <summary>
	/// bottom right vertex index
	/// </summary>
	public int CIndex { get { return BIndex + (chunkNumberOfVerticesOnEdge - 1); } }


	public int AIndexWithSkirts { get { return AIndex + 4; } }
	public int BIndexWithSkirts { get { return BIndex - (chunkNumberOfVerticesOnEdge - 1) + 1; } }
	public int CIndexWithSkirts { get { return BIndexWithSkirts + ((chunkNumberOfVerticesOnEdge - 3) - 1); } }


	public int AIndexReal { get { return useSkirts ? AIndexWithSkirts : AIndex; } }
	public int BIndexReal { get { return useSkirts ? BIndexWithSkirts : BIndex; } }
	public int CIndexReal { get { return useSkirts ? CIndexWithSkirts : CIndex; } }




	int subdivisionMaxRecurisonDepthCached = -1;
	public int SubdivisionMaxRecurisonDepth
	{
		get
		{
			if (subdivisionMaxRecurisonDepthCached == -1)
			{
				var planetCircumference = 2 * Mathf.PI * radiusMin;
				var oneRootChunkCircumference = planetCircumference / 6.0f;

				subdivisionMaxRecurisonDepthCached = 0;
				while (oneRootChunkCircumference > stopSegmentRecursionAtWorldSize)
				{
					oneRootChunkCircumference /= 2;
					subdivisionMaxRecurisonDepthCached++;
				}
			}
			return subdivisionMaxRecurisonDepthCached;
		}
	}

}