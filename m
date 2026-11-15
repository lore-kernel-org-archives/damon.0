Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777450;
	b=HkSmaO1KxD03FZ9pIuOiX337895kI9146O+7ScaoG0UQIE/HfCc+ftSCFpuMnU3qjj7E
	 9QMAB5LsKwSPLwv0kxT+/KEL81G0mSKZDrU3wcLKdrdvWKIiwQEQbQqk5KagbLwUQDtwa
	 ATfxS9QYvgwLLuoKHQVPbHpA3lm5N1X01kdeGWmQOZImaQFiWeqxV4rLPNmVTU4LnfY5D
	 FD31sgOvSk7DhdvoCAqqfUIyqpPMfV0/4qmPA1OMANzp8r5qj76IHMrM254ItQMNnaxXN
	 kgyrl/Xi9b00DsN55a0HFEe2F+daBjdZYyu9n5j8fcMmwnzN9TkOTZMiZRQVJLvGVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EE7GAzdHDxgyN97YRBQACDLzjUljmIUH3x5jpLG84+E=;
	b=b0D1W30BFpglUCMrw0Cc7rTRIGyEiuEoQogfcFteXBd+x2Ar3+z19h03ZQtN0nQGa+mx
	 Kci8i83NuPWTB2lVPQ0ZTo6OW7wAKaAJYh5+dQDfGT5BQh1vx6OcOt7k6oIxtDz2dGW1t
	 S2ftavk/I10VNxk1Fa9WzgdNPAO+bI7hjQzuzph66l9N6pTDg5mqNPZYFNtEcammGtb0x
	 sqSqwg/g/VMa/IhoyluW7262Fq1m+UmYluPjVLtXoCRvZfpZs3P/EgqgOc41lpqINPk8W
	 Smm7HBisUJurIkt55Sj7N63TyrPcCeWebj5bE9oKX2bDS7/1QrXpMmUS4qEwDxE5DoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwYVRuQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031A606A329
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwYVRuQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FDC1F000C5;
	Sun, 15 Nov 2026 21:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794777450;
	bh=EE7GAzdHDxgyN97YRBQACDLzjUljmIUH3x5jpLG84+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BwYVRuQ3+jmYVOnw/z8CebDR+LNz8kgr/CPQcAxMUOha8IjB4i7VZajFRhyWLuqtB
	 q9TepgLNsgS7Jb4tOeJm8PDeo61l/KRfxdxIFVOVf4TsQUd9Vm5tQ1N1UQfdsazrUb
	 iPNyRpeVOgme/P5NUsn0f+MHjoY3Vc4rmKXQL15Td9oi77VU7OZhp13RYijWXWvmgn
	 x/yMNpxtA4FfVnarTOOFCre6EWFUg1+3+RJUV9tRXPA4etZk8oMMVgtWBitvbsMVJm
	 vlgvvGm8nSN1aE0SBLNCls2Zo4ae144ELao1ZMKnh7+4aS37Q3hb6oQf1C/ty7OfHN
	 cmpRAt0jGMkLw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/27] mm/damon/core: implement data attribute report queue
Date: Sun, 15 Nov 2026 13:17:22 -0800
Message-ID: <20261115211723.101033-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215849@kernel.org>
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

On Sun, 15 Nov 2026 20:41:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] mm/damon: damon_init() leaks damon_region_cache on queue
>   alloc failure
> - [Low] mm/damon: missing static qualifier on damon_report_queue in
>   core.c
> - [Low] mm/damon: struct damon_report_queue comment documents head not
>   nr_reports
> --
> 
> commit 10a61bc9bab6e48534e4a8552380aecaccbee97a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement data attribute report queue
> 
> This commit adds an internal damon_report_queue structure, allocates its
> buffer for up to 1,000 reports in damon_init(), and checks that buffer in
> damon_initialized().
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0a056949604f9..3f87a7eec442e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2334,6 +2334,25 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * struct damon_report_queue - &struct damon_report queue.
> > + *
> > + * @lock:	Represent if this queue is being used by someone.
> > + * @head:	Head of the queue.
> > + * @tail:	Tail of the queue.
> > + * @size:	Size of the queue.
> > + * @reports:	Array of &struct damon_report.
> > + */
> > +struct damon_report_queue {
> > +	atomic_t lock;
> > +	unsigned int tail;
> > +	unsigned int size;
> > +	unsigned int nr_reports;
> > +	struct damon_report *reports;
> > +};
> 
> [Severity: Low]
> The comment above struct damon_report_queue documents @head, whereas the
> struct defines nr_reports instead.

Nice catch.  I will remove the comment for @head and add a comment for
@nr_reports.
> 
> > +
> > +struct damon_report_queue damon_report_queue;
> 
> [Severity: Low]
> Should damon_report_queue be marked static?  struct damon_report_queue is
> private to mm/damon/core.c, so leaving damon_report_queue non-static
> exports it into the global namespace and triggers sparse and W=1 missing
> variable declaration warnings.

Good suggestion, I will mark it as static.

> 
> > +
> >  /*
> >   * Reset the aggregated monitoring results ('nr_accesses' of each region).
> >   */
> > @@ -4308,7 +4327,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed)
> >   */
> >  bool damon_initialized(void)
> >  {
> > -	return damon_region_cache != NULL;
> > +	return damon_region_cache && damon_report_queue.reports;
> >  }
> >  
> >  static int __init damon_init(void)
> > @@ -4319,6 +4338,14 @@ static int __init damon_init(void)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	damon_report_queue.size = 1000;
> > +	damon_report_queue.reports = kmalloc_objs(*damon_report_queue.reports,
> > +			1000, GFP_KERNEL);
> > +	if (!damon_report_queue.reports) {
> > +		pr_err("report queue alloc fail\n");
> > +		return -ENOMEM;
> > +	}
> 
> [Severity: Medium]
> Does this error path leak damon_region_cache when kmalloc_objs() fails?
> Destroying damon_region_cache and resetting it (along with
> damon_report_queue.size) before returning -ENOMEM would avoid leaking the
> slab cache and leaving partially initialized state.

Good suggestion.  I will do destroy damon_region_cache.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=2
> 


Thanks,
SJ
