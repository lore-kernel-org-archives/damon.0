Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FE3033E9
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520939; cv=none; b=t3ijr/lmfBsNapOoxDVBBiLe5UZfNn3RvfrLcPFO5G67J2SobL0ObpN3aYSo1yDP6AgVJ1fIV1aC/mG/AcaPGTjSu/faJcH1DmCWv+EYX6pg/r2bGzGIme+uVPSvgm82pDkt9kKFx24yL891TssMyu8D6qnr1m63t/xT7D7f4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520939; c=relaxed/simple;
	bh=8iHNXUOVwHt8Sn7rfQtlasqruGfR05eq75Bp1TTQdog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCdfozgWYRUSJTBBIiAu1a/ZcEqn1QswqbOyuV35qMS/jb9ugli0ZNc5NLzWePdnaIM9T/bkJTguzI3z29ojkUg+oNCXbpZoF8+IGJYKDBbXqtGfHewu64/gJXT+g+Oj9U/lMREurQpJpXj/mLSixgpTohvnUFZ+6plFeNjtL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N65onnP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N65onnP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738861F000E9;
	Wed,  8 Jul 2026 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520936;
	bh=7zX6OzEn+8yp563Oj9KdinGqRYtqKmsvb5YNaAsr0Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N65onnP0S6I1dpy391pXNTWWFzMfKODGCKhdGk2HX+1/Tra28vNIm0T+GWrMNFVFL
	 5CPahVStKFbgDcvQGdGuqAfnxiNzsg45UduhSLngVP4mF6nR34+8ggB+/lz1ZeIbvn
	 7RQrGXUGWaYgdCRATkGbhI+4HdGUyxeP918MO2BCcNjQ/pJ/WlvqYnDo4aRo3zG8A3
	 TlUQnVqNpK8MCLS/1oBxb91fXwCNcAIANXiHVzLd5T20TxXzdal3yatuU1txHpXyHl
	 xm0zF+4IeCZdezK0Yr/vCj4Q33LaBTNM4jyckr/8JX+aB1bo9qX52LUxX0AigF1LPb
	 46/cZkpzqzz+Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6/7] mm/damon/core: update probe hits for new parameter commit
Date: Wed,  8 Jul 2026 07:28:47 -0700
Message-ID: <20260708142849.124291-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708140807.F21141F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 14:08:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Scaling of `probe_hits` during parameter update produces mathematically incorrect results and silent integer truncation due to `unsigned char` type constraints.
> --
> 
> --- Patch [6]: [PATCH 6/7] mm/damon/core: update probe hits for new parameter commit ---
> commit 6ec1cede99a50d44fcfc3e2fc6a1b5334600120f
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: update probe hits for new parameter commit
> 
> Users can dynamically update subsystem parameters at runtime. This patch adds
> logic to appropriately scale probe_hits and last_probe_hits based on the
> updated aggregation and sample intervals to maintain accurate monitoring
> snapshots.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 800ff6b6d2473..15d31285515d6 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -897,10 +897,32 @@ static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
> >  			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
> >  }
> >  
> > +static void damon_update_probe_hits(struct damon_region *r,
> > +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> > +		bool aggregating, struct damon_ctx *ctx)
> > +{
> > +	struct damon_probe *p;
> > +	int i = 0;
> > +
> > +	damon_for_each_probe(p, ctx) {
> > +		r->last_probe_hits[i] = damon_nr_samples_for_new_attrs(
> > +				r->last_probe_hits[i], old_attrs, new_attrs);
> > +		if (!aggregating)
> > +			r->probe_hits[i] = damon_nr_samples_for_new_attrs(
> > +					r->probe_hits[i], old_attrs,
> > +					new_attrs);
> 
> [Severity: High]
> Does this code silently truncate the scaled results?
> 
> damon_nr_samples_for_new_attrs() returns an unsigned int, but both
> last_probe_hits[] and probe_hits[] in struct damon_region are unsigned char
> arrays. If the user updates the parameters such that the new ratio of
> aggr_interval to sample_interval scales the sample count above 255, the
> assignment to unsigned char will silently wrap.
> 
> For example, if a hit count is scaled up to 300, the stored value would
> become 44. Could this produce mathematically invalid scaling and corrupt the
> relative hit proportions that the monitoring results rely on?

Known low priority issue.

> 
> > +		else
> > +			r->probe_hits[i] = 0;
> > +		i++;
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708135359.122587-1-sj@kernel.org?part=6


Thanks,
SJ
