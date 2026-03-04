<script>
  import "../app.css";
  let { children } = $props();
</script>

<svelte:head>
  <title>whispervibe | Speak your prompts. Stop typing. Start shipping.</title>
  <meta name="description" content="System-wide hold-to-dictate for macOS, Windows, and Linux. AI-powered cleanup for perfect prompts, every time." />
</svelte:head>

<div class="min-h-screen flex flex-col">
  {@render children()}
</div>
