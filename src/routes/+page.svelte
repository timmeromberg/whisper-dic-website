<script lang="ts">
  import { onMount } from 'svelte';

  const vibes = [
    {
      id: 'claude',
      label: 'Claude Code',
      icon: '🤖',
      input: 'Um, hey Claude, could you, uh, refactor this function to use, like, async await?',
      output: 'Refactor this function to use async/await.'
    },
    {
      id: 'terminal',
      label: 'Terminal',
      icon: '🐚',
      input: 'Wait, show me all the, um, docker containers that are running on port 8080.',
      output: 'docker ps --filter "publish=8080"'
    },
    {
      id: 'slack',
      label: 'Communication',
      icon: '💬',
      input: 'Tell the team that the, uh, deploy is delayed by 10 minutes because of the CI pipeline.',
      output: 'The deploy is delayed by 10 minutes due to the CI pipeline.'
    }
  ];

  let activeVibe = $state(vibes[0]);
  let displayedOutput = $state('');
  let isTyping = $state(false);
  let showPasted = $state(false);
  
  // Simple timeout refs to clear
  let typingTimer: any = null;
  let pasteTimer: any = null;

  function cleanup() {
    if (typingTimer) clearInterval(typingTimer);
    if (pasteTimer) clearTimeout(pasteTimer);
  }

  function startTyping(text: string) {
    cleanup();
    
    isTyping = true;
    displayedOutput = '';
    showPasted = false;
    
    let i = 0;
    // Use a safe, consistent interval
    typingTimer = setInterval(() => {
      if (i < text.length) {
        displayedOutput += text[i];
        i++;
      } else {
        clearInterval(typingTimer);
        isTyping = false;
        
        // Show "Sent to cursor" briefly
        pasteTimer = setTimeout(() => {
          showPasted = true;
          pasteTimer = setTimeout(() => {
            showPasted = false;
          }, 2000);
        }, 500);
      }
    }, 40);
  }

  $effect(() => {
    // React to vibe change
    startTyping(activeVibe.output);
    
    // Cleanup on component destroy
    return () => cleanup();
  });

  const features = [
    {
      title: "Hacker-First",
      desc: "Built for speed. No subscriptions, just performance. The ultimate tool for vibe coding.",
      icon: "⚡"
    },
    {
      title: "AI Clean-up",
      desc: "Automatically strips filler words and stammers. Your spoken words become clean prompts.",
      icon: "✨"
    },
    {
      title: "Context Aware",
      desc: "Adapts rewrite style based on whether you are in VS Code, Slack, or Terminal.",
      icon: "🎯"
    },
    {
      title: "Local or Cloud",
      desc: "Use Groq for lightspeed cloud transcription or whisper.cpp for total offline privacy.",
      icon: "🔒"
    }
  ];

  const benchmarks = [
    { tool: "whispervibe (Groq)", type: "Cloud + LLM", latency: "626ms", cost: "Free" },
    { tool: "Wispr Flow", type: "Cloud + LLM", latency: "~700ms", cost: "$8/mo" },
    { tool: "Superwhisper (Large)", type: "Local", latency: "2-3s", cost: "$8/mo" },
    { tool: "Apple Dictation", type: "On-device", latency: "Sub-300ms*", cost: "Free" }
  ];
</script>

<main class="flex-grow">
  <!-- Hero Section -->
  <section class="relative overflow-hidden pt-24 pb-20 px-6">
    <div class="absolute inset-0 z-0 pointer-events-none">
      <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[1000px] h-[600px] bg-[radial-gradient(circle,var(--accent-glow),transparent_70%)] opacity-50"></div>
    </div>

    <div class="relative z-10 max-w-5xl mx-auto text-center">
      <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[var(--bg-surface)] border border-[var(--border-subtle)] mb-8">
        <span class="w-2 h-2 rounded-full bg-[var(--green)] animate-pulse"></span>
        <span class="text-xs font-medium text-[var(--text-secondary)] uppercase tracking-wider">v0.2.11 Now Available</span>
      </div>
      
      <h1 class="text-5xl md:text-7xl font-bold tracking-tight mb-6 bg-gradient-to-b from-white to-[var(--text-secondary)] bg-clip-text text-transparent">
        Speak your prompts.<br/>Stop typing. Start shipping.
      </h1>
      
      <p class="text-xl text-[var(--text-secondary)] max-w-2xl mx-auto mb-10 leading-relaxed">
        System-wide hold-to-dictate for macOS, Windows, and Linux. 
        AI-powered cleanup makes your spoken words perfect before they hit the cursor.
      </p>

      <div class="flex flex-col sm:flex-row items-center justify-center gap-4 relative z-20">
        <a href="https://github.com/timmeromberg/whisper-dic/releases" target="_blank" class="px-8 py-4 rounded-[var(--radius)] bg-[var(--accent)] text-white font-semibold shadow-[0_0_20px_var(--accent-glow)] hover:scale-105 transition-transform flex items-center gap-2 cursor-pointer">
          <span></span> Download for macOS
        </a>
        <a href="https://github.com/timmeromberg/whisper-dic/releases" target="_blank" class="px-8 py-4 rounded-[var(--radius)] bg-[var(--bg-raised)] border border-[var(--border-default)] text-[var(--text-primary)] font-semibold hover:bg-[var(--bg-hover)] transition-colors flex items-center gap-2 cursor-pointer">
          <span>⊞</span> Download for Windows
        </a>
      </div>

      <!-- Interactive Vibe Demo -->
      <div class="mt-16 max-w-3xl mx-auto relative z-20">
        <div class="flex gap-2 mb-4 justify-center md:justify-start overflow-x-auto pb-2">
          {#each vibes as vibe}
            <button 
              onclick={() => { console.log("Clicked vibe:", vibe.label); activeVibe = vibe; }}
              class="px-4 py-2 rounded-lg text-sm font-medium transition-all border whitespace-nowrap cursor-pointer {activeVibe.id === vibe.id ? 'bg-[var(--accent-soft)] border-[var(--accent)] text-white shadow-[0_0_10px_var(--accent-glow)]' : 'bg-[var(--bg-surface)] border-[var(--border-subtle)] text-[var(--text-tertiary)] hover:border-[var(--border-strong)] hover:text-[var(--text-secondary)]'}"
            >
              <span class="mr-2">{vibe.icon}</span>{vibe.label}
            </button>
          {/each}
        </div>

        <div class="p-6 rounded-xl bg-[var(--bg-surface)] border border-[var(--border-subtle)] backdrop-blur-sm relative overflow-hidden group shadow-2xl">
          <div class="flex items-center gap-2 mb-4 border-b border-[var(--border-subtle)] pb-3">
            <div class="flex gap-1.5">
              <div class="w-3 h-3 rounded-full bg-[#ff5f56]"></div>
              <div class="w-3 h-3 rounded-full bg-[#ffbd2e]"></div>
              <div class="w-3 h-3 rounded-full bg-[#27c93f]"></div>
            </div>
            <span class="text-[10px] font-mono text-[var(--text-tertiary)] ml-2 uppercase tracking-tighter">whispervibe // context: {activeVibe.label}</span>
          </div>

          <div class="text-left font-mono text-sm space-y-6">
            <div class="space-y-2">
              <div class="flex items-center justify-between">
                <p class="text-[var(--text-tertiary)] text-[10px] uppercase tracking-[0.2em]">Voice Processing</p>
                <div class="flex items-end gap-[2px] h-3">
                  <div class="w-[2px] bg-[var(--red)] animate-[wave_0.8s_infinite_0s]"></div>
                  <div class="w-[2px] bg-[var(--red)] animate-[wave_0.8s_infinite_0.2s]"></div>
                  <div class="w-[2px] bg-[var(--red)] animate-[wave_0.8s_infinite_0.4s]"></div>
                  <div class="w-[2px] bg-[var(--red)] animate-[wave_0.8s_infinite_0.1s]"></div>
                </div>
              </div>
              <p class="text-white opacity-60 italic text-sm leading-relaxed">"{activeVibe.input}"</p>
            </div>

            <div class="pt-4 border-t border-[var(--border-subtle)/30]">
              <div class="flex items-center justify-between mb-3">
                <p class="text-[var(--accent)] text-[10px] uppercase tracking-[0.2em] font-bold">Transcription Output</p>
                <div class="h-4">
                  {#if showPasted}
                    <span class="text-[var(--green)] text-[10px] font-bold animate-bounce tracking-widest uppercase">⏎ Sent to cursor</span>
                  {/if}
                </div>
              </div>
              <div class="min-h-[3rem] bg-[var(--bg-deep)] p-4 rounded-lg border border-[var(--border-strong)] shadow-inner flex items-center">
                <span class="text-[var(--text-tertiary)] mr-3 opacity-30 select-none">$</span>
                <p class="text-[var(--green)] leading-relaxed">
                  {displayedOutput}<span class="inline-block w-2 h-4 bg-[var(--green)] ml-1 align-middle {isTyping ? 'opacity-100' : 'animate-[blink_1s_infinite]'}"></span>
                </p>
              </div>
            </div>
          </div>

          <!-- Decorative Glow -->
          <div class="absolute -bottom-10 -right-10 w-40 h-40 bg-[var(--accent)] opacity-5 blur-[60px] pointer-events-none"></div>
        </div>
      </div>
    </div>
  </section>

  <!-- Features Grid -->
  <section class="py-24 px-6 border-t border-[var(--border-subtle)] bg-[var(--bg-base)]">
    <div class="max-w-6xl mx-auto">
      <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
        {#each features as feature}
          <div class="p-8 rounded-[var(--radius-lg)] bg-[var(--bg-surface)] border border-[var(--border-subtle)] hover:border-[var(--border-strong)] transition-colors group">
            <div class="text-3xl mb-4 group-hover:scale-110 transition-transform">{feature.icon}</div>
            <h3 class="text-lg font-bold mb-2">{feature.title}</h3>
            <p class="text-[var(--text-secondary)] text-sm leading-relaxed">{feature.desc}</p>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <!-- Benchmarks Section -->
  <section class="py-24 px-6 border-t border-[var(--border-subtle)]">
    <div class="max-w-4xl mx-auto text-center">
      <h2 class="text-3xl font-bold mb-4">Built for Performance</h2>
      <p class="text-[var(--text-secondary)] mb-12 max-w-2xl mx-auto">We benchmark every stage of the pipeline. whispervibe is optimized for the fastest possible key-to-cursor latency.</p>
      
      <div class="overflow-x-auto rounded-[var(--radius-lg)] border border-[var(--border-subtle)] bg-[var(--bg-surface)] text-left">
        <table class="w-full font-mono text-sm">
          <thead>
            <tr class="border-b border-[var(--border-subtle)] bg-[var(--bg-raised)]">
              <th class="p-4 font-bold text-[var(--text-tertiary)] uppercase tracking-wider">Tool</th>
              <th class="p-4 font-bold text-[var(--text-tertiary)] uppercase tracking-wider">Type</th>
              <th class="p-4 font-bold text-[var(--text-tertiary)] uppercase tracking-wider">Latency</th>
              <th class="p-4 font-bold text-[var(--text-tertiary)] uppercase tracking-wider">Cost</th>
            </tr>
          </thead>
          <tbody>
            {#each benchmarks as row}
              <tr class="border-b border-[var(--border-subtle)] hover:bg-[var(--bg-hover)] transition-colors">
                <td class="p-4 font-bold {row.tool.includes('whispervibe') ? 'text-[var(--accent)]' : ''}">{row.tool}</td>
                <td class="p-4 text-[var(--text-secondary)]">{row.type}</td>
                <td class="p-4">{row.latency}</td>
                <td class="p-4 text-[var(--text-secondary)]">{row.cost}</td>
              </tr>
            {/each}
          </tbody>
        </table>
      </div>
      <p class="mt-4 text-[var(--text-tertiary)] text-xs italic">
        *Streaming tools feel lower but lack AI rewriting in batch.
      </p>
    </div>
  </section>

  <!-- CTA Section -->
  <section class="py-24 px-6 border-t border-[var(--border-subtle)] bg-[radial-gradient(circle_at_bottom,var(--accent-glow),transparent_50%)]">
    <div class="max-w-4xl mx-auto text-center">
      <h2 class="text-4xl font-bold mb-6 text-white text-balance">Ready to change how you code?</h2>
      <p class="text-xl text-[var(--text-secondary)] mb-10">Download whispervibe for macOS and Windows today and start vibe coding.</p>
      <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
        <a href="https://github.com/timmeromberg/whisper-dic/releases" target="_blank" class="px-10 py-5 rounded-[var(--radius-lg)] bg-white text-black font-bold text-lg hover:scale-105 transition-transform shadow-2xl cursor-pointer">
          Get for macOS
        </a>
        <a href="https://github.com/timmeromberg/whisper-dic/releases" target="_blank" class="px-10 py-5 rounded-[var(--radius-lg)] bg-[var(--bg-raised)] text-white border border-[var(--border-default)] font-bold text-lg hover:bg-[var(--bg-hover)] transition-colors shadow-2xl cursor-pointer">
          Get for Windows
        </a>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="py-12 px-6 border-t border-[var(--border-subtle)] bg-[var(--bg-deep)]">
    <div class="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-8">
      <div class="flex items-center gap-3">
        <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-[var(--accent)] to-[#a855f7] flex items-center justify-center font-bold text-white shadow-lg">W</div>
        <span class="font-bold text-[var(--text-secondary)] tracking-tight uppercase">whispervibe</span>
      </div>
      
      <div class="flex gap-8 text-sm text-[var(--text-secondary)]">
        <a href="https://github.com/timmeromberg/whisper-dic/tree/main/docs" target="_blank" class="hover:text-white transition-colors">Docs</a>
        <a href="https://github.com/timmeromberg/whisper-dic/blob/main/LICENSE" target="_blank" class="hover:text-white transition-colors">License</a>
        <a href="https://github.com/timmeromberg/whisper-dic/issues" target="_blank" class="hover:text-white transition-colors">Privacy</a>
        <a href="https://github.com/timmeromberg/whisper-dic" target="_blank" class="hover:text-white transition-colors">GitHub</a>
      </div>
      
      <p class="text-xs text-[var(--text-tertiary)]">© 2026 Timme Romberg</p>
    </div>
  </footer>
</main>

<style>
  @keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0; }
  }

  @keyframes wave {
    0%, 100% { height: 4px; }
    50% { height: 16px; opacity: 0.5; }
  }
  
  /* Ensure buttons are actually clickable and have pointer cursor */
  button, a {
    cursor: pointer !important;
    pointer-events: auto !important;
  }
</style>
