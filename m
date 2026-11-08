Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171707;
	b=Tp2bxrHnvVVnmtlZ4rb9eipvDAsG5GeDbrlUbrHlqAmx60n6uSogR0oiX8/KXnEXxNk3
	 KrudzHgMPqyEpQsr0NQC9h5SUJ5o4uzCFvc5lDZInkd177dvtYRVzuJc6n71d+938rZsW
	 CxsMitpiF0zezd+vDLKlTktxEV1sQwQQ9WNP0VUaOWA2lhgvF+3SGyskgD4sUV8vIBXO6
	 U/zQu6KC7+sxU1/JISzw7ZgYOOi8IK9q2gy0aqYS+2TZmsC59XdxYIWrkM6hXg6mTZiwc
	 VGbK4NCuGAA7MNT0Rhlpkfui7ed+0Z/2jvZD3TjnkzvEFtEecx3xFBdLVQZUr8JclrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LlRw1T3EhDLk7qpw1Iv3e7L77NPv6Myz+uuZpVhsszI=;
	b=ZTfFz3sAnzueZ4iZx1YaBG4vf8obvkab8TOpJftkfeYV54E6jmtTVNSi9EMKnNsInRlS
	 z8ttOoL3XmMv6OGPHTyWGECPrU1SQs4cbTXgUEnCNPKRj/vEkPKR6cmFZkfAEW/1kFdpm
	 4fWrNXM3tvLVxV0gBua59/04sCXRYlvlrqSuLLWP/9LYrQJiD9USN+ACDDzly/HMLLJ0o
	 LDJ3WKPOhlzMiITeKc1hSTi0P+6J4vnpnR3rUschZIxo9L1FciEr16H9kgMi1gZs0e2hg
	 ATMJSKSzI4xzVG6xyfwtzfXmDCQ5KY9ul10whSRDXD8lhhNbpwlYx2/eMrLTv1wnxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHvQJEZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864D606A321
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHvQJEZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C728D1F008A1;
	Sun,  8 Nov 2026 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171707;
	bh=LlRw1T3EhDLk7qpw1Iv3e7L77NPv6Myz+uuZpVhsszI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHvQJEZm1OHVlrkHXPv0o9B3+mNxp6d8OeOu8Ms2swuGncA3vCencR/PNNlMeLHbS
	 FTqXLaA31Q+LSWY0NZq6/xtPOa/7Y9LzeGnonavPI94pD7bAMm9Z2CjarWPQjLLE8t
	 9c7jmyaWMvXYzsUqhwywIGmOTG+QDHV/QvovtcbNLnCGpYiUNNa+L7XGjaIWOhadFV
	 YHo91DIFEGM8C/7m0NiLxQNJewxOmKBmcMBXgWOGWt72q23QgognUsvRTJYofz+Qwt
	 8j6u5mVmzv/T2t/ya717XIuGYvd2AnyefCvwyhB52UxoIyi3nu+mAF2b9C8cHgzNrb
	 3pcHTOnAozH1g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.1.y 1/2] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sun,  8 Nov 2026 13:01:38 -0800
Message-ID: <20261108210140.908-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-204020@kernel.org>
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

On Sun, 08 Nov 2026 20:36:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon: inflated tried stats in damon_do_apply_schemes() on
>   split failure
> --
> 
> commit 3b087258b4341cba87012b7cb96ed676fd164c12
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit updates damon_split_region_at() to return an error code on
> allocation failure and skips applying the DAMOS scheme in
> damon_do_apply_schemes() when splitting a region to fit the quota fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f0da5cb2b88a0..9206737d05ae7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -810,7 +810,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  						DAMON_MIN_REGION);
> >  				if (!sz)
> >  					goto update_stat;
> > -				damon_split_region_at(t, r, sz);
> > +				if (damon_split_region_at(t, r, sz))
> > +					goto update_stat;
> >  			}
> >  			ktime_get_coarse_ts64(&begin);
> >  			sz_applied = c->ops.apply_scheme(c, t, r, s);
> 
> [Severity: Low]
> Does jumping to update_stat on damon_split_region_at() failure inflate
> s->stat.nr_tried and s->stat.sz_tried?
> 
> When damon_split_region_at() fails, sz is the non-zero remaining quota
> size, c->ops.apply_scheme() is skipped, and quota->charged_sz is not
> advanced:
> 
> mm/damon/core.c:damon_do_apply_schemes() {
> 	...
> update_stat:
> 		s->stat.nr_tried++;
> 		s->stat.sz_tried += sz;
> 	...
> }
> 
> Because quota->charged_sz remains unchanged, subsequent matching regions
> can repeatedly add sz to s->stat.sz_tried if allocation continues to fail.

Trivial user impact issue.  The same behavior exists in the mainline.  No
blocker for this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108202759.117377-1-sj@kernel.org?part=1
> 


Thanks,
SJ
