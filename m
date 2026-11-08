Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167206;
	b=Fb0SbtzWXRT58gZ0XH0PlfOl5m1dgt8v9HpSN/oHHeXmM/+Nv4mESQ2/qQDrgoYHvUo1
	 ajbK1h3BwetD6p5DD82VjkRLsOHFrgbq+o9bAl0V3nUzw9unAVUsy7TFEmv3wA0tEL0p+
	 3JMQEiVaAmKvb3bBoW93je9N5crSUkBIcA3Q2ARDZi5m1qOBVRxSS1q7nvvZfihT3+G8j
	 /GnyZd7YcuemgT03Okj1e15xATZWI5pceeYxd36ab5PVgc1f+vhEJ3u0Qf9yn2pIVHNOO
	 eJhy3/PsC49Gl9Zg8GCunelMMEx03MIHoeFH7hPXxvHCdC6RT4qVIb7f3IuQyD/yjrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y4MXQB0d5OO+Xw7/ROgTp06CLIKVRXeSlRHb44daKF0=;
	b=Tf2vkkpq7OuzujC+9CN0bFfiMmXvsd75q1RedZAihE9RXrYI3N8yblsP8qSIG1hYmnBX
	 mqn/nA3+/qIy8D0sLSbGA8FXd519JiHrwojPHRZ2qsRWl0CX0q5QdhFNuo541f87wAvrW
	 diIayL0ahLShPSVN7JtvvRJxk2qOyFnvma2twcgA+Wo20dJo5fdGo7HRqsdoNzJk/wPDO
	 5zRJX/o+Ibs8P829i0f8v9Fd3Z7XKfzz03ix3MRpj/kVSEnOs798QKjWZzQAJpdZu1dsE
	 7mm6mxKkv+UpouI84juTZz9/YTCOVQDqXrCe3yHnOGBOGVB2x4ugK9Mu2YnyQ9xX8ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiNaJml9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12611606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiNaJml9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8971F0089F;
	Sun,  8 Nov 2026 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167205;
	bh=y4MXQB0d5OO+Xw7/ROgTp06CLIKVRXeSlRHb44daKF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiNaJml9w7xbzmSGW9dLEwANh6uBGKMFncxmKnh5/u7Zb1LovygIjeicXdyolnfcN
	 1rEuoshl3KMJU93O3FTQeMj/H0kZ6/4/aVW2fq04snZ0a2oKoH4m2TdVvRq98fqCOV
	 D6xzC1t0mUrZ6xC01r9H1Vi9HkCipC7CsmyfcEm2R+Y96mU15YfdYtyR1hZKfpjay+
	 ZVw9R+rWwu8941zxQ9QNyvo4CsLVf71ocIJRGPpGVwG0qqnTT1RnAkIagRL8jjEsIP
	 jnhEKiv1W2dBga1C/6emu0QPoVLL3kQyRtjT4jaz217TOh4DvAOk2CF//GMGc+Su6C
	 D6RvwpSPLCrcQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y 1/5] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sun,  8 Nov 2026 11:46:37 -0800
Message-ID: <20261108194639.115062-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203968@kernel.org>
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

On Sun, 08 Nov 2026 19:35:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon: damos_apply_scheme() inflates stats on region split
>   failure
> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [High] mm/damon/core: total_charged_ns overflow in
>   damos_apply_scheme() [1]
> --
> 
> commit 9174bd7b58d2e2acd57046175fb6abb05138bbb9
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit updates damon_split_region_at() to return an error code on
> allocation failure and skips applying a scheme in damos_apply_scheme()
> when splitting a region for quota enforcement fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 8fa788b0d709c..4c536a9b958e4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2000,7 +2000,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					c->min_sz_region);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> >  		}
> >  		if (damos_filter_out(c, t, r, s))
> >  			return;
> 
> [Severity: Low]
> Does jumping to update_stat when damon_split_region_at() fails inflate
> s->stat.nr_tried and s->stat.sz_tried?
> 
> At this point sz is the non-zero aligned remaining quota size.  Jumping to
> update_stat calls damos_update_stat(s, sz, 0, 0), which increments
> s->stat.nr_tried and adds sz to s->stat.sz_tried even though
> damos_filter_out() and c->ops.apply_scheme() were skipped.  Because
> quota->charged_sz is not updated on failure, subsequent oversized regions
> in the walk that also fail to split will repeatedly add sz to
> s->stat.sz_tried.

User impact is trivial and the same behavior exists in the mainline.  No
blocker.

> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can
> quota->total_charged_ns overflow on 32-bit architectures [1] in
> damos_apply_scheme()?

Known low priority issue.  No blocker for this patch.

> 
> struct damos_quota defines total_charged_ns as unsigned long, which wraps
> around zero after roughly 4.29 seconds of accumulated scheme execution on
> 32-bit platforms:
> 
> include/linux/damon.h:struct damos_quota {
>     ...
> 	unsigned long total_charged_ns;
>     ...
> };
> 
> mm/damon/core.c:damos_apply_scheme() {
>     ...
> 		quota->total_charged_ns += timespec64_to_ns(&end) -
> 			timespec64_to_ns(&begin);
>     ...
> }
> 
> mm/damon/core.c:damos_set_effective_quota() {
>     ...
> 		if (quota->total_charged_ns)
> 			throughput = mult_frac(quota->total_charged_sz, 1000000,
> 							quota->total_charged_ns);
>     ...
> }
> 
> When total_charged_ns wraps to a small value, damos_set_effective_quota()
> computes an inflated throughput and effective size quota (quota->esz),
> causing DAMOS to process far more memory than allowed by the time quota.
> 
> [1] https://sashiko.dev/#/bug/linux-c8969436-aa48-48c6-9f46-a12a64361494
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108192221.114362-1-sj@kernel.org?part=1
> 


Thanks,
SJ
