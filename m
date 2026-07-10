Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C342D7DC8
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692176; cv=none; b=NgOOYNiCNt5BCxLjgqNpKHIQSwGMwr5/VKqoh9laKa5vUtBfH1Kv8HdqdTkzlvFMmYnbDgzEc7vlQmaxURLudZk6luh17s2YYh+gtBbOGcM5RA1qEaj5Mcg8ZoinRCBmOUZmRPYaqg2o5zyc0Xag1hxQX8kPQ5VC8eAn7+fSjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692176; c=relaxed/simple;
	bh=T0g94lZ+/eHk0APtWVIfIQn2DQ2GTELF23HBN8ah/ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXfXFDJkiIN5WnRZnJTPy2SYQCpXW5yaNXd3umU13lOjKUB4VneJ+NfBoK8QoRBIP1alMEBdz8v6z4mdMxvCi8DMsPpmdftJeK9PrmaGGzGzNhm0mkz4HnPBOjhgejahiTXOIqLC4DCwZq15QM9+eye9Ri/UeES+keXvIH5ik1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsYqePhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsYqePhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD651F000E9;
	Fri, 10 Jul 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692174;
	bh=Bnm+x2c0nhFiflxtCiW2+Jom/FphjuXyVL3tFWIWDfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsYqePhF4E82VsbVzjLrSko1uI5PbYjR1k8AkIRMvE1RelOaJ3O383aqqC52kDPnc
	 bEpLL4B6ADrjTr9b0z28lkCZZEiF1qBweJhOCBu5Ajt1OXrYXSlA1+W/t+ZksxBKFm
	 IDDSLXHuT1M1y1ev8qYEDnJf55Mk/0E3ktFuMJwXhbeHh4UgRsdFfjoRTVwzxxSYDA
	 vxrhHwJzgRUpr2IFezhHAF6v02kewYv51aUGxn5Zwx6zL338WBhL2jeM25qrNiw3ak
	 UZrjok0rus3lXJwAJPrDXO0kLQq7CWW4PBZQWZCOuOUBL9gjDqzT9GEKvJmQZrUl1S
	 8Hw0fjRoX3TLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/19] mm/damon/core: set samples in apply_probes() if
 probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-13-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:02:54 +0000
Message-Id: <20260710140254.9DD651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kdamond_merge_regions() uses a stale or 0 threshold (max_nr_acce=
sses) when probe weights are set, preventing proper region merging.
--

--- Patch [12]: [PATCH 12/19] mm/damon/core: set samples in apply_probes() =
if probe weights are set ---
commit c57b42d6ad5d1b962d67f040aa171492d081c859
Author: SJ Park <sj@kernel.org>

mm/damon/core: set samples in apply_probes() if probe weights are set

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset. Ask apply_probes()
to set those together in the case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 65f91e3b58d2e..dd0612e1a408b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3777,7 +3777,8 @@ static int kdamond_fn(void *data)
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);
>  		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, false, false);
> +			ctx->ops.apply_probes(ctx, access_check_disabled,
> +					false);
> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

[Severity: Medium]
When access_check_disabled is true, ctx->ops.check_accesses() is skipped.
Does this leave max_nr_accesses stale or set to 0 when it is subsequently
passed to kdamond_merge_regions() shortly after this block?

If max_nr_accesses evaluates to 0, it seems this might defeat the 10 percent
tolerance logic for region aggregation.

Could this force adjacent regions to merge only when their scores match
exactly, leading to region fragmentation until the maximum region limit
is hit?

Since damon_has_probe_weights() currently returns false unconditionally
to safely stage the new feature, this appears to be unreachable today, but
might become a regression once the feature is fully enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D12
