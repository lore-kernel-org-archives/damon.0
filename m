Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCE37E5F7
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932278; cv=none; b=NqjEQnsbw2s5HMBrnF9AjDeAOf8YAeMySs+A+oTIXghsO85t99ZAGUSo1B4uXhldpPCw8xAM2YMLO3e1oXDYlnLUvyfmNGDH+7UOPMz4USxMyYQVpYxpK38rI8peLU6cV3YTjaWmndPXSYdtWimZkZ4c8In0NKSH8r8dgo3KUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932278; c=relaxed/simple;
	bh=+ZFT4hipv9v7C1Ipfh47uXd64c0+C0Wwx9SwZ8SJJ0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tvDf98p28sZTYlAXQ4itRfT3u7tg1kqU04tdlCBAWV5CF6EeloRpnTN5kJzn2tAE7uI5prDZJvHj9GJm+RPfRT7DwWeeiDPTwcrF+4jvaVV2Rs5NZGjoHtciciklgtF7p419Oa+JFcD5neRM1LyDtlS2uak2t1FxvRP7wyJ3SsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW3r5Xkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW3r5Xkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89311F00A3A;
	Wed,  9 Sep 2026 05:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932276;
	bh=56CAGjXblHiK0ktWO9QaIZN6sdZmzeWvEGDWa1ErKWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bW3r5XkhldOVyLUGq/ox5pkGYGDMqUcavKy5PlQ7WHAAz9UOE29VGbe9XVX1I68fw
	 Cg/gzK4C9z2f4gFimtdPanajsHZc8GkysrnnKZTTpogRBWnyxSuOv164geILfKBFSO
	 evYpS5p2G26xcQwBcwd7fEnyc138MAiTvUVvIMgC5LSTpIDc+2hD6dlOxEyI49tLlp
	 lC8GxMaZ5+Qfn+kolttyWcvoHEG7Z0eX52d/3CfXTp6bDAWuj4zqPxUdqVI9qWYQ6d
	 UQwj7B0ioKLSvCzO4pPJjuQ+PVi/BLUt5V8TTN92yBMlcoAae94QvA92JoY/4lw6AI
	 VXw7EeVOVOpaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/ops-common: use nr_accesses moving sum
 for quota score
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909052700.238595-1-sj@kernel.org>
References: <2026090847-penknife-trout-eb12@gregkh>
 <20260909052700.238595-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:37:56 +0000
Message-Id: <20260909053756.B89311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing 32-bit unsigned int multiplication overflow when calc=
ulating access rates and base points, which corrupts the moving sum and DAM=
ON scoring.
--

commit 9fb843ad5b372fa9d7d47a74122314309e2e916a
Author: SJ Park <sj@kernel.org>

mm/damon/ops-common: use nr_accesses moving sum for quota score

This commit updates the DAMON quota prioritization score calculation to use
the moving sum of accesses instead of the potentially not fully aggregated
access count. This change aims to resolve suboptimum DAMOS performance under
certain setups.

Link: https://lore.kernel.org/20260719161136.90191-1-sj@kernel.org

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 4b5638bbe0614..dea662a6747ce 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -80,8 +80,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_r=
egion *r,
>  	unsigned int age_weight =3D s->quota.weight_age;
>  	int hotness;
> =20
> -	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
> -		damon_max_nr_accesses(&c->attrs);
> +	freq_subscore =3D mult_frac(r->nr_accesses_bp / 10000,
> +			DAMON_MAX_SUBSCORE,
> +			damon_max_nr_accesses(&c->attrs));

[Severity: High]
This isn't a bug introduced by this patch, but changing the score calculati=
on
to rely on nr_accesses_bp makes it susceptible to a pre-existing 32-bit
unsigned integer multiplication overflow.

When DAMON is configured with an aggr_interval / sample_interval ratio
greater than 429,496 (for example, a 1ms sample interval and a 10-minute
aggregation interval, which gives 600,000), last_nr_accesses can exceed
429,496.

This causes a silent overflow when updating the moving sum in
damon_update_region_access_rate():

mm/damon/core.c:damon_update_region_access_rate() {
	...
	r->nr_accesses_bp =3D damon_moving_sum(r->nr_accesses_bp,
			r->last_nr_accesses * 10000, len_window,
			accessed ? 10000 : 0);
	...
}

A similar overflow occurs in damon_nr_accesses_to_accesses_bp():

mm/damon/core.c:damon_nr_accesses_to_accesses_bp() {
	...
	return nr_accesses * 10000 / damon_max_nr_accesses(attrs);
}

Because this patch modifies damon_hot_score() to calculate freq_subscore
using the corrupted nr_accesses_bp, will DAMON calculate garbage hotness
scores for memory regions?=20

Previously, it used r->nr_accesses * DAMON_MAX_SUBSCORE, which wouldn't
overflow until a ratio of > 42,949,672. Could this change cause incorrect
functional behavior, such as wrongly reclaiming hot memory or failing to
reclaim cold memory on valid long-running configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909052700.2385=
95-1-sj@kernel.org?part=3D1
