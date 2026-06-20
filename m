Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AB1F12E0
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977299; cv=none; b=u4gy4JWztjLQf21x5JnEbWZ03JGV4/D7hwYKHpfEJuqDsD7t0lc6S/ZspUXNRzx0IgNBYq2dN+AGDDMZcLb1aAGTLgFR/KWS6hu/5srYVsyWRRpuV4A5g4OZI3i7EIBed769KqpasUdD0Q71v3SWVGUdFMqt9iSRvHKq2CjMVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977299; c=relaxed/simple;
	bh=3JCTsvj5GUil3+IvWRPWgQR/RQFkbXSfcwKDK9yt5Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tzx/W+xmAyya1FkRQhW4GJM1ODcgCMz0YAS+6HOjbfnKzwV0GLIVkP+FfRO5/sEv0GOm4kYeZGkFfzyShVA8tTDJTXMGQ+lWNNKfoGapPSGrCtDgw0I1iXQA3Ve3L76MqWGDCUEfzKXVuuZcnn7//WwdHvKLmvMUjOvpivm49no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLQfvYcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLQfvYcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D151F000E9;
	Sat, 20 Jun 2026 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781977297;
	bh=NULrqPe1vrAuopv9fvX+n6r4QCQesazb/Qv+ep4n3d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HLQfvYccoENfI2VDqZCWJN2RhqejAqQvMmlMINa6jWSAFQmIt68TsU8zG0cNyAvNI
	 AMbbN7cwuBSbINJCd94I369GHGLTDasyr1v7n3eWX8l3eL8kPuVvN5p2633WFhd8/Z
	 Vt7tQrMGzlorhr587kKKMAtocylDkCDXi8ArxpiY6yJokTwnsoLf3a9JCYuxHVNQQV
	 SQ8XgtKZHs4DBp02SpMqAlpqzy9d+fzlhQjgiuoe52A06nVXmWaHxUBtwmwXiqYJzn
	 5W3vyLpCZBnTmiTv22SCTT99ul5NIKdOfEWKlT/96Z4KbX29H9xWpxAG3Jgt4MwWjY
	 7rk0b6m1I5wuA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 01/13] mm/damon: introduce damon_nr_accesses_mvsum()
Date: Sat, 20 Jun 2026 10:41:26 -0700
Message-ID: <20260620174127.92593-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620173914.92469-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 10:39:30 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 20 Jun 2026 17:36:32 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Integer overflow in `mult_frac` within `damon_nr_accesses_mvsum()` corrupts DAMON moving sum access score on 32-bit architectures.
> > --
> > 
> > commit 33b6652e4ab7390d9a1e1c6a292edc9a0fec212a
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon: introduce damon_nr_accesses_mvsum()
> > 
> > This commit introduces damon_nr_accesses_mvsum() which returns a pseudo
> > moving sum of a given region's nr_accesses for the last aggregation interval.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 7e4b9affc5b06..af95783d3402a 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -210,6 +210,63 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> > >  	return NULL;
> > >  }
> > >  
> > > +/*
> > > + * damon_mvsum() - Returns pseudo moving sum value for a time window.
> > > + * @current_nr:		The value of the current aggregation window.
> > 
> > [ ... ]
> > 
> > > +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> > > +		struct damon_ctx *ctx)
> > > +{
> > > +	unsigned long sample_interval, aggr_interval;
> > > +	unsigned long window_len, left_window, left_window_bp;
> > > +
> > > +	sample_interval = ctx->attrs.sample_interval ? : 1;
> > > +	aggr_interval = ctx->attrs.aggr_interval ? : 1;
> > > +	window_len = aggr_interval / sample_interval;
> > > +	left_window = ctx->next_aggregation_sis - ctx->passed_sample_intervals;
> > > +	left_window_bp = mult_frac(left_window, 10000, window_len);
> > 
> > [Severity: High]
> > Can the intermediate multiplication inside mult_frac() overflow on 32-bit
> > architectures?
> > 
> > The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Since
> > left_window is generally less than window_len, the remainder (x % d) evaluates
> > directly to left_window.
> > 
> > On 32-bit architectures, both left_window and the resulting product are 32-bit
> > unsigned long values. If window_len exceeds 429,496 (for example, a 5ms
> > sample_interval coupled with a ~36 minute aggr_interval), the intermediate
> > calculation of left_window * 10000 can exceed ULONG_MAX (4,294,967,295) and
> > silently wrap around.
> > 
> > This wrap around would cause left_window_bp to calculate as a truncated,
> > artificially low value, leading to an incorrect access frequency score that
> > might affect memory reclaim or protection decisions.
> 
> This can happen only under a weird setup that we are not aiming to support for
> now.  We could revisit this if a real user claims this as an issue and ask a
> support.

FYI, I'm hacking on making a central validation point of DAMON parameters.
Once it is done, we may be able to strictly avoid the weird setup by adding a
validation for that.


Thanks,
SJ

[...]
