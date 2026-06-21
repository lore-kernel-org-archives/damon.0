Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576B2AE76
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782072100; cv=none; b=nP6ADliE2z1CBqYlfaZdEo0Jb10ZxHX0f8IF8IhWQWlzkVdSdDVpISNnpqUj9swJ0mKOlKWvlL5JNUs97uBi2dw9weWkkoRkk5lGJ8X9waujzDwdaDx+hv0c01Rn3bkVew3z8Cs3g5H5yVdblEQkE9lNSTdW+CRa1DxpLJZKCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782072100; c=relaxed/simple;
	bh=zjab617Mgrk976jEa4t2ajIuCZMJlpUgObTi3Vcr8ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip+sHbOcfLvSE6y5l6eBV0cJudoDj56hndTARbrxMD2Zsil2FtC9pBCtl1dcp4YJ12j3G+uS0jdjogfvAbEmEbjXZZtWKJqB77KD5k+EBQNWSXWxjMSHFA4yWbpje1oxE5/lawIhQWCs/f6Z7zR89VsSoUqm56OfHUN/xaYqvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3y/bQ3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3y/bQ3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC791F000E9;
	Sun, 21 Jun 2026 20:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782072099;
	bh=RKqoNX+o+vGrDbfymdBq9tgl4zMuU2/zLAp0WDihDo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S3y/bQ3GFzqEAgxhPNI531kYvcGWwmIpY67kiYeC2AJ9lrTveZmLMkvzd3MGIAFG1
	 rBY7Gf62Hyrow++hEV0dcG6KH0F0q0jozGz+z9CNbvAnb7JHqWnxG7UYF98teGV9Ts
	 D774FudF1hOI/1pzoQPfAmTeXXwdN52J+lFuByo942CIY8DSFXzAolz89ZTljio0ht
	 Xj856f8Ou2Y/CfXXZQ2hQ+/+1SfDFeufz4uK4As/RG+q508jxaFA17xGmeXcFiRrOh
	 HJkDU2P3A3Y7NY2ph/hPR17T5EjrdZz6pRz8TnNBNVV1Q6cMsGxvtmWRIJ2skfsNgg
	 Y1WUmMTLcP+RA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 01/17] mm/damon: introduce damon_nr_accesses_mvsum()
Date: Sun, 21 Jun 2026 13:01:29 -0700
Message-ID: <20260621200129.9978-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621161038.AE9411F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 16:10:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Integer overflow in left_window_bp calculation on 32-bit architectures
> --
> 
> commit c5893684a7c356bd0f4693c2ef6895c46e83d332
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: introduce damon_nr_accesses_mvsum()
> 
> Introduce a new DAMON core function, damon_nr_accesses_mvsum(), to return a
> pseudo moving sum value of a given region's nr_accesses for the last
> aggregation interval. This value acts as a relative access frequency score
> that is updated only when requested.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> > +		struct damon_ctx *ctx)
> > +{
> > +	unsigned long sample_interval, aggr_interval;
> > +	unsigned long window_len, left_window, left_window_bp;
> > +
> > +	sample_interval = ctx->attrs.sample_interval ? : 1;
> > +	aggr_interval = ctx->attrs.aggr_interval ? : 1;
> > +	window_len = aggr_interval / sample_interval;
> > +	if (time_after_eq(ctx->passed_sample_intervals,
> > +				ctx->next_aggregation_sis))
> > +		left_window = 0;
> > +	else
> > +		left_window = ctx->next_aggregation_sis -
> > +			ctx->passed_sample_intervals;
> > +	left_window_bp = mult_frac(left_window, 10000, window_len);
> 
> [Severity: Medium]
> Can this cause an integer overflow on 32-bit architectures?
> 
> Looking at the mult_frac macro, the remainder is multiplied by the numerator:
> r * n_ / d_
> 
> If user-configurable parameters result in a large ratio, such as a 10
> microsecond sample interval and a 5 second aggregation interval, window_len
> becomes 500,000.
> 
> If left_window is near that maximum, for example 499,999, the intermediate
> multiplication inside the macro would be 499,999 * 10000. This evaluates to
> 4,999,990,000, which exceeds the 32-bit unsigned long maximum of
> 4,294,967,295.
> 
> Could this wrap around and result in an incorrectly small remainder,
> producing an inaccurate left_window_bp percentage? Passing 10000ULL might
> enforce 64-bit math to avoid this.

It happens only in weird setup, so we are ignoring this issue for now.  We can
revisit if a user claims this as an issue.


Thanks,
SJ

[...]
