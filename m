Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0F29B79B
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440197; cv=none; b=P+Vu8jxcFLyTcT+dblDRQqgn0dFgdR3P7i55Hl7Coze7BmIPKuXGFSrI87yctOEdHxZngUrx+oUyxjCk9vKYQ66qglobqKyJK7yxk9Nto0Y6CHN4wC4NGxeng+2rOZdnsqRtBH6Flz8/BtkWgb0I5I8q7QtwwIRJ5zbgsP2FEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440197; c=relaxed/simple;
	bh=4GxI/e8JMRnRn+zi71E08JUmukSSVu6ITmFNi6Oases=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E1/jdOg3v9AmkfyuhHPP7naOggmGTKRhrrAPDQ1A3CMwUBKPUd7whDpYfM1GPaSbKwlqDU7r9diN4uF8HsAe9ZSc4QX+pfTVi9LszJa/ssIODVp3FVfLbi7etk0edRZcX9KdpdCjlWPuzQre5fIymDnHWVOKsNDTI7mf7rlnjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXZCAE/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXZCAE/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE6BC19425;
	Wed, 29 Apr 2026 05:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777440197;
	bh=4GxI/e8JMRnRn+zi71E08JUmukSSVu6ITmFNi6Oases=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kXZCAE/BZK1Q8te0mJOrRRgh0CY5DmQGBcwLV/ZxZkbPyjDTf5Twq0tfsEDTQg8Js
	 srRDU0QtqxMedsyqCfGU0oLsJUpYLWjG8NrLJliEu02ruThwWufifSRWDeNoHaCAcU
	 W5xgbSjs9SKzhkBHComEHy3NU0kumgUY6KVg3E1vLq3MrnWjDBxTWn69tzD/JTXL9J
	 STyvs/K7yHbru98ITCQzW9BCFmEFMbHkS7kQTJ9LbiDyhl2KUoYToKkY8Qf6JCdMNH
	 KEG0gyJr2LjS5AvejP4yXctNdneh7AaVJibnraWNC6tEepp2SfQgPBc2UEmJGqHjKP
	 vbFcITSEs4tLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] mm/damon/reclaim: cover all system rams
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260429041232.90257-3-sj@kernel.org>
References: <20260429041232.90257-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 05:23:16 +0000
Message-Id: <20260429052317.4BE6BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Massive single DAMON region spanning physical address holes causes=
 CPU soft lockups and quota starvation.
- [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in damon_set_r=
egion_system_rams_default() leads to infinite loop and OOM panic.
--

commit 179df0c96a01c49e5644b5cc1a9154fb63368993
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: cover all system rams

This commit changes DAMON_RECLAIM to monitor the entire system RAM by
default, rather than just the biggest System RAM region, to cover all
available memory.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index b330ff169590..a60ee800d63e 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> @@ -232,11 +234,9 @@ static int damon_reclaim_apply_parameters(void)
>  		damos_add_filter(scheme, filter);
>  	}
> =20
> -	err =3D damon_set_region_biggest_system_ram_default(param_target,
> -					&monitor_region_start,
> -					&monitor_region_end,
> -					param_ctx->addr_unit,
> -					param_ctx->min_region_sz);
> +	err =3D damon_set_region_system_rams_default(param_target,
> +			&monitor_region_start, &monitor_region_end,
> +			param_ctx->addr_unit, param_ctx->min_region_sz);

Can monitor_region_start and monitor_region_end be modified concurrently
via sysfs module parameters while this code is executing?

Looking at damon_set_region_system_rams_default(), the pointers are
dereferenced multiple times:

mm/damon/core.c:damon_set_region_system_rams_default() {
	if (*start > *end)
		return -EINVAL;

	if (!*start && !*end &&
		!damon_find_system_rams_range(start, end, addr_unit))
		return -EINVAL;

	addr_range.start =3D *start;
	addr_range.end =3D *end;
	return damon_set_regions(t, &addr_range, 1, min_region_sz);
}

If a concurrent sysfs write alters the values between the initial check and
the subsequent assignment, could this result in an inverted range where sta=
rt
is greater than end?

If an inverted range is passed to damon_set_regions(), the size calculation
(end - start) could underflow to a massive value. When the thread later
executes damon_apply_min_nr_regions(), it might enter an infinite loop tryi=
ng
to split the underflowed region, endlessly allocating damon_region objects.

Additionally, could damon_find_system_rams_range() create a single bounding
box that spans massive unpopulated physical address holes on sparse memory
systems?

Since DAMON applies schemes by linearly looping over the region page-by-pag=
e,
would spinning over terabytes of holes without calling cond_resched() cause
CPU soft lockups?

Furthermore, because these holes are never accessed, they might perfectly m=
atch
PAGEOUT schemes. Could the massive region size (including holes) be incorre=
ctly
charged against the reclaim quota, instantly depleting it and preventing ac=
tual
RAM from being reclaimed?

Would it be better to dynamically populate multiple regions (one for each
RAM block) instead of using a single bounding box?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429041232.9025=
7-1-sj@kernel.org?part=3D2
