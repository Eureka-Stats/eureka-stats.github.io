---
layout: page
title: Rankings
permalink: /about/
image: '/images/60.jpg'
---

{% for post in site.posts %}
  <article>
    <h2>
      <a href="{{ post.url }}">
        {{ post.title }}
      </a>
    </h2>
  </article>
{% endfor %}
