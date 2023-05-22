using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingFloor : MonoBehaviour
{
    private Tile[] _tiles;

    private const float TILE_WIDTH = .48f;
    private const float TILE_OFFSET = -.5f;

    public void InitializeFloor(Tile tile, int floorWidth)
    {
        _tiles = new Tile[floorWidth];

        for (int i = 0; i < _tiles.Length; i++)
        {
            Tile newTile = Instantiate(tile, transform);
            newTile.transform.position = new Vector2(i * TILE_WIDTH + TILE_OFFSET, transform.position.y);
            _tiles[i] = newTile;
        }
    }
}
