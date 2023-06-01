using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Planet : MonoBehaviour
{
    private SpriteRenderer _spriteRenderer;
    [SerializeField] private Explosion _explosion;

    private Vector3 _velocity = Vector3.zero;
    [SerializeField] private float velocityBounds = .5f;

    private float _currentScale = 1f;
    [SerializeField] private Vector2 scaleBounds = new(.1f, .5f);

    private Vector2 _maxSpawnValues = new(2.7f, 1.5f);

    private bool _updateVelocity = true;

    private void Awake()
    {
        _spriteRenderer = GetComponent<SpriteRenderer>();
        Reset();
    }

    private void Start()
    {
        _explosion.animationHasFinished.AddListener(OnExplosionAnimationFinished);
    }

    private void FixedUpdate()
    {
        if (_updateVelocity)
            transform.position += _velocity * Time.fixedDeltaTime;

        CheckLeaveScreen();
    }

    private void CheckLeaveScreen()
    {
        Vector3 spriteSize = _spriteRenderer.bounds.size;
        if (transform.position.x - spriteSize.x / 2 > _maxSpawnValues.x ||
            transform.position.x + spriteSize.x / 2 < -_maxSpawnValues.x ||
            transform.position.y - spriteSize.y / 2 > _maxSpawnValues.y ||
            transform.position.y + spriteSize.y / 2 < -_maxSpawnValues.y)
        {
            Reset();
        }
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        Planet collidedPlanet = collision.gameObject.GetComponent<Planet>();
        collidedPlanet.Explode();
        Explode();
    }

    public void Explode()
    {
        _spriteRenderer.enabled = false;
        _explosion.gameObject.SetActive(true);
        _explosion.StartExplosion(transform.position, transform.localScale);
        _updateVelocity = false;
    }

    public void OnExplosionAnimationFinished()
    {
        _updateVelocity = true;
        _spriteRenderer.enabled = true;
        _explosion.gameObject.SetActive(false);
        Reset();
    }

    private void Reset()
    {
        transform.position = new Vector2(Random.Range(-_maxSpawnValues.x, _maxSpawnValues.x), Random.Range(-_maxSpawnValues.y, _maxSpawnValues.y));
        _velocity = new Vector3(Random.Range(-velocityBounds, velocityBounds), Random.Range(-velocityBounds, velocityBounds), 0);
        _currentScale = Random.Range(scaleBounds.x, scaleBounds.y);
        transform.localScale = Vector3.one * _currentScale;
    }
}
