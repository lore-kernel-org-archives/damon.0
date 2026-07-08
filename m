Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC653815EF
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519786; cv=none; b=Kza3uNbqold0Vy7VVENUNQJLgghx555DEQPIt7cd0QXCNF8AdNws/rZ7RsMWY4h6RZvDclQifK4iJ6dhNL1AS8dA7lHP1WwV2JQveBOxc9uSCrZw4NtHZ+ela6dmweSSYBJ7X1r4ERaf1B7ULgNT9QEsvdeUiydT93BTACbG60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519786; c=relaxed/simple;
	bh=UQFZ/iyHOQFkiXrwJ/lJmWMti6/3JMNNRg+mnKp/fKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBx2E42jUrIQpXma+448nOlnP37mfY/5N3cUC4NXp11g7AI2f0qQAkp/rm0gRf6ZL4AunAEyFxBcAGbCgQfT/Dg+oC/X0qcFPHMHPigyht6Khn6dyConoWVcJQvLd7DWC5Szicu+cg5nnWEd4qD4L9aJqYOhP8U+PmggbJxCp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9M8ez1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9M8ez1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26821F000E9;
	Wed,  8 Jul 2026 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519785;
	bh=tOMepEjPtN/5FKBDLyzh0q+GcqryjZb51IvalyPK77o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N9M8ez1DZZjg6TTL8uw/Em6KR8FRkv/qL+Ptt84a/PKpUl3MQ9CnOjMYSpy0tYRkP
	 ByfC+GMxjTlCgut7BG8Dpg6C20HbJ5u+Ql6gL2WfL/XYV1xGrw9Hh++IVaT90JTfB9
	 utm8dhwWucJrPOjNUDk5RxSZX/rsJLPG3LY8YLHgFCIjsXfEt2v0lwdilmc1gATudQ
	 xCryLKKaVeINgvjUthbtHRmITpChTMXeclidVnuAajBONDGT/4fblWmxVhAg4HSpix
	 zSE9NxX/NNvyeFI7Jxuw0W0QrKseI/r4u7PL+8KOQ1mnKowfYJkpmQXb9SrZcxNu1d
	 vsOTVECyM6htQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] mm/damon/core:
 s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708135359.122587-6-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
 <20260708135359.122587-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:09:44 +0000
Message-Id: <20260708140944.F26821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit arithmetic overflow in sample count and basis points conver=
sions leads to incorrect scaling for large interval ratios.
- [High] 32-bit integer overflow in `damon_age_for_new_attrs` when calculat=
ing region age during attribute updates on 32-bit architectures.
--

--- Patch [5]: [PATCH 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_sa=
mples_for_new_attrs/ ---
commit 7659397725f64a348908ab982da60d557f63b8c0
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/

This commit renames damon_nr_accesses_for_new_attrs() to
damon_nr_samples_for_new_attrs() to reflect its general use for any positive
sample count.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 718268df27fa7..800ff6b6d2473 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -890,22 +890,21 @@ static unsigned int damon_sample_count_to_bp(
>  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This is a pre-existing issue, but does this code overflow 32-bit arithmetic
when the sample count is large?

In mm/damon/core.c:damon_sample_count_to_bp(), the mult_frac macro multipli=
es
the remainder by 10000, which can overflow 32-bit arithmetic.

Similarly, in damon_sample_bp_to_count(), the 32-bit multiplication overflo=
ws
since both operands are 32-bit unsigned integers:

mm/damon/core.c:damon_sample_bp_to_count() {
	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
}

This occurs when the number of samples per aggregation interval exceeds
roughly 429,496 (e.g., sample_interval=3D1us and aggr_interval=3D1s, yieldi=
ng
1,000,000 samples).

This could cause the region access tracking variables to be corrupted and
truncated during dynamic attribute updates (damon_set_attrs), rendering DAM=
OS
memory management schemes dysfunctional.

Both intervals are fully configurable by privileged users via DAMON
sysfs/debugfs interfaces, or dynamically updated by DAMON's auto-tuning
feature, making the overflow reachable in real-world scenarios.

[Severity: High]
This is also a pre-existing issue, but can the region age calculation
overflow on 32-bit architectures during attribute updates?

Looking at damon_age_for_new_attrs(), the multiplication is limited to the
architecture's native unsigned long size:

mm/damon/core.c:damon_age_for_new_attrs() {
	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
}

On 32-bit architectures, aggr_interval (unsigned long) and age (unsigned in=
t)
are both 32-bit. The product exceeds ULONG_MAX (4,294,967,295) once the
stable time exceeds ~4,294 seconds.

This causes an integer overflow before the division, meaning any memory
region that remains stable for more than ~71.5 minutes will have its age
wrapped around and reset to an incorrectly small value when DAMON
attributes are dynamically updated.

This could break DAMOS schemes that target old pages for reclamation.

The bug is automatically triggered by DAMON's auto-tuning thread
(kdamond_tune_intervals), which periodically calls damon_set_attrs, or via
user-initiated sysfs attribute updates.

> -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_acce=
sses,
> +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
>  	return damon_sample_bp_to_count(
> -			damon_sample_count_to_bp(nr_accesses, old_attrs),
> -			new_attrs);
> +			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708135359.1225=
87-1-sj@kernel.org?part=3D5
