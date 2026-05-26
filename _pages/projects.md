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
      <div class="row">
        {% if project.img %}
          <div class="col col-sm-4 abbr mb-3 mb-sm-0">
            {% include figure.liquid loading="eager" path=project.img sizes="220px" alt="project thumbnail" class="preview z-depth-1 rounded" max-width="220px" %}
          </div>
        {% endif %}
        <div class="{% if project.img %}col-sm-8{% else %}col-sm-12{% endif %}">
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
