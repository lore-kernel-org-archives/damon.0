Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C215ECCC
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785619552; cv=none; b=petzowr/sA43ngmqxm1ZEEw2NBLUwBYSMphh9z782UItGGMKYUf+OXk3u/jQZSaUWS1vDta/jaedK9mPbJwFUdY+p2NorHIbPMBJIc2uoLSW3VvuEgcpn7gjoItQaLkN/zzkPRwgTj/BDc6dun27kSiIZKplRMPVgGXJcz3UXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785619552; c=relaxed/simple;
	bh=KGof4Z/KizQalEgZu13TDCksgBk1IzOeFjAP+knlCsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZ6Esha9FrvlytW7fYYl+0odzBeCohrvdesl64nprEHOv0eZmxv8yYcgTyZijdZA6NlvUbRqiFjS55R2KwF5mQXl9c6MeiWRqKrkxwcSF2vHOv6PcOnNdHVwxZaTZN714UWaFMNoaLpyQZXdF9mqi4JrJ+olmIxHdBHX4G+b8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfpEB8jD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfpEB8jD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07BB1F00AC4;
	Sat,  1 Aug 2026 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785619550;
	bh=kF0aJ3eJ32NhmboSEUf/E46vedY9Ct7BiurHBbArPnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gfpEB8jDZQMHzJcqL8mzEYfJmeEVT1T6JMNId0Trw0vns/SCBXmV52LWk3GJnj6+J
	 JyimMdPFjkPslagyAWQ53BhgxfxJYhDV17/JnviHHXhtvGY1EufIZrDdk6Rc4d7tzH
	 HwlsoXeysYUcjyGKGqGrTkOy1jxa7+GfKTalg4ohyzWNSQSdML1sfV78EpNM34fEjL
	 qSHJdxJ9x+cBZ6sp/t932gjksr+agLaD6+OsZnw2zwLNe8+xxctdD7+W0xpzf8TP1e
	 K4zzN//XP2x6N1xNhIgJpJVhbOOza0LrApFVrZvfPWq3ZovhYehwc2SVfnhJSf66Lk
	 8mCEUEslh747Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] samples/damon/mtier: error out for zero quota goal
 target values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801211315.2456-1-sj@kernel.org>
References: <20260801211315.2456-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 21:25:50 +0000
Message-Id: <20260801212550.C07BB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses a division by zero in the mtier sample module =
but leaves the core vulnerability unpatched. In `mm/damon/lru_sort.c`, sett=
ing the `active_mem_bp` module parameter to 10002 results in a `target_valu=
e` of 0, triggering the same division by zero Oops in the core framework.
- [High] `damos_new_quota_goal()` allocates `damos_quota_goal` using `kmall=
oc_obj()`, leaving `last_psi_total` uninitialized. This causes wildcard aut=
o-tuning behavior for PSI-based quota goals on their first cycle.
--

--- Patch [1]: [RFC PATCH] samples/damon/mtier: error out for zero quota go=
al target values ---
commit 1b5b3916c23bf9b477a9c0308b9b7d82d8503f36
Author: SJ Park <sj@kernel.org>

samples/damon/mtier: error out for zero quota goal target values

This commit modifies the DAMON mtier sample to return an error when started
with a zero value for node0_mem_used_bp or node0_mem_free_bp. This prevents=
 a
division by zero Oops in damos_quota_score() when target_value is zero.

Link: https://lore.kernel.org/20260801202657.117135-1-sj@kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index ac9c24b92ead8..d1123ebbfab90 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -156,6 +156,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  	if (!scheme)
>  		goto free_out;
>  	damon_set_schemes(ctx, &scheme, 1);
> +	/* zero target value causes division by zero in damos_quota_store() */
> +	if (!node0_mem_used_bp || !node0_mem_free_bp)
> +		goto free_out;

[Severity: High]
This isn't a bug introduced by this patch, but does this fix leave the core
vulnerability unpatched?

Since the underlying issue is in damos_quota_score() when target_value is 0:

mm/damon/core.c:damos_quota_score() {
    ...
    mult_frac(goal->current_value, 10000, goal->target_value)
    ...
}

It appears other modules can still trigger this Oops.  For example, if a us=
er
writes 10002 to the active_mem_bp parameter in the damon_lru_sort module, t=
he
cold scheme quota goal calculation will result in a zero target value:

mm/damon/lru_sort.c:damon_lru_sort_add_quota_goals() {
    ...
    goal =3D damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
                                10000 - active_mem_bp + 2);
    ...
}

Should the zero check be handled centrally in damos_new_quota_goal() or
damos_quota_score() to prevent similar crashes from other modules?

>  	quota_goal =3D damos_new_quota_goal(
>  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
>  			DAMOS_QUOTA_NODE_MEM_FREE_BP,
>  			promote ? node0_mem_used_bp : node0_mem_free_bp);

[Severity: High]
This is a pre-existing issue, but does damos_new_quota_goal() leave fields
uninitialized?

Looking at damos_new_quota_goal(), it allocates the struct using kmalloc_ob=
j()
without zeroing the memory:

mm/damon/core.c:damos_new_quota_goal() {
    ...
    goal =3D kmalloc_obj(*goal);
    if (!goal)
        return NULL;
    goal->metric =3D metric;
    goal->target_value =3D target_value;
    INIT_LIST_HEAD(&goal->list);
    return goal;
}

This leaves union fields like last_psi_total uninitialized.  When a PSI-bas=
ed
quota goal is evaluated for the first time, this uninitialized value is used
in the feedback loop calculation:

mm/damon/core.c:damos_set_quota_goal_current_value() {
    ...
    goal->current_value =3D now_psi_total - goal->last_psi_total;
    ...
}

Could this uninitialized memory usage corrupt the auto-tuning feedback loop?

>  	if (!quota_goal)
>  		goto free_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801211315.2456=
-1-sj@kernel.org?part=3D1
