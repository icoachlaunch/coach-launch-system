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
  var ICONS = 'assets/icons/';
  var KEY_DONE = 'scs:done';

  function $(s, el) { return (el || document).querySelector(s); }
  function $$(s, el) { return Array.prototype.slice.call((el || document).querySelectorAll(s)); }
  function load(k, d) { try { var v = localStorage.getItem(k); return v ? JSON.parse(v) : d; } catch (e) { return d; } }
  function save(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} }
  function esc(s) { return String(s).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }

  var all = [];
  G.groups.forEach(function (g) { g.items.forEach(function (it) { it.group = g.name; all.push(it); }); });
  var counted = all.filter(function (it) { return it.status !== 'later'; });

  /* ---------- Renamed chapters: carry this browser's ticks across (2026-11-13) ---------- */
  (function () {
    var MOVED = { 'products-and-pricing': 'offer-pricing' };
    Object.keys(MOVED).forEach(function (from) {
      var to = MOVED[from], d = load(KEY_DONE, []);
      if (d.indexOf(from) > -1) save(KEY_DONE, d.filter(function (s) { return s !== from; }).concat(d.indexOf(to) > -1 ? [] : [to]));
      var a = load('scs:act:' + from, null);
      if (a && !load('scs:act:' + to, null)) save('scs:act:' + to, a);
      try { localStorage.removeItem('scs:act:' + from); } catch (e) {}
    });
  })();

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
    $$('[data-count]').forEach(function (el) {
      var s = el.getAttribute('data-count').split(' ').filter(Boolean), k = s.filter(function (x) { return d.indexOf(x) > -1; }).length;
      el.textContent = k + '/' + s.length; el.classList.toggle('is-all', s.length > 0 && k === s.length);
    });
    $$('.meter i').forEach(function (el) { el.style.width = (counted.length ? (n / counted.length) * 100 : 0) + '%'; });
  }

  /* ---------- Left: contents ---------- */
  function iconHtml(it) {
    if (it.icon) return '<span class="toc-ic"><img src="' + ICONS + it.icon + '.svg" alt=""></span>';
    return '<span class="toc-ic"><i>' + esc(it.num || '→') + '</i></span>';
  }
  /* The contents follows the Codex: pillars on top, the nine steps under them as accordions, and each
     chapter inside its step (read from its label, "Step N …"). Foundations folds too. A fold opens when
     it holds the page you're on, or when you opened it yourself (remembered in this browser). */
  var STEP_ICONS = ['million-story', 'magic-formula', 'red-diamond', 'sniper-close', 'cashflow-engine',
                    'genie-x-converter', 'goliath-content', 'pixie-dust-social', 'dragon-fire-ads'];
  var KEY_OPEN = 'scs:open';
  function stepOf(it) { var m = /^Step (\d)/.exec(it.label || ''); return m ? +m[1] : 0; }
  function itemRow(it, label) {
    var inner = iconHtml(it) + '<span class="toc-txt">' + (label ? '<small>' + esc(label) + '</small>' : '') + '<span>' + esc(it.title) + '</span></span>';
    if (it.status === 'live') {
      return '<div class="toc-row"><a class="toc-item' + (it.slug === HERE ? ' is-here' : '') + '" href="' + it.slug + '.html"' + (it.slug === HERE ? ' aria-current="page"' : '') + '>' + inner + '</a>' +
             '<button class="tick" type="button" data-slug="' + it.slug + '" aria-label="Mark ' + esc(it.title) + ' done" aria-pressed="false"></button></div>';
    }
    return '<div class="toc-item is-soon" aria-disabled="true">' + inner + '<span class="toc-tag">' + (it.status === 'later' ? 'In dev' : 'Soon') + '</span></div>';
  }
  function fold(key, cls, head, items, rows) {
    var live = items.filter(function (it) { return it.status === 'live'; });
    var open = items.some(function (it) { return it.slug === HERE; }) || load(KEY_OPEN, []).indexOf(key) > -1;
    return '<details class="' + cls + '" data-fold="' + key + '"' + (open ? ' open' : '') + '><summary>' + head +
           '<span class="toc-count" data-count="' + live.map(function (it) { return it.slug; }).join(' ') + '"></span><span class="toc-chev" aria-hidden="true"></span></summary>' +
           '<div class="toc-sub">' + rows + '</div></details>';
  }
  function renderToc() {
    var nav = $('#toc'); if (!nav) return;
    var h = '<div class="toc-hd"><b>Contents</b><span data-done-count></span></div>';
    h += '<a class="toc-home' + (HERE === 'home' ? ' is-here' : '') + '" href="index.html"><span class="toc-ic"><img src="' + ICONS + '100kday-engine.svg" alt=""></span>Training home</a>';
    G.groups.forEach(function (g) {
      if (g.pillar) {
        var p = CODEX[g.pillar - 1];
        h += '<div class="toc-pillar toc-pillar--' + g.pillar + '"><div class="toc-pillar-hd">' + (g.icon ? '<img src="' + ICONS + g.icon + '.svg" alt="">' : '') +
             '<span><small>Pillar ' + g.pillar + '</small><b>' + esc(g.name) + '</b></span></div>';
        p.steps.forEach(function (s, i) {
          var n = (g.pillar - 1) * 3 + i + 1;
          var its = g.items.filter(function (it) { return stepOf(it) === n; });
          var head = '<span class="toc-ic"><img src="' + ICONS + STEP_ICONS[n - 1] + '.svg" alt=""></span><span class="toc-txt"><small>Step ' + n + '</small><span>' + esc(s.name) + '</span></span>';
          if (!its.some(function (it) { return it.status === 'live'; })) {
            h += '<div class="toc-step is-soon" aria-disabled="true">' + head + '<span class="toc-tag">In dev</span></div>';
            return;
          }
          h += fold('step-' + n, 'toc-step', head, its, its.map(function (it) {
            return itemRow(it, (it.label || '').replace(/^Step \d\s*(·\s*)?/, ''));
          }).join(''));
        });
        h += '</div>';
      } else if (g.accordion) {
        h += '<div class="toc-grp">' + fold('grp-' + g.name.toLowerCase().replace(/[^a-z]+/g, '-'), 'toc-acc',
             '<span class="toc-grp-name">' + esc(g.name) + '</span>', g.items, g.items.map(function (it) { return itemRow(it, it.label); }).join('')) + '</div>';
      } else {
        h += '<div class="toc-grp"><div class="toc-grp-name">' + esc(g.name) + '</div>' + g.items.map(function (it) { return itemRow(it, it.label); }).join('') + '</div>';
      }
    });
    h += '<div class="toc-prog">Your progress<div class="meter"><i></i></div></div>';
    nav.innerHTML = h;
    $$('details[data-fold]', nav).forEach(function (d) {
      d.addEventListener('toggle', function () {
        var k = d.getAttribute('data-fold'), o = load(KEY_OPEN, []).filter(function (x) { return x !== k; });
        if (d.open) o.push(k);
        save(KEY_OPEN, o);
      });
    });
    nav.addEventListener('click', function (e) {
      var t = e.target.closest('.tick');
      if (!t) return;
      e.preventDefault(); e.stopPropagation();
      setDone(t.getAttribute('data-slug'), !t.classList.contains('is-on'));
    });
    var cur = $('.toc-item.is-here', nav);
    if (cur && cur.scrollIntoView) { var top = cur.offsetTop - 120; nav.scrollTop = top > 0 ? top : 0; }
  }

  /* ---------- The Engine map: the Wealth Rewired Codex ----------
     One copy for every page. A page asks for it with
     <div data-codex data-here="N" data-note="..."></div>   (N = 1-9, or 0 for "before Step 1")
     <div data-codex="full"></div>                          (home: adds each step's description)
     Words are word for word from Matthew's Codex design:
     CLIENT ENGINE/Client Engine/Offer Matrix/magic-formula-visual/. Pictures: assets/codex/step-N.png. */
  var CODEX = [
    { name: 'Offer Matrix™', sub: 'An offer the room can’t say no to', icon: 'offer-matrix', steps: [
      { name: '$Million Story™', href: 'million-promise.html', desc: 'A brand story, message & promise that makes your ideal client stop and say “that’s me”', tag: 'Be The Voice In Their Head' },
      { name: 'Magic Formula™', href: 'magic-formula.html', desc: 'Unique ingredients that make you irreplaceable and the competition almost irrelevant', tag: 'Make Competition Irrelevant' },
      { name: 'Red Diamond Offer™', href: 'money-model.html', desc: 'Offer so irresistible the only logical answer is YES! Raising prices becomes natural', tag: 'Offers They Can’t Say No To' } ] },
    { name: 'Money Magnet™', sub: 'Where the money gets made', icon: 'money-magnet', steps: [
      { name: 'Sniper Close™ Sequence', href: 'the-closes.html', desc: 'Zero pressure closing sequence so precise — your audience closes themselves', tag: 'Audience Closes Themselves' },
      { name: 'Cash Flow Engine™', href: 'cash-flow-engine.html', desc: 'Instant cashflow — collect revenue from registrations before the event even starts', tag: 'Cash Flow From Your Funnel' },
      { name: 'Genie X Converter™', href: '', desc: 'Show-up, follow-up and nurture sequence — and close sales while you sleep', tag: 'Close Sales While You Sleep' } ] },
    { name: 'Client Flywheel™', sub: 'Consistent buyers, ready to invest', icon: 'client-flywheel', steps: [
      { name: 'Goliath Content™', href: 'goliath-content-map.html', desc: 'AI-powered content flywheel that produces scripts, emails, posts and ads at scale', tag: '10X Output. Zero Overwhelm' },
      { name: 'Pixie Dust Social™', href: '', desc: '100X your circle of influence and grow a hungry buyer audience on autopilot', tag: '100X Rapid Audience Builder' },
      { name: 'Dragon Fire Ads™', href: 'dragon-fire-ads.html', desc: 'Ad machine that fills every event with premium buyers with little or ZERO ad cost', tag: 'Fill Every Event On Demand' } ] }
  ];
  /* The map is Matthew's own image (assets/codex/engine-codex.png, 1472 × 646, cropped from the Codex design).
     BOX = each step's card on that image, in its pixels [x, y, w, h], steps 1–9. A link sits over every built
     step, and a "You are here" ring over the page's own step. Re-crop the image → re-measure these. */
  var CODEX_IMG = { src: 'assets/codex/engine-codex.png', w: 1472, h: 646 };
  var BOX = [[100, 133, 440, 152], [100, 295, 440, 152], [100, 455, 440, 152],
             [546, 128, 440, 154], [546, 288, 440, 154], [546, 450, 440, 152],
             [990, 128, 442, 154], [990, 288, 442, 154], [990, 450, 442, 152]];
  function pos(b) {
    return 'left:' + (b[0] / CODEX_IMG.w * 100).toFixed(2) + '%;top:' + (b[1] / CODEX_IMG.h * 100).toFixed(2) +
           '%;width:' + (b[2] / CODEX_IMG.w * 100).toFixed(2) + '%;height:' + (b[3] / CODEX_IMG.h * 100).toFixed(2) + '%';
  }
  function renderCodex() {
    $$('[data-codex]').forEach(function (box) {
      var here = parseInt(box.getAttribute('data-here') || '0', 10) || 0;
      var note = box.getAttribute('data-note');
      var n = 0, hereName = '', marks = '';
      CODEX.forEach(function (p) {
        p.steps.forEach(function (s) {
          var b = BOX[n]; n++;
          if (n === here) { hereName = s.name; marks += '<span class="codex-mark" style="' + pos(b) + '"><b>You are here</b></span>'; }
          else if (false) marks += '<a class="codex-hit" href="' + s.href + '" style="' + pos(b) + '" aria-label="Step ' + n + ': ' + esc(s.name) + '"></a>';
        });
      });
      var alt = 'The $100K Day Engine™, the Wealth Rewired Codex: three pillars, nine steps. Offer Matrix™: $Million Story™, Magic Formula™, Red Diamond Offer™. ' +
                'Money Magnet™: Sniper Close™ Sequence, Cash Flow Engine™, Genie X Converter™. Client Flywheel™: Goliath Content™, Pixie Dust Social™, Dragon Fire Ads™.';
      var h = '<div class="codex-title"><img src="' + ICONS + '100kday-engine.svg" alt=""><span>$100K Day <em>Engine</em>®</span></div><div class="codex-scroll"><div class="codex-img"><img src="' + CODEX_IMG.src + '" width="' + CODEX_IMG.w + '" height="' + CODEX_IMG.h + '" alt="' + esc(alt) + '">' + marks + '</div></div>';
      var cap = note || (here ? 'You are at Step ' + here + ', ' + hereName + '.' : '');
      if (cap) h += '<p class="figcap">' + esc(cap) + '</p>';
      box.className = 'codex';
      box.setAttribute('role', 'group');
      box.setAttribute('aria-label', 'The $100K Day Engine™: 3 pillars and 9 steps.' + (here ? ' You are at Step ' + here + ', ' + hereName + '.' : ''));
      box.innerHTML = h;
      /* On a phone the image scrolls sideways: open it on the page's own step. */
      var sc = $('.codex-scroll', box), mk = $('.codex-mark', box), im = $('.codex-img img', box);
      function centre() { if (sc && mk && sc.scrollWidth > sc.clientWidth) sc.scrollLeft = Math.max(0, mk.offsetLeft - 12); }
      if (im && !im.complete) im.addEventListener('load', centre); else centre();
    });
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
      var key = 'scs:act:' + list.getAttribute('data-key');
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
    m.className = 'modal'; m.setAttribute('role', 'dialog'); m.setAttribute('aria-label', 'Search the training');
    m.innerHTML = '<div class="modal-box"><input type="search" placeholder="Search the training" aria-label="Search the training"><div class="modal-res"></div></div>';
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

  renderCodex(); renderToc(); paintDone(); wireMenu(); renderOtp(); wireReadbar(); readTime(); wirePrompt(); wireActions(); wireSearch();
})();
