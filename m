Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091059;
	b=Wuwr0mX0KrwaRfyWGYWV32VesKCk9gfrpWbvg+bOiTa+GJpRDuOKzjnCUZFdfP+UiD6E
	 oeTPVrr89HU1IcvNd1yDhcM0FiiDn9Rpw8/Su3lgrgXNLpkGRA+Qj5HutJwQQpbTozfBg
	 Atxf/U7/qQjI04i7F1WSsFK+9qWxcc/xKr2fSVq9Cmdmd4n1iDajAQorFv7ZtxDVj7mcA
	 9FO1nlKwdi/9Zw20W7UP9OXcsp/KziPcbHCJMZSSX4A7jkmifOKTIQ7ckoai6LLE4DIpL
	 sCNG5/uBqpBno0w03HAeAIE07HTsMfLb0nhdQH9GfqabpEYxQ0m98L21Ll+wrMKSpfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uTIW9ZNXo7IGqTDCIPcbW/4Ni86f8N+1UGLWhTVhaP8=;
	b=bqkDEJ1ngSIIpq2jyr2CfWrsFV3iWTW8oLacrfFQB01K1aO1666FbivI3O4KCVpfIl5u
	 YyLT2xsOIldxN3kGrEGo4HqQQZmjnBYpKfXud83/oGj7xtywFrIKsgR0QPDDSg0Ecvaq5
	 Z3Koy0Q6qZv66LOGNwzwgKx698OfeGLJ1vLNDy/VZZ2zmvwyYTe38Lz8RgG0yzvO2jXDH
	 Naf3SOkZ+08nGhMewCeCwN6K6mHDry2+XypFj0OsnSS68SMvdP884hG5XU5alNu7g0liq
	 QthV7hSrTI9HD7TPkSczwfLI1G3mQkBwFEamI+Fd5QttpQ49qQx17FDUxFDVVYRWClw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIKJ08AS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF658606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIKJ08AS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACF71F0089F;
	Sat,  7 Nov 2026 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091058;
	bh=uTIW9ZNXo7IGqTDCIPcbW/4Ni86f8N+1UGLWhTVhaP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIKJ08ASs6Z/18JYlAd7yBe6WatK4BqkdG/0IGe4R30w9gZQUdYrT2S8/9cYK2RSg
	 scu5N709Ae8PvmqNXQWl3KxhUuiNoVanGaRRRUV2sF6m2v8FO8b+ugVxkLx05Wo0AH
	 PcSyHi4UU/gSBbm/s+W2g8nruCmUBikifij8wpdKWBY/dXlAnMka1VMyssO5YaVG9P
	 ZhZukBKtBCluRLYFjEbn9SUr6LlVx6GzZqx3Pur3jJCEnBTAR5/TenfHmO0gVLnEkJ
	 4uUKl+cLP6Yhry/nV/4w1IOEC5OXv4XohmtrgN3l4aAgu6PacUA+mX7yRBQBPC1E+S
	 MnTathE26L9KQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.6.y 1/3] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 14:37:30 -0800
Message-ID: <20261107223731.331778-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203366@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 07 Nov 2026 22:33:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon: false tried stats on split failure in
>   damos_apply_scheme()
> --
> 
> commit ae5a2312a946a6108ba6414ca8a1f6fb984dd078
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit updates damon_split_region_at() to return an error code on
> allocation failure and skips applying the DAMOS scheme in
> damos_apply_scheme() when splitting a region to fit within the remaining
> size quota fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b5b6d00d7a3b5..9d4a78deaa06a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1004,7 +1004,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					DAMON_MIN_REGION);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> >  		}
> >  		if (damos_filter_out(c, t, r, s))
> >  			return;
> 
> [Severity: Medium]
> Does jumping to update_stat when damon_split_region_at() fails inflate
> s->stat.nr_tried and s->stat.sz_tried?
> 
> At this point sz is non-zero, so damos_update_stat(s, sz, sz_applied)
> increments s->stat.nr_tried and adds the remaining quota size sz to
> s->stat.sz_tried even though scheme application was skipped before
> damos_filter_out() or c->ops.apply_scheme() ran.  Because quota->charged_sz
> is not updated either, every subsequent matching region in the same walk
> that fails to split will add sz to s->stat.sz_tried again.  Returning
> directly instead of jumping to update_stat would avoid accounting the
> skipped region as tried.

Good finding, but no blocker.  The user impact is trivial.  Also same issue
exists in the mainline.  I will think about whether to fix it in mainline and
backport to stable.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107222202.331476-1-sj@kernel.org?part=1
> 


Thanks,
SJ
