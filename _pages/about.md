---
layout: about
title: About
permalink: /
subtitle:

# Selected publications use {% bibliography --group_by none %}; without sort they follow .bib file order.
scholar:
  sort_by: year
  order: descending

profile:
  align: right
  image: ljw.jpeg
  image_circular: false # crops the image to make it circular
  more_info: >
    <div class="text-center">
      <p class="mb-1">leejaewon@yonsei.ac.kr</p>
      <p class="mb-1">Yonsei University, Seoul, Republic of Korea</p>
      <p class="mb-0">
        <a href="https://scholar.google.com/citations?hl=ko&user=y4_nryAAAAAJ"><b>Google Scholar</b></a>
        | <a href="https://github.com/Lee-JaeWon"><b>GitHub</b></a>
        | <a href="https://www.linkedin.com/in/jaewon-lee-profile"><b>LinkedIn</b></a>
      </p>
    </div>
selected_papers: true # includes a list of papers marked as "selected={true}"
social: true # includes social icons at the bottom of the page

announcements:
  enabled: false # includes a list of news items
  scrollable: true # adds a vertical scroll bar if there are more than 3 news items
  limit: 5 # leave blank to include all the news in the `_news` folder

latest_posts:
  enabled: false
  scrollable: true # adds a vertical scroll bar if there are more than 3 new posts items
  limit: 3 # leave blank to include all the blog posts
---

I am Jaewon Lee, a Ph.D. student in Electrical and Electronic Engineering at Yonsei University and a member of CILAB.

My research focuses on multi-robot systems, robot localization, and 3D scene representation.

This site contains selected publications, project summaries, and my academic CV. Contact details and additional profile information will be expanded as the site continues to be personalized.

{% assign total_citations = 0 %}
{% if site.data.citations and site.data.citations.papers %}
  {% for paper in site.data.citations.papers %}
    {% assign total_citations = total_citations | plus: paper[1].citations %}
  {% endfor %}
{% endif %}

<div class="mt-5">
  <h2 class="mb-3">Overview</h2>
  <div class="row">
    <div class="col-sm-6 col-lg-3 mb-3">
      <div class="border rounded p-3 h-100">
        <div class="text-muted small">Total Stars</div>
        <div class="h4 mb-0" id="github-total-stars">-</div>
      </div>
    </div>
    <div class="col-sm-6 col-lg-3 mb-3">
      <div class="border rounded p-3 h-100">
        <div class="text-muted small">Total Commits</div>
        <div class="h4 mb-0" id="github-total-commits">-</div>
      </div>
    </div>
    <div class="col-sm-6 col-lg-3 mb-3">
      <div class="border rounded p-3 h-100">
        <div class="text-muted small">Total PRs</div>
        <div class="h4 mb-0" id="github-total-prs">-</div>
      </div>
    </div>
    <div class="col-sm-6 col-lg-3 mb-3">
      <div class="border rounded p-3 h-100">
        <div class="text-muted small">Total Citations</div>
        <div class="h4 mb-0">{{ total_citations }}</div>
      </div>
    </div>
  </div>
  <p class="text-muted small mb-0">GitHub metrics are fetched from public GitHub data at page load.</p>
</div>

<script>
  document.addEventListener("DOMContentLoaded", async () => {
    const username = {{ site.data.socials.github_username | jsonify }};
    const defaultHeaders = {
      Accept: "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
    };

    const setMetric = (id, value) => {
      const element = document.getElementById(id);
      if (element) {
        element.textContent = value;
      }
    };

    const formatNumber = (value) => Number(value || 0).toLocaleString("en-US");

    const fetchJson = async (url) => {
      const response = await fetch(url, { headers: defaultHeaders });
      if (!response.ok) {
        throw new Error(`GitHub API request failed: ${response.status}`);
      }
      return response.json();
    };

    try {
      let page = 1;
      let totalStars = 0;

      while (true) {
        const repos = await fetchJson(
          `https://api.github.com/users/${username}/repos?per_page=100&type=owner&page=${page}`
        );

        repos.forEach((repo) => {
          totalStars += repo.stargazers_count || 0;
        });

        if (!Array.isArray(repos) || repos.length < 100) {
          break;
        }

        page += 1;
      }

      setMetric("github-total-stars", formatNumber(totalStars));
    } catch (error) {
      setMetric("github-total-stars", "N/A");
    }

    try {
      const pullRequests = await fetchJson(
        `https://api.github.com/search/issues?q=${encodeURIComponent(`is:pr author:${username}`)}`
      );
      setMetric("github-total-prs", formatNumber(pullRequests.total_count));
    } catch (error) {
      setMetric("github-total-prs", "N/A");
    }

    try {
      const commits = await fetchJson(
        `https://api.github.com/search/commits?q=${encodeURIComponent(`author:${username}`)}`
      );
      setMetric("github-total-commits", formatNumber(commits.total_count));
    } catch (error) {
      setMetric("github-total-commits", "N/A");
    }
  });
</script>

