---
layout: page
title: projects
permalink: /projects/
description:
nav: true
nav_order: 3
---

{% assign sorted_projects = site.projects | sort: "importance" %}

<div class="project-list">
  {% for project in sorted_projects %}
    <div class="project-entry mb-4">
      <h2 class="h5 mb-2">{{ project.title }}</h2>
      {% if project.description %}
        <p class="text-muted mb-2">{{ project.description }}</p>
      {% endif %}
      <div>{{ project.content | markdownify }}</div>
    </div>
  {% endfor %}
</div>
