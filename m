Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57AD3A0B24
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744915; cv=none; b=B/fkl/z+1iwZyFVDiRTSoeONnQONGKknwSc3wPlGw5fwkRnyWw6kySOc1KK6mtaZP8GlaSys7xwKBZgYZmUyosebqwJPJPvy7AOVaOSbv4E6y3LanD9ncLj670sA/dCWpJFzNdQ6X/6f1L2tHLcKSZ3k1X/i6cCJWyJNctHL45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744915; c=relaxed/simple;
	bh=GgU8KT/aNk4DED9lCD529pKwPgjPUS8bMbAuq/maTeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kc/Jly81B55kZAUHh+R2uSPkynvCrKeBzVlxEtiwLsFB0op3+EErGORm1D6Gv9nZXmXFTokTCOt42PuRQueTJUirgk4S5PH7SeJWLwVeD39zItb+sOgbRfcioL6fBBKQbG/C4Ns+zbQ9iv95kqD4pn2Qooas8OOvbgkbRHg38e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOYyY9U6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOYyY9U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB701F000FF;
	Fri, 18 Sep 2026 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744914;
	bh=7hFgSotAielnzjO04zYQQejBqM/F6PrvZsZ5SO57ylk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOYyY9U675Ok03Zv3ejYrBEsuVjX2Nuwabbb8CE2MHdyTC10PYLKYz7+C4WfkBkoa
	 GbJyjZBAbA3N170/zF54s9uZMghu2cN2SMt1TSphYAAj8hK9k2ASJQgXqnUHeIM31v
	 D4vGG/24SgOKcTLODqRv6RSBPP/eJVspscOX5mQqb1Llt/mkeL1v2CyUHsSWWIR9NW
	 DpK38S+bsIJrLsGF2RTAih1geQmpABuzi5mFuBGItPxhBD2RJWwO9tYyaP96TKeKmY
	 O/ZRgdtdxUNEZaoAwkSteYO6+sZUzwQt0yOVvLCyVfDUCJuVJQnZxv70XsOKvuRgLp
	 ZJiSUm8Ahcaaw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] Docs/ABI/damon: update for quota goal metric
 complement sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-8-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:21:54 +0000
Message-Id: <20260918152154.7CB701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: damon: unsigned integer underflow in damos_set_quota_goal_curr=
ent_value()
--

commit 94b0fa41235165f1d082ca5735dcefbf9f65199b
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damos_quota_goal->complement

This commit introduces a complement flag for DAMOS quota auto-tuning goals.
It allows the system to target the complement value of a given metric by
updating the current metric value during retrieval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2258b72da7a78..25a8221dd2a40 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3238,6 +3239,19 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>  	default:
>  		break;
>  	}
> +	if (!goal->complement)
> +		return;
> +
> +	/* updte current_value to complemented value */
> +
> +	/* for user_input, users set complemented value on their own */
> +	if (goal->metric =3D=3D DAMOS_QUOTA_USER_INPUT)
> +		return;
> +	if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US)
> +		goal->current_value =3D s->quota.reset_interval * 1000 -
> +			goal->current_value;

[Severity: High]
Can this underflow in damos_set_quota_goal_current_value() if
goal->current_value exceeds s->quota.reset_interval * 1000?

For DAMOS_QUOTA_SOME_MEM_PSI_US, the background kdamond thread calculates t=
he
elapsed PSI time in microseconds. Due to scheduler delays or heavy system
load, the actual elapsed time between evaluations can slightly exceed
reset_interval milliseconds, meaning goal->current_value can legitimately
exceed s->quota.reset_interval * 1000.

An underflow would wrap goal->current_value to a massive positive number ne=
ar
ULONG_MAX. The DAMON auto-tuning loop would interpret this as the goal being
severely over-achieved, causing it to erroneously throttle its aggressivene=
ss
to the minimum precisely when memory pressure is highly severe.

> +	else
> +		goal->current_value =3D 10000 - goal->current_value;

[Severity: High]
Similarly, can this also underflow for BP metrics like
DAMOS_QUOTA_HUGEPAGE_MEM_BP?

Per-CPU counter drift can cause the calculated ratio to exceed 10000,
triggering an underflow here that similarly inverts the DAMON logic.

>  }
> =20
>  /* Return the highest score since it makes schemes least aggressive */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D7
