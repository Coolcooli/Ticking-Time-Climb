using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    private Animator _animator;
    private SpriteRenderer _spriteRenderer;
    private Rigidbody2D _rigidbody2D;

    private Vector2 _velocity;

    private void Start()
    {
        _animator = GetComponent<Animator>();
        _spriteRenderer = GetComponent<SpriteRenderer>();
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
