Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8E6FC3
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645372; cv=none; b=ar9rHqum7e4VQeYLYLoUJxPmbrXUVb12Cck5mYHBQTq3OVS7jXdHG7G/cWYtDA+KXD5E3nhUrjZ98xfW662CC6f6xl/wKEpCGSpi9DT3lHNpJFraUxqKkEYp8TmJ12H0Tv7qmTs7pA5yM1+NYYX9d1wB2Wjc5G4EWm4Vomuv5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645372; c=relaxed/simple;
	bh=RU4VDBjC2aLUn+fHKsjhW2sLkAYybz9YtaJsN6jF3Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVxhoeUFb3AV+xc/4oFan6vi1lno9kJz5dUmnVVnwrh3eBXvA7+WTQjzHY0KzdMqTsbX2IttYR6W/DrJ+7vqfTz51z122cVinim9J/B6NZUMI7e9eTXbp/6+te+MLXNBXY5kRFYmDIM2ZPiRrYWZb6KNOgvDnuz6SVenW8rmqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2ZvmJo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2ZvmJo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AAC1F000E9;
	Fri, 10 Jul 2026 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783645371;
	bh=Bd9fK0mUCPAnSfJwbbeTuq2eaGz6dy3jAjapAQydy8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2ZvmJo+vc/DeohAjldqxBJ63zPEchKzOsOTe+JvFUeie5tZkVT+7luMC2YWvczbX
	 5zqCbPR/23MwxhzSxgff0z8+CIjWqpbm5uDb4dxfxh5Ia0Uwr3Xicsp4sdB3ID9Nfi
	 UwoFBTSj3yqpBrOF99dT6Af+KOMv2l+zOOoOImTqJ6p/3koFdd+Ss9VgWpUPdYxLzI
	 Vcnnzqa+FeCXR6Waj5ChIkBu3xLQLe6ZFP+YO1lr25FQa9bkgOWJVUiEGTzcPRbI4S
	 laonvNPUaMeeSlK+z2zXbGadNiNwJXF4YNRbTGiMWJ53nCgHLVIjsNwlT6oefdsRVG
	 NptbZ1cMIoxeA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 09/19] mm/damon/core: disallow probe_hits overflow on attrs only monitoring
Date: Thu,  9 Jul 2026 18:02:43 -0700
Message-ID: <20260710010244.112723-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710004235.D59DC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 00:42:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing validation in `damon_valid_probe_params()` fails to prevent a 32-bit integer overflow of the weighted sum of probe hits.
> --
> 
> --- Patch [9]: [RFC PATCH v1.3 09/19] mm/damon/core: disallow probe_hits overflow on attrs only monitoring ---
> commit c184df8a3c8632af7a06675128fa4e375050fa8c
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: disallow probe_hits overflow on attrs only monitoring
> 
> This commit adds validation logic to prevent an 8-bit overflow of
> probe_hits when the aggregation interval is much larger than the
> sampling interval. It checks the parameters in a new function,
> damon_valid_probe_params().
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7d49420ea26c4..4f1425e56950b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1332,6 +1332,19 @@ static void damos_set_filters_default_reject(struct damos *s)
> >  		damos_filters_default_reject(&s->ops_filters);
> >  }
> >  
> > +static bool damon_valid_probe_params(struct damon_ctx *ctx)
> > +{
> > +	unsigned long sample_interval;
> > +
> > +	if (!damon_has_probe_weights(ctx))
> > +		return true;
> > +
> > +	sample_interval = ctx->attrs.sample_interval ? : 1;
> > +	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
> > +		return false;
> > +	return true;
> > +}
> 
> [Severity: Medium]
> Since we are adding validation for the 8-bit probe_hits overflow here,
> should we also validate that the 32-bit weighted sum of probe hits doesn't
> overflow?
> 
> If a DAMON context is configured with probes where probe->weight is large
> enough, probe->weight * max_probe_hits (up to 255) could exceed UINT_MAX, or
> their cumulative sum could overflow. This would result in an incorrect score
> being returned by damon_probe_hits_wsum(), causing improper region merges in
> damon_merge_regions_of() and degrading monitoring accuracy.
> 
> While damon_has_probe_weights() currently returns false making this path
> unreachable, would it be safer to add the weighted sum overflow check now to
> prevent issues when probe weights are fully implemented?

That's exactly what the next patch of this series is doing.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710002349.111414-1-sj@kernel.org?part=9


Thanks,
SJ
