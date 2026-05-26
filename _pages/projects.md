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
      <div class="row align-items-start">
        {% if project.img %}
          <div class="col-md-3 col-lg-2 mb-3 mb-md-0">
            {% include figure.liquid loading="eager" path=project.img sizes="(min-width: 992px) 180px, (min-width: 768px) 25vw, 90vw" alt="project thumbnail" class="img-fluid rounded z-depth-1" %}
          </div>
        {% endif %}
        <div class="{% if project.img %}col-md-9 col-lg-10{% else %}col-12{% endif %}">
          <h2 class="h5 mb-2">{{ project.title }}</h2>
          {% if project.description %}
            <p class="text-muted mb-2">{{ project.description }}</p>
          {% endif %}
          <div>{{ project.content | markdownify }}</div>
        </div>
      </div>
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

          {% if award.authors and award.authors.size > 0 %}
            <p class="mb-1">{{ award.authors | join: ", " }}</p>
          {% endif %}

          {% if award.summary %}
            <div>{{ award.summary | markdownify }}</div>
          {% endif %}
        </div>
      {% endfor %}
    </div>
  </div>
{% endif %}
