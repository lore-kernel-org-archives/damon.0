Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777819;
	b=z5aANUXyL47CWQVF5JDXUggKeQHf0h/7+HjakQ0p4GEGIft/t9//3rJzxXFaz/p86wZk
	 acddk3BjhFKFmxFo3kDs91Z29JsHn9Gxv/8TSo9u/V1rUsSr2K+cN2FdXLFuiDfegyT93
	 XisYZs5Cy/ZO8be7fmpCak6jM96Y08pXWk5OvlWR3/Xcnoiwb4dmahz4kLs4iATGHiZSU
	 j7pNtaxO6LncySPFy8uxXAwhyC/jg+tR+4LCgYTlTwVd6smIvhz/AOXCik98PYX9kWOBf
	 kgjCtYlNXFwKNHaNC/Bm7bYkJZbFS5WMzYXV5l6umj2KLpoZ/vocd2QDW2mj0J7XaCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BIErJBE4pTmp+Ek6j7ApefZdRjObg4z6oE12g+W9FPo=;
	b=16383sbuaPPBBBrGdPl1zJat2v8kSURzPI1OYf5/KCg0SPbxOnpj+oYbuHksfH80n2W5
	 gRSEvaC7yqfNK5ZJC3hUBaOitmDC/fqQA/f7vRtY+s+7YbvfAfkcHy0gg1BBKzyKjx42u
	 xnWaLNiA3skr0rFLAIE2QZLaxIl0c89RjBkuBgTQ3Iq1DXbSUVkSj+oUPykoEq14lbZuI
	 dUYl+oLkM/yLHsfTyFrTcpUXBMfW+v6A1NsmbylbV4UgFY7jNHg5KkbnU3f5wBXktsZU6
	 WZ4pLJTGTMDVOanVcNTSJK+OYrLoEuecj32l1iCs4TiDrLqQH33FEOoQALDeFMvQw5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQtCWfou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E433606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQtCWfou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F071F000C4;
	Sun, 15 Nov 2026 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794777818;
	bh=BIErJBE4pTmp+Ek6j7ApefZdRjObg4z6oE12g+W9FPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DQtCWfou/P7cpdyZdSZ5+j9dv++E7R752cAV4QGLLHLvnvcVOOCzcC9EK+jeuX9Wj
	 09qrsIpzpU9uPjlOg1ibGAPiypKvhqyzgcZXiPJdjxew6fvZ2LqJQiNXX8knTIoUI0
	 sM51aTSEDevwGIVQQO7aKFH2w2FbnT32DZZ2tiP1rlbvj/2UpztJK2CrA+CIMODbap
	 +lCJWMRT5JhU9CrJKsYin95sbtkG9Va4i/ibJX2NyPWT/DBpyr32sxOZ1k5BZUkg2R
	 WWMDDwSs/+FWrl3Y8I+jvj/j3Z/y9h/wrBmq+tkwTl/iySQ1pSZWdNI87pEQiTtg9G
	 f+FmyBN17auIQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 03/27] mm/damon/core: introduce damon_submit_report()
Date: Sun, 15 Nov 2026 13:23:30 -0800
Message-ID: <20261115212331.101376-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215851@kernel.org>
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

On Sun, 15 Nov 2026 20:42:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] mm/damon/core: out-of-bounds write in damon_submit_report() on
>   queue wrap
> - [Low] mm/damon/core: missing Return section in damon_submit_report()
>   kernel-doc
> --
> 
> commit bcb278386fb51304d0c224892db9744bf9e27c8f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_submit_report()
> 
> This commit adds damon_submit_report() to enqueue a data attribute report
> into the DAMON internal report queue using CAS-based try-locking.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3f87a7eec442e..06b85d00e38d9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2353,6 +2353,36 @@ struct damon_report_queue {
> >  
> >  struct damon_report_queue damon_report_queue;
> >  
> > +/**
> > + * damon_submit_report() - Enqueue a given report to DAMON internal buffer.
> > + * @report:	The report to enqueue.
> > + *
> > + * This function can be called from any context including the NMI context.
> > + */
> > +int damon_submit_report(struct damon_report *report)
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc comment for damon_submit_report() is
> missing a Return: section describing the 0 and -EBUSY return values, which
> triggers a kernel-doc warning under W=2 builds.

Nice catch, I will add Return: comment.

> 
> > +{
> > +	struct damon_report_queue *queue;
> > +	int lock_old_val;
> > +	unsigned int tail;
> > +
> > +	queue = &damon_report_queue;
> > +	report->jiffies = jiffies;
> > +	lock_old_val = atomic_cmpxchg(&queue->lock, 0, 1);
> > +	if (lock_old_val)
> > +		return -EBUSY;
> > +
> > +	tail = queue->tail;
> > +	if (tail == queue->size)
> > +		tail = 0;
> > +	queue->reports[tail] = *report;
> > +	queue->tail++;
> 
> [Severity: High]
> Does this write out of bounds of queue->reports[] after the queue wraps?
> 
> When queue->tail reaches queue->size, only the local variable tail is
> reset to 0 while queue->tail++ increments queue->tail to queue->size + 1.
> Every subsequent submission then bypasses the tail == queue->size check
> and writes past the end of the queue->reports heap array, corrupting
> adjacent slab memory.  Updating queue->tail = tail + 1 would wrap the
> index properly.

Good catch.  I will remove tail local variable and just use queue->tail.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=3
> 


Thanks,
SJ
