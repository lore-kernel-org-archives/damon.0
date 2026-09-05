Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6948D864;
	Sat,  5 Sep 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625214; cv=none; b=YMwcYLTLNuBeGyS5T0bbRlMbOzXqWHzOmI4Yv0ZSjMVFb1nXaj4YrmDxyaiDRhewjxcGsahVk0aEJkgUuPSw5C9ZHwPoKpLazG5Wi064s7v4LbswA0oC4afOAu1rOqKlY+Y99/48r3a8FuVvlD7ikq6HIfo22m2z8aGUx6zHVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625214; c=relaxed/simple;
	bh=yZFzaZG2EjIh+oa6SfjzWZQf4ATTjk4lWhirP6AFrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8J/dsDGb6nQmCLakILeHl8/VrxO3/5AJFgX2C1kWeYouLOQ+CckTm33KXY58YR8YSbBuwSuzvIujUEoeLTHnuz2NsnK8ScfaTN4c7TPGu99n+K4PKQVUSwRwRubY7vP9aULo2reIdb87DahacIRYlpm1QISaCeZ0Qq9AHsYt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5HB+HN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5HB+HN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB01F00A3A;
	Sat,  5 Sep 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788625211;
	bh=X9c+rTBEpEP+lEVEOLawAS9xxcDyI8k+R6OPvcOlW4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5HB+HN+y2pAZKTqZID/xBnzu4/JkJPTxFjtcXXd74fhhKnZmNBRuY0hx4Xkyvhw0
	 LG28SHok2v22x3RzmIqmVhAE6Qx4a4IylXbY92DA9QZeAz0Zx7OnesjtON4hYjFSuE
	 J0gVWUNK79PfQyV2ofDPcUF8QTM/FhxC4VohoeR6hQRtaOGeulQfO5h9wjYnRsg6/U
	 yDKtDBMq0xRdE1hmkxctvYMEn3FlbjkvvusBczrzlDmM3/BtE/8I1TfgYGOoIchoE/
	 nlkxlBRd/GMU98pC1QYpI+LThoB2sp6cdnLp++B4M56wDqKeHktQRGDYlNl8XHFyJ/
	 yIN/pve0bU6Rw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	sashiko-bot@kernel.org,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/core: allow esz to be set to zero
Date: Sat,  5 Sep 2026 09:20:02 -0700
Message-ID: <20260905162004.82205-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905141416.4347-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat,  5 Sep 2026 22:14:09 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat, 05 Sep 2026 12:58:25 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] 32-bit integer overflows in time quota and throughput calculations lead to severe miscalculations on 32-bit architectures.
> > --
> > 
> > commit dc1c35769ce920ee1796367097f9876b2f24a643
> > Author: Liew Rui Yan <aethernet65535@gmail.com>
> > 
> > mm/damon/core: allow esz to be set to zero
> > 
> > This commit modifies damos_set_effective_quota() to allow the effective
> > size to be set to zero when the goal has been achieved. It changes the
> > order of max and min calculations when quota->ms is set to ensure
> > that a zero esz_bp results in a minimal effective size instead of being
> > clamped to min_region_sz.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index ce8c6f99106ed..3e9c9b6385d4e 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -3259,8 +3260,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
> > >  					1000000, quota->total_charged_ns);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does mult_frac() silently overflow on
> > 32-bit architectures here in damos_set_effective_quota()?
> > 
> > Since quota->total_charged_ns is represented as an unsigned long, it natively
> > overflows after 4.29 seconds on 32-bit systems. Furthermore, when
> > calculating throughput via mult_frac(), the remainder calculation
> > (sz % ns) * 1000000 can silently overflow a 32-bit unsigned long, which
> > causes throughput estimation to be completely incorrect and often near zero.
> > 
> > >  		else
> > >  			throughput = PAGE_SIZE * 1024;
> > > -		esz = min(throughput * quota->ms, esz);
> > > -		esz = max(ctx->min_region_sz, esz);
> > > +		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
> > 
> > [Severity: High]
> > This is also a pre-existing issue, but can throughput * quota->ms overflow 32
> > bits for quotas over a few seconds here in damos_set_effective_quota()?
> > 
> > If this wraps around on 32-bit architectures, it improperly clamps the
> > effective size to ctx->min_region_sz, nullifying the time quota feature.
> > 
> > > +		esz = min(esz_time, esz);
> > >  	}
> > >  
> > >  	if (quota->sz && quota->sz < esz)
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260905124706.3398-1-aethernet65535@gmail.com?part=1
> 
> Thank you for pointing those out!  I will fix those separately.

These are known low priority issue that I'm working on.  Let's not duplicate
works.


Thanks,
SJ

[...]
