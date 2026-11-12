/* ============================================================
   THE GUIDEBOOK'S CONTENTS - the one list every page reads.
   Adding a chapter = one line here + its page.
   status:  live  = the page exists and is linked
            soon  = built as a prompt + guide, page not made yet
            later = the step itself is still in development
   tool:    prompt (the default) | skill (only decks and visuals)
   icon:    a file in ../assets/icons/ (the system icon), or none
   ============================================================ */
window.CL_GUIDE = {
  title: 'The $100K Day Engine™ Guidebook',
  groups: [
    { name: 'Start Here', items: [
      { slug: 'ai-workspace', label: 'Start here', title: 'Your $100K Day AI Workspace', icon: 'ai-workspace', status: 'live' }
    ]},
    { name: 'Foundations', blurb: 'The five documents every builder reads. Build these first.', items: [
      { slug: 'brand-profile',         label: 'Foundation 1', title: 'The Business Brand Profile', icon: 'brand-profile', status: 'live' },
      { slug: 'visual-style',          label: 'Foundation 2', title: 'The Visual Style Guide',     icon: 'visual-style', status: 'live' },
      { slug: 'brand-voice',           label: 'Foundation 3', title: 'The Brand Voice',            icon: 'brand-voice', status: 'live' },
      { slug: 'products-and-pricing',  label: 'Foundation 4', title: 'Offer Pricing',         icon: 'products-and-pricing', status: 'live' },
      { slug: 'competitive-landscape', label: 'Foundation 5', title: 'Competitive Landscape',      icon: 'competitive-landscape', status: 'live' }
    ]},
    { name: 'Offer Matrix™', icon: 'offer-matrix', blurb: 'Pillar 1 · Steps 1–3 · the message and the offer only you can sell.', items: [
      { slug: 'million-promise',      label: 'Step 1 · Part 1', title: 'The $Million Promise™',     icon: 'million-promise', status: 'live' },
      { slug: 'golden-avatar',        label: 'Step 1 · Part 2', title: 'The Golden Avatar™',        icon: 'golden-avatar', status: 'live' },
      { slug: 'million-moment',       label: 'Step 1 · Part 3', title: 'The $Million Moment™',      icon: 'million-moment', status: 'live' },
      { slug: 'magic-formula',        label: 'Step 2 · Part 1', title: 'The Magic Formula™',        icon: 'magic-formula', status: 'live' },
      { slug: 'magic-formula-visual', label: 'Step 2 · Part 2', title: 'The Magic Formula™ Visual', icon: 'magic-formula-visual', status: 'live', tool: 'skill' },
      { slug: 'score-card',           label: 'Step 2 · Part 3', title: 'The SCORE™ Card',           icon: 'score-card', status: 'live' },
      { slug: 'money-model',          label: 'Step 3',               title: 'The Money Model',                icon: 'money-model',   status: 'live' },
      { slug: 'enrollment-doc',       label: 'Step 3',               title: 'The Red Diamond Offer™',    icon: 'red-diamond',   status: 'live' },
      { slug: 'event-magnet',         label: 'Step 3',               title: 'The Event Magnet™',         icon: 'event-magnet',   status: 'live' },
      { slug: 'cash-flow-max',        label: 'Step 3',               title: 'Cash Flow Max™',            icon: 'cash-flow-max',   status: 'live' }
    ]},
    { name: 'Money Magnet™', icon: 'money-magnet', blurb: 'Pillar 2 · Steps 4–6 · fill the room and get paid.', items: [
      { slug: 'the-closes',                 label: 'Step 4 · Part 1', title: 'The Closes',                        icon: 'sniper-close',      status: 'live' },
      { slug: 'sniper-presentation',        label: 'Step 4 · Part 2', title: 'The Sniper Presentation™',        icon: 'sniper-presentation',      status: 'live' },
      { slug: 'sniper-presentation-slides', label: 'Step 4 · Part 3', title: 'The Sniper Presentation™ Slides', icon: 'sniper-presentation-slides',      status: 'live', tool: 'skill' },
      { slug: 'cash-flow-engine',           label: 'Step 5 · Part 1',             title: 'Cash Flow Engine™',                icon: 'cashflow-engine',   status: 'live', tool: 'skill' },
      { slug: 'video-scripts',              label: 'Step 5 · Part 2', title: 'Your Funnel Video Scripts',        icon: 'video-scripts',     status: 'live', tool: 'skill' },
      { slug: 'genie-x-converter',          label: 'Step 6',               title: 'Genie X Converter™',               icon: 'genie-x-converter', status: 'later' }
    ]},
    { name: 'Client Flywheel™', icon: 'client-flywheel', blurb: 'Pillar 3 · Steps 7–9 · fill the machine.', items: [
      { slug: 'goliath-content-map', label: 'Step 7', title: 'The Goliath Content™ Map', icon: 'goliath-content',   status: 'live' },
      { slug: 'program-modules',     label: 'Step 7', title: 'Your Program Modules',          icon: 'program-modules',   status: 'live' },
      { slug: 'program-module-visual', label: 'Step 7 · Part 2', title: 'Program Module Visuals', icon: 'program-module-visual', status: 'live', tool: 'skill' },
      { slug: 'pixie-dust-social',   label: 'Step 8', title: 'Pixie Dust Social™',       icon: 'pixie-dust-social', status: 'later' },
      { slug: 'dragon-fire-ads',     label: 'Step 9', title: 'Dragon Fire Ads™',         icon: 'dragon-fire-ads',   status: 'live', tool: 'skill' }
    ]}
  ]
};
