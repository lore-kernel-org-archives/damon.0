Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953234;
	b=GcYxtRQcpszo8aIs0z5SNilvvBMub21UfkLjB0Ww2R+o8djN2ilQd0x6WRaWmCS6hF0H
	 txXZrlMpyeUjArfkxXfaeM0eE8tAIJl+rWMA+Nc1qwVjJOjVZofdzyHSdlW92A+5Muf3+
	 yh9vI0o5UB1ztCkq0GvW1XQ699cy7UnZMVvR9gS/H+LXzA43FEpjm86r/dzSSmSd/1K1R
	 As1ufIi3Hvox9WsHbHEpeGMcVcVDWeeYAdO4DTGdCBeiu9JE+czv8zenRD//Iyu0gKaJH
	 7cdVzXSh4LVoHfysHmq4up545+NwQrPXsMqEkUa7fw3Y+qQQUqyLhqZLSb2m33ukccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WcI/5fRObBib8Q1yiM2jO7f739qoW3E8+UEK6/36WCo=;
	b=dDlcwnpz3YSx+Md/hl1u+LBWRGAWhi3dCsiCF489fKoESKEzNHBVb/6Ou87Tcqon+m8a
	 hZ2wzlC6Rn1y04jvty0Hb8ZBrFSku+Yy5Yw1izVwL8ltPTjuZYQbE97qN3GZE7Oe73XYH
	 EWDeB6ym4oNPIbXJWZ3JHIKOlrdLeDPEdY5jeDtVYvZKxUoNIeUwVwUd7YAUyg1MfQje5
	 rkDTNGxycSwec1NK1Smq0ykfdWKg+0cpLDLNU0PKlkCl6zwFgszLFq4O728NzHuA+JzUx
	 EUxZN/vODJSZWdD3rbH5cUx5WoLkb8Bn9dpc30L11ClwQKpto6unleeobwfaFhuQfjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khWEO9rh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089B606A322
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khWEO9rh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D621F01829;
	Sun, 25 Oct 2026 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792953234;
	bh=WcI/5fRObBib8Q1yiM2jO7f739qoW3E8+UEK6/36WCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khWEO9rhc82rNn9rFz6KXsSsfeALw4SFXKpGEcQmezX4LjdJ2HgEvwxgFIPlXYbcD
	 sz8Wn0OdbrwA3hqkoFHiC4tudHp2f+yaObsFriS2uM4rIONZVk+3I/VKovg4hv5Uoh
	 Y2UJzDpcO7N2viPoqtLnVhfK/mhMIk1E3a98ENtx24EXnGB4Hxkfptqymi6Rf/jOps
	 XjzV8DdI7kkLJRstMEa/8omn0aMjVw+Q7R4qJ/9RCReNfPsKslSBrVsh00LfwO1Bvo
	 6uE53mgYTBEPYpDLmekiQz6ZvHUZKBi127nFeGuvnWDbyatVwxQPFZHxSIZjfRRvYe
	 gpkgsl5VCts+Q==
Message-ID: <sashiko-outbox-184343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261025182326.178326-1-sj@kernel.org>
References: <20261025182326.178326-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:33:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm/damon/sysfs: ctx memory leak in damon_sysfs_turn_damon_on()
- [Low] mm/damon/sysfs: unknown member targe_value in damon_sysfs_valid_sta=
rt_ctx()
--

commit 1635d9f393d64d22688141e9540fde6f98f5d6bb
Author: SJ Park <sj@kernel.org>

mm/damon/core: error damos_commit_quota_goal() for zero target_value

This patch rejects zero target_value in DAMOS quota goals during parameter
commit in damos_commit_quota_goal() and damos_commit_quota_goals() to avoid
division-by-zero errors. For this stable backport, it also adds a validation
helper before damon_start() in damon_sysfs_turn_damon_on().

Link: https://lore.kernel.org/20260903010722.94244-1-sj@kernel.org
Link: https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org
Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 5aa23c6545cb8..7895b11555d06 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1497,6 +1497,20 @@ static struct damon_ctx *damon_sysfs_build_ctx(
>  	return ctx;
>  }
> =20
> +static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
> +{
> +	struct damos *s;
> +	struct damos_quota_goal *g;
> +
> +	damon_for_each_scheme(s, ctx) {
> +		damos_for_each_quota_goal(g, &s->quota) {
> +			if (!g->targe_value)
> +				return false;
> +		}
> +	}
> +	return true;
> +}

[Severity: Low]
Will mm/damon/sysfs.c fail to build in damon_sysfs_valid_start_ctx() due to
referencing g->targe_value instead of g->target_value?

In include/linux/damon.h, struct damos_quota_goal defines this field as:

struct damos_quota_goal {
	enum damos_quota_goal_metric metric;
	unsigned long target_value;
	unsigned long current_value;

> +
>  static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  {
>  	struct damon_ctx *ctx;
> @@ -1517,6 +1531,8 @@ static int damon_sysfs_turn_damon_on(struct damon_s=
ysfs_kdamond *kdamond)
>  	ctx =3D damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
> +	if (!damon_sysfs_valid_start_ctx(ctx))
> +		return -EINVAL;

[Severity: Medium]
Does damon_sysfs_turn_damon_on() leak ctx and its associated allocations wh=
en
damon_sysfs_valid_start_ctx(ctx) returns false?

When userspace writes "on" to the kdamond state sysfs file with a scheme
quota goal whose target_value is zero, damon_sysfs_build_ctx() allocates ctx
along with its targets, regions, schemes, quota goals, filters, and any
target struct pid references. Returning -EINVAL directly here skips
damon_destroy_ctx(ctx) (and target pid cleanup via
damon_sysfs_destroy_targets(ctx)), whereas the damon_start() error path rig=
ht
below destroys ctx before returning:

	err =3D damon_start(&ctx, 1, false);
	if (err) {
		damon_destroy_ctx(ctx);
		return err;
	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025182326.1783=
26-1-sj@kernel.org?part=3D1
