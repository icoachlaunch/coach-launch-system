/* ============================================================
   Coach Launch Training Portal - access gate
   ------------------------------------------------------------
   Loaded synchronously in <head>. Keeps the page hidden until the
   visitor enters the portal access code, then remembers the device.

   - The code itself is NOT in this file or anywhere in the repo.
     Only a PBKDF2-SHA256 hash of it is (the GATE line below).
   - Set or rotate the code:
       powershell -File scripts/set_portal_code.ps1            (random 6 digits)
       powershell -File scripts/set_portal_code.ps1 -Code 123456
     Rotating the code signs every remembered browser out.
   - Add ?lock to the page URL to forget this browser and show the gate again.
   - Honest limit: this is a static site, so the gate turns away casual
     visitors; it is not real access control. The HTML is still served to
     anyone who asks for it. See PROGRESS.md (2026-09-30).
   ============================================================ */
(function () {
  'use strict';

  /* GATE - stamped by scripts/set_portal_code.ps1. Do not hand-edit. */
  var GATE = { salt: '66c4b02ba92f6e7036eafc3df997dc59', hash: '8404daa30dec8e91ae504ede86158318cef686c5aaa9554b47680f896eb21351', iterations: 300000, digits: 6 };

  var STORE = 'cl-portal-key';
  var html = document.documentElement;
  var unlocked = false;

  function stored()     { try { return localStorage.getItem(STORE); } catch (e) { return null; } }
  function remember(v)  { try { localStorage.setItem(STORE, v); } catch (e) {} }
  function forget()     { try { localStorage.removeItem(STORE); } catch (e) {} }

  function unlock() {
    unlocked = true;
    html.classList.remove('cl-locked');
    var css = document.getElementById('cl-gate-css'); if (css) css.parentNode.removeChild(css);
    var g = document.getElementById('cl-gate');       if (g)   g.parentNode.removeChild(g);
  }

  function toHex(buf) {
    var u = new Uint8Array(buf), s = '';
    for (var i = 0; i < u.length; i++) s += (u[i] < 16 ? '0' : '') + u[i].toString(16);
    return s;
  }
  function fromHex(h) {
    var u = new Uint8Array(h.length / 2);
    for (var i = 0; i < u.length; i++) u[i] = parseInt(h.substr(i * 2, 2), 16);
    return u;
  }

  /* PBKDF2-SHA256 through Web Crypto - native, so 300k rounds is a blink in the
     browser, but slow enough to make guessing every 6-digit code a real chore. */
  function derive(code) {
    var subtle = window.crypto && window.crypto.subtle;
    if (!subtle) return Promise.reject(new Error('no-crypto'));
    var raw = new TextEncoder().encode(code);
    return subtle.importKey('raw', raw, 'PBKDF2', false, ['deriveBits']).then(function (key) {
      return subtle.deriveBits(
        { name: 'PBKDF2', hash: 'SHA-256', salt: fromHex(GATE.salt), iterations: GATE.iterations },
        key, 256);
    }).then(toHex);
  }
  function verify(code) {
    return derive(String(code)).then(function (h) { return GATE.hash !== '' && h === GATE.hash; });
  }

  /* 1. Decide now, before <body> parses, so a remembered browser never sees the gate flash. */
  html.classList.add('cl-locked');
  if (/[?&]lock(?:[=&]|$)/.test(location.search)) { forget(); }
  else if (GATE.hash !== '' && stored() === GATE.hash) { unlock(); }

  /* 2. Otherwise build the gate once the DOM exists. */
  var CSS = [
    'html.cl-locked{overflow:hidden}',
    '#cl-gate{position:fixed;inset:0;z-index:9999;display:grid;grid-template-columns:minmax(0,1fr);place-items:center;padding:24px 16px;background:var(--cl-paper);font-family:var(--font-body);color:var(--text)}',
    '#cl-gate .cl-gate-card{width:100%;max-width:420px;min-width:0;box-sizing:border-box;background:var(--bg-panel);border:1px solid var(--border);border-top:4px solid var(--cl-crimson);border-radius:var(--radius);box-shadow:var(--shadow);padding:2.2rem 2rem 1.8rem;text-align:center}',
    '#cl-gate .cl-logo{font-size:1.25rem;margin-bottom:1.6rem}',
    '#cl-gate .cl-gate-eyebrow{font-family:var(--font-display);font-weight:800;font-size:.72rem;letter-spacing:.1em;text-transform:uppercase;color:var(--cl-crimson);margin-bottom:.5rem}',
    '#cl-gate h1{font-family:var(--font-display);font-weight:800;font-size:1.5rem;line-height:1.2;margin:0 0 .6rem;color:var(--cl-black)}',
    '#cl-gate p{margin:0 0 1.2rem;font-size:.95rem;line-height:1.5;color:var(--text-muted)}',
    '#cl-gate input{width:100%;box-sizing:border-box;font-family:var(--font-display);font-weight:800;font-size:1.9rem;letter-spacing:.45em;text-align:center;padding:.6rem .4rem .6rem .85rem;border:2px solid var(--border);border-radius:var(--radius-sm);background:var(--bg-tint);color:var(--cl-black);outline:none}',
    '#cl-gate input:focus{border-color:var(--cl-crimson);background:var(--bg-panel)}',
    '#cl-gate button{width:100%;margin-top:.9rem;padding:.85rem 1rem;border:0;border-radius:999px;background:var(--cl-crimson);color:var(--cl-white);font-family:var(--font-display);font-weight:800;font-size:.95rem;letter-spacing:.03em;cursor:pointer}',
    '#cl-gate button:hover{background:var(--cl-crimson-deep)}',
    '#cl-gate button[disabled],#cl-gate input[disabled]{opacity:.55;cursor:default}',
    '#cl-gate .cl-gate-msg{min-height:1.3em;margin:.9rem 0 0;font-size:.88rem;font-weight:700;color:var(--cl-crimson)}',
    '#cl-gate .cl-gate-foot{margin:1.2rem 0 0;font-size:.8rem;color:var(--text-dim)}',
    '#cl-gate .shake{animation:cl-shake .35s}',
    '@keyframes cl-shake{20%,60%{transform:translateX(-6px)}40%,80%{transform:translateX(6px)}}'
  ].join('');

  function build() {
    if (unlocked || document.getElementById('cl-gate')) return;

    var style = document.createElement('style');
    style.textContent = CSS;
    document.head.appendChild(style);

    var n = GATE.digits;
    var gate = document.createElement('div');
    gate.id = 'cl-gate';
    gate.setAttribute('role', 'dialog');
    gate.setAttribute('aria-modal', 'true');
    gate.setAttribute('aria-labelledby', 'cl-gate-title');
    gate.innerHTML =
      '<form class="cl-gate-card" novalidate>' +
        '<div class="cl-logo"><span class="coach">COACH</span><span class="launch">LAUNCH</span></div>' +
        '<div class="cl-gate-eyebrow">Training Portal</div>' +
        '<h1 id="cl-gate-title">Enter your access code</h1>' +
        '<p>This portal is for Coach Launch clients. Type the ' + n + '-digit code you were given.</p>' +
        '<input id="cl-gate-code" type="text" inputmode="numeric" pattern="[0-9]*" maxlength="' + n + '" autocomplete="one-time-code" aria-label="Access code">' +
        '<button type="submit">Open the portal</button>' +
        '<p class="cl-gate-msg" aria-live="polite"></p>' +
        '<p class="cl-gate-foot">Don’t have a code? Ask Coach Launch for yours.</p>' +
      '</form>';
    document.body.appendChild(gate);

    var form  = gate.querySelector('form');
    var card  = form;
    var input = gate.querySelector('input');
    var btn   = gate.querySelector('button');
    var msg   = gate.querySelector('.cl-gate-msg');
    var busy = false, misses = 0;

    function say(t) { msg.textContent = t; }
    function fail() {
      misses++;
      input.value = '';
      card.classList.remove('shake'); void card.offsetWidth; card.classList.add('shake');
      if (misses >= 5) {
        var wait = 15;
        say('Too many tries. Wait ' + wait + ' seconds.');
        input.disabled = true; btn.disabled = true;
        setTimeout(function () { misses = 0; input.disabled = false; btn.disabled = false; say(''); input.focus(); }, wait * 1000);
      } else {
        say('That code isn’t right. Try again.');
        input.focus();
      }
    }

    input.addEventListener('input', function () {
      var v = input.value.replace(/\D/g, '').slice(0, n);
      if (v !== input.value) input.value = v;
      if (v.length === n && !busy) submit();
    });
    form.addEventListener('submit', function (e) { e.preventDefault(); submit(); });

    function submit() {
      if (busy || input.disabled) return;
      var code = input.value;
      if (code.length < n) { say('Enter all ' + n + ' digits.'); input.focus(); return; }
      busy = true; btn.disabled = true; say('');
      verify(code).then(function (ok) {
        busy = false; btn.disabled = false;
        if (ok) { remember(GATE.hash); unlock(); } else { fail(); }
      }).catch(function () {
        busy = false; btn.disabled = false;
        say('Open this page over https to enter the code.');
      });
    }

    input.focus();
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', build);
  else build();

  window.CLGate = {
    verify: verify,
    lock: function () { forget(); location.reload(); }
  };
})();
