Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778855;
	b=ZlB8W6qokh0DJZkxRGho8kU0bcfdDKedemj5yZz4dCfJaareJqhiPYPfM5sRAjYVeST6
	 8oPzoslHabw4DFXjc3tcxZck1BlvFL8XdPSir1yJqEaByvQ1q0rQJFxU6ERfzISZfN8EO
	 XmrUXOX5pV+i0suvLwusb1uL1oLetXrPCC1XR5yi6DCgfpE6LBTwDhOc2yVHMy8zFs8NS
	 Tb5/wWjQMto4dNn+R1zdaEMTZbf7cjIkaIWKsQzX++eI8ZVhP0IBTZS6RJOv3Dqx1egcG
	 Jv5On6/P4wtZIuDoD4JwMiIyCffNI26pmbtEHpJrlCLBA9F+mBWwm7H3OpvFiBpU2Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/S4safQyKYUMDZEkkF+xHbEVNllVyYJAylyJJpX9130=;
	b=bLv2nxQ+POkDPCZbpWYRzn+RS71k8Fov9Nqsdp0cf277X0sVNyYWr/4kHGZKWLZ60HEN
	 K1dKvKvT+8RN2VwujUPFtWS+UfE3NWi9S4vGU5rItNvBIOu3MUs7/v1xTFVsUYKYUTwb/
	 j0qQocgjs+yEmoZSuGXeGrmOWxDR9r60xEohHvCZrsySOVsPhSHLAuB9g6irDYtmrG5pI
	 MPOa4KDCCwVXySh1YXvYCXqcCbCw18d+sq5tBBOMFW1osvLxl/wdeqen4YEWfFnUmOsxi
	 UBYff79aH2acjvgSJv7wjGDEb0DkRJEjTRdMiKTkawd4iMHL9Zj20f/7Qa7p2og/ldA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWVkNKgi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD776606A329
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWVkNKgi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786FD1F000C4;
	Sun, 15 Nov 2026 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794778855;
	bh=/S4safQyKYUMDZEkkF+xHbEVNllVyYJAylyJJpX9130=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NWVkNKgi4HAVgO8yxvzbUMZttdMuKNSYPsINUauhthdooX0XbZajxOS2XuO7BKuuz
	 il0y12Av6NcQ0br0vqEgBkunDDx2coVcTbzRpofRk6rZLw8+ZkGO8tRv3F4NgkLb/v
	 sSSBlPO/bZPQBEb+mz9xpvDaqZqHwflDT1jNU9IHpJzzxduiWbkzzzBW2JprvhpkrB
	 hFb6BYHi84ggRLqTQBNdj6hNfSo9pKvOqdVnyc9Sk0XuzqDak7mzUqh9E8L+WA21hU
	 +vBhwaRw8u5YntysRdWVzzb5QJRVoBAKi1uTLuEsQ/lmMAY/b0W1XbBE/MQJJ5Lepp
	 TvECQSOXhOyuw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Sun, 15 Nov 2026 13:40:47 -0800
Message-ID: <20261115214048.103814-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215850@kernel.org>
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

On Sun, 15 Nov 2026 20:41:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] mm/damon: out-of-bounds and uninitialized read in
>   damon_report_exist()
> - [Medium] mm/damon: phys_addr_t truncation and unit mismatch in
>   damon_pa_filter_match()
> - [Medium] mm/damon: uninitialized filter->report_type in
>   damon_pa_filter_match()
> --
> 
> commit db7c0b8660ac4e99fdce33921b7535218eaa4dc6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support REPORT_MADE type probe filter
> 
> This commit adds support for the DAMON_FILTER_TYPE_REPORT_MADE probe
> filter in the physical address space operation set by querying
> damon_report_exist() over the last sampling interval.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5b773012a8764..04e95047f8cea 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -140,9 +140,10 @@ static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
> >  }
> >  
> >  static bool damon_pa_filter_match(struct damon_filter *filter,
> > -		struct folio *folio)
> > +		struct folio *folio, phys_addr_t pa, struct damon_ctx *ctx)
> >  {
> >  	bool matched = false;
> > +	struct damon_addr_range addr_range;
> >  
> >  	switch (filter->type) {
> >  	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> > @@ -157,19 +158,27 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
> >  		else
> >  			matched = damon_folio_young(folio) == false;
> >  		break;
> > +	case DAMON_FILTER_TYPE_REPORT_MADE:
> > +		addr_range.start = pa;
> > +		addr_range.end = pa + 1;
> 
> [Severity: Medium]
> Can assigning pa and pa + 1 into addr_range truncate 64-bit physical
> addresses and miss reports when ctx->addr_unit > 1?
> 
> struct damon_addr_range defines start and end as unsigned long, so on
> 32-bit PAE/LPAE systems where phys_addr_t is 64-bit, physical addresses
> at or above 4 GiB lose their upper 32 bits (and pa + 1 wraps to 0 when
> the low 32 bits are 0xffffffff).

Missing a report for this edge case is fine.  It only degrades DAMON's
monitoring results, which is anyway best effort.


> In addition, when ctx->addr_unit > 1,
> pa is aligned to ctx->addr_unit, so setting addr_range.end = pa + 1 only
> checks the first byte of the sampled unit instead of [pa, pa +
> ctx->addr_unit).

That's fine.  Technically speaking, the sampling is only for the sampling byte.

> 
> > +		matched = damon_report_exist(filter->report_type, &addr_range,
> > +				jiffies -
> > +				usecs_to_jiffies(ctx->attrs.sample_interval));
> > +		break;
> 
> [Severity: High]
> Does calling damon_report_exist() read uninitialized or out-of-bounds
> elements from damon_report_queue.reports?
> 
> In damon_submit_report(), the report is written at queue->reports[tail]
> and queue->tail is then incremented, so queue->tail points to the next
> slot to be written and is never wrapped when it reaches queue->size:
> 
> mm/damon/core.c:damon_submit_report() {
>     ...
> 	tail = queue->tail;
> 	if (tail == queue->size)
> 		tail = 0;
> 	queue->reports[tail] = *report;
> 	queue->tail++;
>     ...
> }
> 
> mm/damon/core.c:damon_report_exist() {
>     ...
> 	idx = queue->tail;
> 	for (nr_read = 0; nr_read < queue->nr_reports; nr_read++) {
> 		report = &queue->reports[idx];
> 		if (idx)
> 			idx--;
> 		else
> 			idx = queue->size - 1;
>     ...
> }
> 
> Because damon_report_exist() indexes queue->reports[idx] at queue->tail
> before decrementing idx, it reads uninitialized heap memory on the first
> iteration while 1 <= nr_reports < queue->size (and never inspects index
> 0), and reads out of bounds at queue->reports[queue->size] and beyond once
> queue->size reports have been submitted.

Yes, I will fix it in the earlier patch.

> 
> [Severity: Medium]
> Can filter->report_type be uninitialized here when a new
> DAMON_FILTER_TYPE_REPORT_MADE filter is added via damon_commit_ctx()?
> 
> damon_new_filter() allocates struct damon_filter with kmalloc_obj()
> without zeroing the union, and when damon_commit_filters() creates a new
> filter it only copies union members for DAMON_FILTER_TYPE_MEMCG and
> DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> 
> mm/damon/core.c:damon_commit_filters() {
>     ...
> 		new_filter = damon_new_filter(src_filter->type,
> 				src_filter->matching, src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		switch (src_filter->type) {
> 		case DAMON_FILTER_TYPE_MEMCG:
> 			new_filter->memcg_id = src_filter->memcg_id;
> 			break;
> 		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> 			if (src_filter->range_max < src_filter->range_min) {
> 				damon_destroy_filter(new_filter);
> 				return -EINVAL;
> 			}
> 			new_filter->range_min = src_filter->range_min;
> 			new_filter->range_max = src_filter->range_max;
> 			break;
> 		default:
> 			break;
> 		}
>     ...
> }
> 
> As a result, new_filter->report_type retains uninitialized slab bytes
> when damon_pa_filter_match() passes it to damon_report_exist().

Yes, I will fix it in the earlier patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=14
> 


Thanks,
SJ
