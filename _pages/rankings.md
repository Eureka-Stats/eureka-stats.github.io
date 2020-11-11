---
layout: page 
title: Rankings
permalink: /rankings/
image: '/images/hydatosbg.png'
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
