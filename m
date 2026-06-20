Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5071DDC1B
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976304; cv=none; b=Nq5VJnIEZ7Um2vH80ZJTWipjpsSJtLzJ2QYfc3sv0fXYHIv04T6wonwkQKXTPdFiA6GOi+qUOSslJ+x4/+0zLxe19DPcWjOXKiM6D8iAaVGgU5BIJIZcbZtpab/6q3gKKebMpRRUKXaUMouNq8i+t+ehct7qdeCxlmlU1Nb90r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976304; c=relaxed/simple;
	bh=9uJ140oDuM54eijIutpjBQyuj94Bs0407UbSB28Nz6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OEu8xgNMqyOijjDUHMUhcjYkLICeFifEs09k9nEZXaz8mi7484zlHWW8avLA5ReyOuoeL4iep+ylpQQdddtvdknR+5JmqaRneFTujhyaAUklQv+GXdIibd0L89NwkuuUCawMUiXb4XO4czHck5QH9YUYiOEhpb5px0crtK29ACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2kMxnGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2kMxnGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA311F000E9;
	Sat, 20 Jun 2026 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976303;
	bh=xaeXB2BNOoijhxEH2l0dUeXoU24YqsOI7CdpqUR7DNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2kMxnGm19gt6M1cfdvovhAjWLcN4EAKYm3ota6ClTnBueiIbqTcfpmQwjvDILIBj
	 zR8qLB4SWLhj5IrsQXerI2Y/KvHZSW/tN/mAf/2VRDGLBzsliVqNNbzOg+TCt9zy9I
	 0Joux6FDOM3LPDtix11wKvKigErNHjnO2a0VHbItXdyvFSzGEc0yUUyrdJl+xIABiT
	 GHJa9n0NqqSvi8XHKX4i0SInlvmYG7MP+iVN5HP4wTx3i0G/h9mtfk+kxmNwHqQT+v
	 jXNjr+Jx4D9yXFxAS10RP735lEANz0ztIs3NLHm4Ut7f4TXYTCkRb+73xJvr4rD71r
	 QeWFA4W30lveg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1] mm/damon/core: handle zero intervals in
 damon_max_nr_accesses()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620171413.89555-1-sj@kernel.org>
References: <20260620171413.89555-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:25:02 +0000
Message-Id: <20260620172503.2DA311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing integer overflows when scaling `nr_accesses` based on=
 user-defined intervals.
--

commit 2fc9b9ee26cec1a6b183b74636dd1922579cd4da
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: handle zero intervals in damon_max_nr_accesses()

damon_max_nr_accesses() causes a divide-by-zero if the sampling interval
is set to zero by the user. If the aggregation interval is set to zero,
the function returns zero. It is wrong, since the real maximum
nr_acceses in the setup should be one.

Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef9..888570f55b416 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const stru=
ct damon_ctx *ctx)
> =20
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attr=
s *attrs)
>  {
> -	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> +	unsigned long sample_interval;
> +	unsigned long max_nr_accesses;
> +
> +	sample_interval =3D attrs->sample_interval ? : 1;
> +	max_nr_accesses =3D min(attrs->aggr_interval / sample_interval,
>  			(unsigned long)UINT_MAX);
> +	return max_nr_accesses ? : 1;
>  }

[Severity: High]
This is a pre-existing issue, but are there integer overflows when scaling
nr_accesses based on these user-defined intervals?

Since DAMON allows configuring sample_interval and aggr_interval via sysfs
without restricting their ratio, a region's nr_accesses (an unsigned int)
can grow up to aggr_interval / sample_interval.

If this ratio exceeds UINT_MAX, nr_accesses wraps around. More practically,
the codebase multiplies nr_accesses by 32-bit integer constants:

In mm/damon/core.c:damon_merge_two_regions():
    l->nr_accesses_bp =3D l->nr_accesses * 10000;

Can this overflow 32-bit unsigned math if the access count is greater than
429,496?

Similarly, in mm/damon/ops-common.c:damon_hot_score():
    freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE / damon_max_nr_ac=
cesses(&c->attrs);

Does natively multiplying r->nr_accesses by 100 before dividing by the max
accesses cause a 32-bit integer overflow if the accesses exceed 42,949,672?

Additionally, on 32-bit platforms, can this calculation overflow unsigned
long?

In mm/damon/lru_sort.c:damon_lru_sort_apply_parameters():
    hot_thres =3D damon_max_nr_accesses(&attrs) * hot_thres_access_freq / 1=
000;

Multiplying damon_max_nr_accesses (up to UINT_MAX) by hot_thres_access_freq
natively overflows unsigned long on 32-bit architectures.

Could these overflows corrupt DAMON's core metrics, potentially causing
incorrect memory operations like aggressively swapping out hot pages under
the false impression that they are cold?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620171413.8955=
5-1-sj@kernel.org?part=3D1
