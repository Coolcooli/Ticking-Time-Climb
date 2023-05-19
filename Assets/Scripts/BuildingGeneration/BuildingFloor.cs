using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingFloor : MonoBehaviour
{
    private Tile[] tiles;
    private int floorWidth;

    private void Awake()
    {
        tiles = new Tile[floorWidth];

        InitializeFloor();
    }

    private void InitializeFloor()
    {
        for (int i = 0; i < tiles.Length; i++)
        {
            tiles[i] = new Tile();
        }
    }
}
