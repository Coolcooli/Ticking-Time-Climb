using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class PlayerController : MonoBehaviour
{
    [SerializeField] private Animator _animator;
    [SerializeField] private SpriteRenderer _spriteRenderer;
    private Rigidbody2D _rigidbody2D;

    private Vector2 _velocity;

    private void Start()
    {
        _rigidbody2D = GetComponent<Rigidbody2D>();
    }

    private void FixedUpdate()
    {
        float vertical = Input.GetAxis("Vertical");
        float horizontal = Input.GetAxis("Horizontal");

        bool moving = horizontal != 0;
        bool grounded = vertical == 0;

        _velocity.x += horizontal;

        if (horizontal != 0)
        {
            _spriteRenderer.flipX = horizontal < 0;
        }

        _animator.SetBool("Moving", moving);
        _animator.SetBool("Grounded", grounded);

        _rigidbody2D.velocity += _velocity;
    }
}
