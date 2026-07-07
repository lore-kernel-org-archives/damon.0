Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2642255B
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434481; cv=none; b=t09uSCczMfIAwsqEDrTOTlyCg6lXOk+4QDE5/yitmgiXjQ8z+0/fTV+DFS+mjdSDmdcKtGpUwrbeMFAj/tnbkR/l/0fTDqbIz0MpaBOu6M0cFrNwaGfn6MxVRp3rV8SLadpL2N2BaV2uHOY+g0P5NwXxOubRCGw/u7DRu64aZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434481; c=relaxed/simple;
	bh=jAmQHnIzN6OjC8+m6MS1YjZNrNrdKj7D8nO8xWmEbKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDcP4Jybw0u+hw+NTMpqMe5h03ZGWshaQrxLIEz5ZJewvpMiMm1xWw6nI7b+t0BnP4xDVhag6DSDl4sj0igKzgB0SJLAi17qCGOspIX2th/YCGvfgW4JIVENOeIkOkgebSwmi6QjzxLbfQES4dLs7+sU0wLThwwaenmSA1j4e1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqtZyMA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqtZyMA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5E41F000E9;
	Tue,  7 Jul 2026 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434478;
	bh=rhoI1gFWBOgYYS1uvhkV5IeWTssMRdckpWiJ07qOums=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqtZyMA9NSKLb3camnPniS+1Rfc/FI6Zu9dTDt6igdQF2DS6EpfLuh4TmuAQUAIAa
	 3e1JlrIccWjseWjPJ5HW/TN1E7hJmVGVm3/cWIltlwTPbRlwygU7ySqWCLL7tUh+Lf
	 SJeFU4pTvYwYmzeuYfJHANlpFlNDcWqqrxVpTDsWWO18DiYEx/yKWRlMIGO4urSNeg
	 7PiMcvzPeUwYF5RCx1ZCgUhPsDX9Io6vcnh2Xr4WwId3e33uxZb0ZbXASlqUPjoVNl
	 M1ak4Qjfx++ym5+v5yz3ND6dy9Si3tQrcl66Id3x2trqmqFPYUYWx+zkx03yJ7lDkM
	 3Po0OI5IVQocA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Tue,  7 Jul 2026 07:27:48 -0700
Message-ID: <20260707142749.91722-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707140516.8C3CD1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 14:05:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Incomplete refactoring: the parameter name `nr_accesses` was not updated to reflect the new generic purpose.
> 
> Pre-existing issues:
> - [High] 32-bit arithmetic overflow in `damon_sample_bp_to_count` and `damon_sample_count_to_bp` corrupts interval conversions for large aggregation windows.
> --
> 
> --- Patch [5]: [RFC PATCH v1.1 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/ ---
> commit 17e2132821e6ed9a2213f8cf4fa6bdeba54db3b6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
> 
> damon_nr_accesses_for_new_attrs() can be used for not only nr_accesses
> but also any positive sample count, like probe_hits.  Rename to be able
> to be used for such general uses without confusion.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 718268df27fa7..cda318806b65b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -890,7 +890,7 @@ static unsigned int damon_sample_count_to_bp(
> >  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> >  }
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but does this calculation silently overflow for
> large aggregation intervals?
> 
> When users configure large aggregation intervals (or very small sample
> intervals) such that samples_per_aggr exceeds 429,496, calculating the access
> frequency ratio overflows 32-bit math.
> 
> The mult_frac() macro calculates (count % samples) * 10000 using the 32-bit
> type of count. If samples_per_aggr > 429,496, the remainder can be large
> enough that multiplying by 10000 causes an overflow.
> 
> A similar 32-bit arithmetic overflow can happen in damon_sample_bp_to_count():
> 
>     return bp * damon_nr_samples_per_aggr(attrs) / 10000;

Known low priority issue.

> 
> > -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
> > +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_accesses,
> >  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
> >  {
> 
> [Severity: Low]
> Is the nr_accesses parameter name still appropriate here?
> 
> Since the function is being renamed to be used for general sample counts
> (like probe_hits) without confusion, leaving the first parameter named
> nr_accesses creates a semantic mismatch that limits the readability benefits
> of this refactoring.

Good catch.  I will fix in the next revision.

> 
> >  	return damon_sample_bp_to_count(
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707135038.90068-1-sj@kernel.org?part=5


Thanks,
SJ
