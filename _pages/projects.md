---
layout: page
title: Projects
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

{% assign awards = site.data.cv.cv.sections.Awards %}
{% if awards and awards.size > 0 %}
  <div class="awards-section mt-5">
    <h2 class="mb-3">Awards</h2>
    <div class="award-list">
      {% for award in awards %}
        <div class="award-entry mb-4">
          {% if award.url %}
            <h3 class="h6 mb-1">
              <a href="{{ award.url }}">{{ award.title }}</a>
            </h3>
          {% else %}
            <h3 class="h6 mb-1">{{ award.title }}</h3>
          {% endif %}

          {% assign award_meta = '' %}
          {% if award.awarder %}
            {% assign award_meta = award.awarder %}
          {% endif %}
          {% if award.date %}
            {% if award_meta != '' %}
              {% assign award_meta = award_meta | append: ' · ' %}
            {% endif %}
            {% assign award_meta = award_meta | append: award.date %}
          {% endif %}
          {% if award_meta != '' %}
            <p class="text-muted mb-1">{{ award_meta }}</p>
          {% endif %}

          {% if award.summary %}
            <div>{{ award.summary | markdownify }}</div>
          {% endif %}
        </div>
      {% endfor %}
    </div>
  </div>
{% endif %}
