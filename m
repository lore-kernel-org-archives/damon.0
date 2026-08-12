Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E02C1586
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542258; cv=none; b=QLEEc1iUPpkf3X0nZbOHDXnPLXhQp/JS+211YyO4LcxUwSkjTz4RrNIpxq+fZs5gUy+I79hUNwd8RFGJGKEwNsA41mzo2Duzoz5Eajf+VNcCb5PgE2hhHeOc0uxT/Urd1k3EhFSVAkYTda7Do0PguQ507hVXJNAo5maNL2y/93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542258; c=relaxed/simple;
	bh=VWrzFbZM+bEE42dFyQtL5zUjahfeAVz6h7tClM0rnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXh8jY86Sxikpg0bIiMivXU9pehkiK4M4XdgXaKDqWf50wRJ6Vq5sIWFqMZPKP2MCi96H7qQTK3Ahea4dwLhE7Apg0/rkVcRIG+CmSAWvyIGFOTHMQuw0SSKuBDGHcxwYNYEYq3D2/M0uBkZFQ+eKwoOuHReTOo41siEguZtWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPmjVWsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPmjVWsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A81F000E9;
	Wed, 12 Aug 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786542256;
	bh=8NzYZrrYEVLbw/CuIPa3Zq1WbCYEuBXDCRrx0+50L1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPmjVWsdLbG/MGojASCuIqPbvJSUMkgHWoueOgfvO0JjuwwP7MdMVo5DLA4peGyhQ
	 4odRRiMWSPvSja5ryvZEf/Om+TBsHKb40N+V37u/m9xU4Qw7t7Lq9N+ttrKefhiiLc
	 OG29aPQk0Z4bYUrSOX/JLeQZPXZvYTx1RMk7PQJLd5YFql3JcLJ/jwV8G3eMVY1Bsn
	 6D2V0GuMcchEYsxXYvJDHLSMDDB588SrWJUy6zgFNgadk5kYq9QGgof/vG5hYrJTzI
	 mviUl3iDTjLnwWr45bNruZu6Accu/Z2xpXmpc4Gw//ri1eiK+si9DeKYnN8jxz2yJn
	 W6UvkRrYAce3w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Liew Rui Yan" <aethernet65535@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots
Date: Wed, 12 Aug 2026 06:44:07 -0700
Message-ID: <20260812134409.86636-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812104725.A567E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 10:47:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but `nr_snapshots` is incorrectly incremented per target instead of per snapshot, and skips incrementing entirely if the scheme bypasses the final region of a target.
> --
> 
> --- Patch [2]: [PATCH v2 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots ---
> commit af16039fca7bbda3290262311f6015d553f6c65f
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> docs/mm/damon/design: difference between watermarks and nr_snapshots
> 
> Explain the difference between nr_snapshots reaches max_nr_snapshots and
> watermarks.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index 1739aeec6eb95..e7977f005ac06 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -872,7 +872,8 @@ the action to the region will fail.
> >  
> >  Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
> >  non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
> > -scheme is deactivated.
> > +scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
> > +``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while documenting the
> nr_snapshots behavior, I noticed an issue in how nr_snapshots is incremented
> in the core code.
> 
> Looking at damon_do_apply_schemes() in mm/damon/core.c, nr_snapshots is
> incremented per target instead of per snapshot:
> 
> 		if (damos_quota_is_full(quota, c->min_region_sz))
> 			continue;
> 
> 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
> 			continue;
> ...
> 		if (damon_is_last_region(r, t))
> 			s->stat.nr_snapshots++;
> 
> Could this cause the scheme to incorrectly increment multiple times per
> snapshot if there are multiple monitoring targets?
> 
> Also, if damos_quota_is_full() or damos_skip_charged_region() triggers a
> continue on the target's last region, does this bypass the increment entirely?
> 
> If a scheme frequently exhausts its quota, it seems nr_snapshots might never
> increment, causing the scheme to run forever without reaching
> max_nr_snapshots.

I don't find a problem of the current behavior.  Let me know if I'm missing
something.  Let's keep it as-is otherwise.  We could add clarifications to
documents if this really confuses humans.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812104002.15225-1-aethernet65535@gmail.com?part=2


Thanks,
SJ
