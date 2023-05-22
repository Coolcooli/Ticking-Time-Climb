using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingFloor : MonoBehaviour
{
    private Tile[] _tiles;

    private const float TILE_WIDTH = .48f;

    public void InitializeFloor(Tile tile, int floorWidth)
    {
        _tiles = new Tile[floorWidth];

        float tileOffset = (_tiles.Length - 1) * TILE_WIDTH / 2;

        for (int i = 0; i < _tiles.Length; i++)
        {
            Tile newTile = Instantiate(tile, transform);
            newTile.transform.position = new Vector2(i * TILE_WIDTH - tileOffset, transform.position.y);
            _tiles[i] = newTile;
        }
    }
}
