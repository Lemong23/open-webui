<script lang="ts">
	import { WEBUI_BASE_URL } from '$lib/constants';
	import { marked } from 'marked';

	import { config, user, models as _models, temporaryChatEnabled } from '$lib/stores';
	import { onMount, getContext } from 'svelte';

	import { blur, fade } from 'svelte/transition';

	import Suggestions from './Suggestions.svelte';
	import { sanitizeResponseContent } from '$lib/utils';
	import Tooltip from '$lib/components/common/Tooltip.svelte';
	import EyeSlash from '$lib/components/icons/EyeSlash.svelte';
	import { attachSubjectParticle } from '$lib/utils/ko/getSubjectionParticle';

	const i18n = getContext('i18n');

	export let modelIds = [];
	export let models = [];

	export let submitPrompt;

	let mounted = false;
	let selectedModelIdx = 0;

	$: if (modelIds.length > 0) {
		selectedModelIdx = models.length - 1;
	}

	$: models = modelIds.map((id) => $_models.find((m) => m.id === id));

	onMount(() => {
		mounted = true;
	});
</script>

{#key mounted}
	<div class="m-auto w-full max-w-[907px] px-8 lg:px-20">
		<!-- <div class="flex justify-start">
			<div class="flex -space-x-4 mb-0.5" in:fade={{ duration: 200 }}>
				{#each models as model, modelIdx}
					<button
						on:click={() => {
							selectedModelIdx = modelIdx;
						}}
					>
						<Tooltip
							content={marked.parse(
								sanitizeResponseContent(models[selectedModelIdx]?.info?.meta?.description ?? '')
							)}
							placement="right"
						>
							<img
								crossorigin="anonymous"
								src={model?.info?.meta?.profile_image_url ??
									`${WEBUI_BASE_URL}/static/favicon.png`}
								class="size-[2.7rem] rounded-full border-[1px] border-gray-200 dark:border-none"
								alt="logo"
								draggable="false"
							/>
						</Tooltip>
					</button>
				{/each}
			</div>
		</div> -->

		<!-- {#if $temporaryChatEnabled}
			<Tooltip
				content="This chat won't appear in history and your messages will not be saved."
				className="w-fit"
				placement="top-start"
			>
				<div class="flex items-center gap-2 text-gray-500 font-medium text-lg my-2 w-fit">
					<EyeSlash strokeWidth="2.5" className="size-5" /> Temporary Chat
				</div>
			</Tooltip>
		{/if} -->

		<div
			class="mt-12 mb-4 text-3xl leading-[1.5] text-center text-black dark:text-gray-100 font-medium flex items-center gap-4 font-primary justify-center"
		>
			<div>
				<div class=" capitalize line-clamp-1" in:fade={{ duration: 200 }}>
					{#if $user.name}
						{$i18n.t('Hello, {{name}}', { name: $user.name })}
					{:else}
						{$i18n.t('Hello')}
					{/if}
				</div>

				<div in:fade={{ duration: 200, delay: 200 }}>
					{#if models[selectedModelIdx]?.info?.meta?.description ?? null}
						<div
							class="mt-0.5 text-base font-normal text-gray-500 dark:text-gray-400 line-clamp-3 markdown"
						>
							{@html marked.parse(
								sanitizeResponseContent(models[selectedModelIdx]?.info?.meta?.description)
							)}
						</div>
						{#if models[selectedModelIdx]?.info?.meta?.user}
							<div class="mt-0.5 text-sm font-normal text-gray-400 dark:text-gray-500">
								By
								{#if models[selectedModelIdx]?.info?.meta?.user.community}
									<a
										href="https://openwebui.com/m/{models[selectedModelIdx]?.info?.meta?.user
											.username}"
										>{models[selectedModelIdx]?.info?.meta?.user.name
											? models[selectedModelIdx]?.info?.meta?.user.name
											: `@${models[selectedModelIdx]?.info?.meta?.user.username}`}</a
									>
								{:else}
									{models[selectedModelIdx]?.info?.meta?.user.name}
								{/if}
							</div>
						{/if}
					{:else}
						<div class="mt-2">
							<div class="font-mediumline-clamp-1 text-2xl">
								{!!models[selectedModelIdx]?.name ? attachSubjectParticle(models[selectedModelIdx]?.name || '') : '배움몽이'}
								{$i18n.t('will help you with anything')}
							</div>
						</div>
					{/if}
					<p class="mt-4 text-base text-balance break-keep text-blue-500">
						본 서비스는 베타 테스트 중이며, 일부 정보 제공에 오류가 있을 수 있습니다.
						더 나은 서비스를 제공하기 위해 지속적으로 모니터링 후 개선해 나가고 있으니 이점 양해부탁드리겠습니다.
					</p>
				</div>
			</div>
		</div>

		<div class=" w-full font-primary" in:fade={{ duration: 200, delay: 300 }}>
			<Suggestions
				className="grid grid-cols-2"
				suggestionPrompts={models[selectedModelIdx]?.info?.meta?.suggestion_prompts ??
					$config?.default_prompt_suggestions ??
					[]}
				on:select={(e) => {
					submitPrompt(e.detail);
				}}
			/>
		</div>
	</div>
{/key}
