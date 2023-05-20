using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingFloor : MonoBehaviour
{
    private Tile[] tiles;

    private const float TILE_WIDTH = .48f;

    public void InitializeFloor(Tile tile, int floorWidth)
    {
        tiles = new Tile[floorWidth];

        for (int i = 0; i < tiles.Length; i++)
        {
            Tile newTile = Instantiate(tile, transform);
            newTile.transform.position = new Vector2(i * TILE_WIDTH, transform.position.y);
            tiles[i] = newTile;
        }
    }
}
