Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6941A683E
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785612663; cv=none; b=q4etQue5SJbL4VBo7EG1ENu2MURA47a2ULCNrlJ4WRx4MwM0hke62BWkzMDZBkoCJ7oLiUFx+Zb2TXoAPKEYNZj+LPLVsk4UdXjt5lBEdU+sDPmtmezYWCE6z1vhrArsi2IawcwtLnuj826dFcKIsKUn06kpZo3Pw9UslJRmQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785612663; c=relaxed/simple;
	bh=4B4dysrOSzAudocsif3irOUr2hkTgHzOMqmpTFJN9aE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OjWEzkpuqbgZeGQQF/mBdXmhE2apqnVQyXFpnl8UG2RPy4I48g5a8gJ0oWpqwN8nXU13LCUrHI+5oXjAIiAZqMk91xSH1UtD8wngD3qE5bt2v76KzNm3JCsCVNm/tvCNAKNr2mOwwCisCe/cJ6pqozkOvvV6ARUB94Nb71wBqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4XjtVDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4XjtVDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA11F00AC4;
	Sat,  1 Aug 2026 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785612662;
	bh=1zjOB+LxQ+qcWlf0BsdFbkGaNSW2rY8nicQnwbbpGb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4XjtVDalpjWlu58aMPtNkZhDLQLV5Tq97dPZql4T6ce36bxS5dPJIfs5k7TSx0ew
	 3ZJd64Te4khg2hnSsaMWTpF57Cy9LNvwAgbc8TZ7SwXqxqqgXyuSTPNuTY5zZyKcD0
	 oVkN8sANvvusyoIXCq1qxlFyhB/Ja3ikJ0Ny3O0o7rN5idY7oe+t7eqP8FMlYUBeYi
	 fwHOtLxj4WAiHbEDKTNEPFF15DF7fdyahaSb5RX+qRolQ5qo+hV0DPNWFP0UItGAkV
	 cXOcOwfR6M1ZFN6P2pDvMnHYZDUOb7iX8WWWTRUxI18lWWnhO0fh7zuUdb/MM9ZvNu
	 BygkZ03U4ykbg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/9] mm/damon/core: handle extreme memory state in
 get_node_memcg_used_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801173554.94710-9-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
 <20260801173554.94710-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 19:31:01 +0000
Message-Id: <20260801193101.E8AA11F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Fallback values for invalid nodes and missing memcgs incorrectly e=
ncourage aggressive scheme application instead of throttling.
- [High] Division by zero in `damos_get_in_active_mem_bp()` when total LRU =
memory is zero.
- [High] Division by zero in `damos_quota_score()` when a quota goal has a =
`target_value` of 0.
--

--- Patch [8]: [RFC PATCH 8/9] mm/damon/core: handle extreme memory state i=
n get_node_memcg_used_bp() ---
commit 7261d4dd3fd172b597cdefa3462cc680deabe142
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()

This commit adds fallback logic to handle extreme situations where total=20
memory is zero, or when lruvec_page_state() returns used memory larger=20
than total memory. It returns 100% and 0% respectively to avoid division=20
by zero or underflow in damos_get_node_memcg_used_bp().

Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 269865eb8fbfa..76764a2056f7c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2858,10 +2858,16 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	mem_cgroup_put(memcg);
> =20
>  	si_meminfo_node(&i, goal->nid);
> -	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +	if (!i.totalram)
> +		return 10000;

[Severity: High]
This isn't a bug introduced by this patch, but returning 0 in other fallbac=
k=20
paths for missing memcgs or invalid nodes incorrectly encourages aggressive=
=20
scheme application.=20

In the DAMOS quota auto-tuner (damon_feed_loop_next_input()), a metric score
of 0 evaluates as severe under-achievement, causing the tuner to aggressive=
ly
maximize the quota. To safely halt a scheme for invalid targets, the metric
getter should probably return a value that yields a high score (e.g., 10000=
).

However, multiple pre-existing fallback paths incorrectly return 0:

mm/damon/core.c:damos_get_node_memcg_used_bp()
	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
		return 0;

mm/damon/core.c:damos_get_node_mem_bp()
	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
		numerator =3D i.freeram;
	return mult_frac(numerator, 10000, i.totalram);
(when !totalram, this evaluates to 0)

mm/damon/core.c:damos_get_node_mem_bp()
	static __kernel_ulong_t damos_get_node_mem_bp(
			struct damos_quota_goal *goal)
	{
		return 0;
	}

Could these fallbacks cause the auto-tuner to unleash maximum operations and
lead to severe over-reclaim or wasted CPU when a node becomes invalid or a
memcg is destroyed?

> +	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP) {
>  		numerator =3D used_pages;
> -	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +	} else {
> +		/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +		if (i.totalram < used_pages)
> +			return 0;
>  		numerator =3D i.totalram - used_pages;
> +	}
>  	return mult_frac(numerator, 10000, i.totalram);
>  }

[Severity: High]
This is a pre-existing issue with a similar root cause, but does this same
division by zero problem exist in damos_get_in_active_mem_bp()?

mm/damon/core.c:damos_get_in_active_mem_bp()
	if (active_ratio)
		return mult_frac(active, 10000, total);
	return mult_frac(inactive, 10000, total);

If the system has 0 pages on the LRU (e.g., during early boot, in extremely
constrained environments, or if all memory is unevictable), total evaluates
to 0. Would this result in a kernel panic when passed to mult_frac()?


[Severity: High]
This is another pre-existing issue, but does damos_quota_score() also suffer
from a division by zero when a quota goal has a target_value of 0?

mm/damon/core.c:damos_quota_score()
	highest_score =3D max(highest_score,
		mult_frac(goal->current_value, 10000,
			goal->target_value));

While the sysfs interface drops goals with a 0 target value, the core
allocation function damos_new_quota_goal() does not validate it. The mtier
sample module exposes these as module parameters:

samples/damon/mtier.c:damon_sample_mtier_build_ctx()
	quota_goal =3D damos_new_quota_goal(
		promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
		DAMOS_QUOTA_NODE_MEM_FREE_BP,
		promote ? node0_mem_used_bp : node0_mem_free_bp);

If an administrator or privileged user writes 0 to the parameter and enables
the module, would this immediately crash the kernel when the DAMOS worker
thread evaluates the quota?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801173554.9471=
0-1-sj@kernel.org?part=3D8
