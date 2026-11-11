/* ============================================================
   THE GUIDEBOOK - shared behaviour for every page.
   Reads window.CL_GUIDE (chapters.js). No libraries, works from
   file:// and from the live site. Ticks are saved in this browser.
   ============================================================ */
(function () {
  'use strict';
  var G = window.CL_GUIDE || { groups: [] };
  var body = document.body;
  var HERE = body.getAttribute('data-slug') || '';
  var ICONS = '../assets/icons/';
  var KEY_DONE = 'clg:done';

  function $(s, el) { return (el || document).querySelector(s); }
  function $$(s, el) { return Array.prototype.slice.call((el || document).querySelectorAll(s)); }
  function load(k, d) { try { var v = localStorage.getItem(k); return v ? JSON.parse(v) : d; } catch (e) { return d; } }
  function save(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} }
  function esc(s) { return String(s).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }

  var all = [];
  G.groups.forEach(function (g) { g.items.forEach(function (it) { it.group = g.name; all.push(it); }); });
  var counted = all.filter(function (it) { return it.status !== 'later'; });

  /* ---------- Done state ---------- */
  function doneList() { return load(KEY_DONE, []); }
  function setDone(slug, on) {
    var d = doneList().filter(function (s) { return s !== slug; });
    if (on) d.push(slug);
    save(KEY_DONE, d);
    paintDone();
  }
  function paintDone() {
    var d = doneList();
    $$('.tick[data-slug]').forEach(function (b) {
      var on = d.indexOf(b.getAttribute('data-slug')) > -1;
      b.classList.toggle('is-on', on);
      b.setAttribute('aria-pressed', on ? 'true' : 'false');
    });
    var n = counted.filter(function (it) { return d.indexOf(it.slug) > -1; }).length;
    $$('[data-done-count]').forEach(function (el) { el.textContent = n + ' of ' + counted.length + ' done'; });
    $$('.meter i').forEach(function (el) { el.style.width = (counted.length ? (n / counted.length) * 100 : 0) + '%'; });
  }

  /* ---------- Left: contents ---------- */
  function iconHtml(it) {
    if (it.icon) return '<span class="toc-ic"><img src="' + ICONS + it.icon + '.svg" alt=""></span>';
    return '<span class="toc-ic"><i>' + esc(it.num || '→') + '</i></span>';
  }
  function renderToc() {
    var nav = $('#toc'); if (!nav) return;
    var h = '<div class="toc-hd"><b>Contents</b><span data-done-count></span></div>';
    h += '<a class="toc-home' + (HERE === 'home' ? ' is-here' : '') + '" href="index.html"><span class="toc-ic"><img src="' + ICONS + '100kday-engine.svg" alt=""></span>Guidebook home</a>';
    G.groups.forEach(function (g) {
      h += '<div class="toc-grp"><div class="toc-grp-name">' + esc(g.name) + '</div>';
      g.items.forEach(function (it) {
        var inner = iconHtml(it) + '<span class="toc-txt"><small>' + esc(it.label) + '</small><span>' + esc(it.title) + '</span></span>';
        if (it.status === 'live') {
          h += '<div class="toc-row"><a class="toc-item' + (it.slug === HERE ? ' is-here' : '') + '" href="' + it.slug + '.html"' + (it.slug === HERE ? ' aria-current="page"' : '') + '>' + inner + '</a>' +
               '<button class="tick" type="button" data-slug="' + it.slug + '" aria-label="Mark ' + esc(it.title) + ' done" aria-pressed="false"></button></div>';
        } else {
          h += '<div class="toc-item is-soon" aria-disabled="true">' + inner + '<span class="toc-tag">' + (it.status === 'later' ? 'In dev' : 'Soon') + '</span></div>';
        }
      });
      h += '</div>';
    });
    h += '<div class="toc-prog">Your progress<div class="meter"><i></i></div></div>';
    nav.innerHTML = h;
    nav.addEventListener('click', function (e) {
      var t = e.target.closest('.tick');
      if (!t) return;
      e.preventDefault(); e.stopPropagation();
      setDone(t.getAttribute('data-slug'), !t.classList.contains('is-on'));
    });
    var cur = $('.toc-item.is-here', nav);
    if (cur && cur.scrollIntoView) { var top = cur.offsetTop - 120; nav.scrollTop = top > 0 ? top : 0; }
  }

  /* ---------- Mobile menu ---------- */
  function wireMenu() {
    var btn = $('.menu-btn'), wrap = $('.toc-wrap');
    if (!btn || !wrap) return;
    btn.addEventListener('click', function () { var o = wrap.classList.toggle('is-open'); btn.setAttribute('aria-expanded', o ? 'true' : 'false'); });
    wrap.addEventListener('click', function (e) { if (e.target === wrap) wrap.classList.remove('is-open'); });
  }

  /* ---------- Right: on this page + scrollspy ---------- */
  function renderOtp() {
    var box = $('#otp'); if (!box) return;
    var secs = $$('.page [data-toc]');
    if (!secs.length) { var w = $('.otp-wrap'); if (w) w.style.display = 'none'; return; }
    var h = '<b>On this page</b><ol>';
    secs.forEach(function (s) { h += '<li><a href="#' + s.id + '">' + esc(s.getAttribute('data-toc')) + '</a></li>'; });
    box.innerHTML = h + '</ol>';
    var links = $$('a', box);
    function spy() {
      var y = window.scrollY + 120, on = 0;
      secs.forEach(function (s, i) { if (s.offsetTop <= y) on = i; });
      links.forEach(function (a, i) { a.classList.toggle('is-on', i === on); });
    }
    window.addEventListener('scroll', spy, { passive: true }); spy();
  }

  /* ---------- Reading bar ---------- */
  function wireReadbar() {
    var bar = $('.readbar'); if (!bar) return;
    function f() { var d = document.documentElement, max = d.scrollHeight - d.clientHeight; bar.style.width = (max > 0 ? (d.scrollTop / max) * 100 : 0) + '%'; }
    window.addEventListener('scroll', f, { passive: true }); f();
  }

  /* ---------- Read time (counted, not guessed) ---------- */
  function readTime() {
    var el = $('[data-read-time]'), page = $('.page'); if (!el || !page) return;
    var words = (page.innerText || '').split(/\s+/).filter(Boolean).length;
    el.textContent = '~' + Math.max(1, Math.round(words / 220)) + ' min';
  }

  /* ---------- The prompt: copy + download ---------- */
  /* Embedded files: <script type="application/json" class="embed" data-key="prompt" data-file="x.md" data-src="...">
     Buttons: data-copy="key" / data-download="key". Filled by scripts/build_guidebook.ps1. */
  function embedEl(key) { return $('script.embed[data-key="' + (key || 'prompt') + '"]'); }
  function embedText(key) {
    var s = embedEl(key); if (!s) return '';
    try { return JSON.parse(s.textContent || '""'); } catch (e) { return ''; }
  }
  function toast(msg) {
    var t = $('.toast'); if (!t) { t = document.createElement('div'); t.className = 'toast'; t.setAttribute('role', 'status'); body.appendChild(t); }
    t.textContent = msg; t.classList.add('is-on');
    clearTimeout(t._h); t._h = setTimeout(function () { t.classList.remove('is-on'); }, 2200);
  }
  function copy(text) {
    if (navigator.clipboard && window.isSecureContext) return navigator.clipboard.writeText(text).catch(function () { return copyOld(text); });
    return copyOld(text);
  }
  function copyOld(text) {
    return new Promise(function (ok, no) {
      var ta = document.createElement('textarea'); ta.value = text; ta.setAttribute('readonly', '');
      ta.style.position = 'fixed'; ta.style.opacity = '0'; body.appendChild(ta); ta.select();
      try { document.execCommand('copy') ? ok() : no(); } catch (e) { no(e); } body.removeChild(ta);
    });
  }
  function wirePrompt() {
    $$('[data-copy]').forEach(function (b) {
      var label = b.innerHTML, key = b.getAttribute('data-copy');
      b.addEventListener('click', function () {
        var t = embedText(key); if (!t) { toast('This file is missing from the page.'); return; }
        copy(t).then(function () {
          b.classList.add('is-done'); b.textContent = 'Copied ✓';
          toast('Copied. Paste it into a new chat.');
          setTimeout(function () { b.classList.remove('is-done'); b.innerHTML = label; }, 2400);
        }, function () { toast('Copy did not work here. Use Download instead.'); });
      });
    });
    $$('[data-download]').forEach(function (b) {
      var key = b.getAttribute('data-download');
      b.addEventListener('click', function () {
        var t = embedText(key); if (!t) { toast('This file is missing from the page.'); return; }
        var s = embedEl(key), name = (s && s.getAttribute('data-file')) || 'file.md';
        var url = URL.createObjectURL(new Blob([t], { type: 'text/markdown;charset=utf-8' }));
        var a = document.createElement('a'); a.href = url; a.download = name; body.appendChild(a); a.click();
        setTimeout(function () { URL.revokeObjectURL(url); body.removeChild(a); }, 500);
      });
    });
  }

  /* ---------- Action items ---------- */
  function wireActions() {
    $$('.actions[data-key]').forEach(function (list) {
      var key = 'clg:act:' + list.getAttribute('data-key');
      var boxes = $$('input[type=checkbox]', list), state = load(key, []);
      boxes.forEach(function (b, i) { b.checked = !!state[i]; });
      list.addEventListener('change', function () {
        var s = boxes.map(function (b) { return b.checked; });
        save(key, s);
        var allOn = s.every(Boolean), wasDone = doneList().indexOf(HERE) > -1;
        if (allOn && !wasDone) { setDone(HERE, true); toast('Chapter marked done.'); }
        if (!allOn && wasDone) setDone(HERE, false);
      });
    });
  }

  /* ---------- Search (Ctrl/Cmd + K) ---------- */
  function wireSearch() {
    var m = document.createElement('div');
    m.className = 'modal'; m.setAttribute('role', 'dialog'); m.setAttribute('aria-label', 'Search the guidebook');
    m.innerHTML = '<div class="modal-box"><input type="search" placeholder="Search the guidebook" aria-label="Search the guidebook"><div class="modal-res"></div></div>';
    body.appendChild(m);
    var input = $('input', m), res = $('.modal-res', m), idx = [];
    all.forEach(function (it) { idx.push({ t: it.title, s: it.group + ' · ' + it.label + (it.status === 'live' ? '' : ' · coming soon'), h: it.status === 'live' ? it.slug + '.html' : '' }); });
    $$('.page h2, .page h3').forEach(function (h, i) {
      var sec = h.closest('[id]'); if (!sec) return;
      if (!h.id && h.tagName === 'H3') h.id = sec.id + '-' + i;
      idx.push({ t: h.textContent.replace(/\s+/g, ' ').trim(), s: 'On this page', h: '#' + (h.id || sec.id) });
    });
    var sel = 0;
    function draw() {
      var q = input.value.trim().toLowerCase(), hits = idx.filter(function (r) { return !q || (r.t + ' ' + r.s).toLowerCase().indexOf(q) > -1; }).slice(0, 14);
      sel = 0;
      res.innerHTML = hits.length ? hits.map(function (r, i) {
        return r.h ? '<a href="' + r.h + '"' + (i === 0 ? ' class="is-on"' : '') + '>' + esc(r.t) + '<small>' + esc(r.s) + '</small></a>'
                   : '<div class="modal-empty">' + esc(r.t) + ' · coming soon</div>';
      }).join('') : '<div class="modal-empty">Nothing found. Try another word.</div>';
    }
    function open() { m.classList.add('is-open'); input.value = ''; draw(); setTimeout(function () { input.focus(); }, 10); }
    function close() { m.classList.remove('is-open'); }
    $$('[data-search]').forEach(function (b) { b.addEventListener('click', open); });
    input.addEventListener('input', draw);
    m.addEventListener('click', function (e) { if (e.target === m) close(); if (e.target.closest('a')) close(); });
    document.addEventListener('keydown', function (e) {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') { e.preventDefault(); open(); }
      if (!m.classList.contains('is-open')) return;
      var links = $$('a', res);
      if (e.key === 'Escape') close();
      if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
        e.preventDefault(); if (!links.length) return;
        sel = (sel + (e.key === 'ArrowDown' ? 1 : -1) + links.length) % links.length;
        links.forEach(function (a, i) { a.classList.toggle('is-on', i === sel); });
      }
      if (e.key === 'Enter' && links[sel]) { links[sel].click(); close(); }
    });
  }

  renderToc(); paintDone(); wireMenu(); renderOtp(); wireReadbar(); readTime(); wirePrompt(); wireActions(); wireSearch();
})();
