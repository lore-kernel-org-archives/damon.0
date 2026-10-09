Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BD3DD526
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550538; cv=none; b=II3Z+IK7tWbi5XPYpxhc/X1X5L2VqjPplr6OiBr8L442IyUP6mJWV+sGgQaWzkVYDdBz0UK3dUe5WMytM0mCFvJl1fHs3DN1enja368I1DMXIc649oX55KOEb3bEMud6DI41g4uwWiL9KRo8GdtctVzz5xUd/y5o8MQturLtETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550538; c=relaxed/simple;
	bh=HVUpx9aniwPS5OhbmmeJuJIUTBS8dQFanWa18/Fx5Xo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jj8qiVLytRRsA0rVnmMv66KzmEUdjgpWD0ZIVNSKupQHTBBZzRZCIO05r+g9PODL8LlCgHNAkhX8D0YfJGxWa+fze6aF4dyzaxtBIugHVGbMrKUYEj8HjsLp2CF1atWK1VBSpt9HtPqlmPrj39yeHlTWnEvezSltJzh+cQK+oD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXGY+ltW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXGY+ltW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221FE1F000FF;
	Fri,  9 Oct 2026 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791550537;
	bh=AsSydYuj6x7dDw375GCOAPxifGxWGEdayw/+/ui2ToU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXGY+ltWpjYcUI3GZWzrDo4FiAFGIiE4jxRTus8jlwGvr1kpKH9+gicmkf56JEth2
	 vO/yT/HrRWrZ2s6dmk0SyvvmpRCYGoo7GlHiKIIuzG83cpZwYkEQOOjRhJy86XIe5I
	 b8gr6pwFmTAiVIfqHhko+tVOo6MuPx4c51P1HhHMj5g78mqQbiK3+BQD44V+aB/5D3
	 nO3b2j+0HnNykrQ8FTFPTKfic+87G7NUSNccvWJXAmBo7m7/9JLGTK3hcM7tt8CMki
	 0VVebggiynkR4Q7qjl97egikVJ6TS26A8DjrA6nkoIjQ1v0yApjcOtDBZ6pq6a2dAW
	 Qz6pa7LgOP8sQ==
Message-ID: <sashiko-outbox-165573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v3 1/2] mm/damon/core: do non-safe region walk on
 kdamond_apply_schemes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261009123651.6585-2-sj@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20261009123651.6585-1-sj@kernel.org> <20261009123651.6585-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:55:36 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: damon: double application of DAMOS schemes due to non-safe reg=
ion walk
--

commit 7c60a2f66acad38f06b09b2a9e484519168800bc
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

This commit changes kdamond_apply_schemes() to use the non-safe
damon_for_each_region() iterator instead of damon_for_each_region_safe().
It also drops the double-pointer workaround in damos_skip_charged_region()
to let newly split regions be seen on the next iteration of the region walk.

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 32737cc5f877b..76f23c1d2f56b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1749,7 +1749,7 @@ static void kdamond_apply_schemes(struct damon_ctx =
*c)
>  		return;
> =20
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> +		damon_for_each_region(r, t)
>  			damon_do_apply_schemes(c, t, r);
>  	}

[Severity: High]
Does this change cause earlier schemes to double-apply their actions when a
subsequent scheme splits the region?

In kdamond_apply_schemes(), changing to the non-safe iterator means the loop
dynamically visits newly created fragments on the very next iteration.

When damon_do_apply_schemes() runs, it evaluates all schemes sequentially on
the region:

mm/damon/core.c:damon_do_apply_schemes() {
	...
	damon_for_each_scheme(s, c) {
		...
		if (damos_skip_charged_region(t, r, s))
			continue;
		...
		damos_apply_scheme(c, t, r, s);
	}
}

If an earlier scheme evaluates the region, it may apply its action and upda=
te
its statistics for the full size of the region.

If a subsequent scheme then evaluates the same region and splits it (for
example via damos_skip_charged_region()), it shrinks the original region and
inserts a new region immediately after it.

Because damon_for_each_region() is no longer safe against modifications to =
the
list, the next iteration of the outer loop will process the newly inserted
region across all schemes.

Since the newly inserted region retains the exact properties (age, access
counts) of the original region, will the earlier scheme re-evaluate it and
apply its action a second time, double-charging its statistics and applying
redundant actions to the memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009123651.6585=
-1-sj@kernel.org?part=3D1
