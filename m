Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775295;
	b=SgHbXjsuaZzscJ8FNU8GfQwKLXpPLiB1pDZNr2IcvmEPa3pIaXflYoxtQePbxbpUxJtB
	 KMuk7DpobGOB09WXqggTI9KRxAylTs1B6dbvFtj8P2GL/LD6gwFbe16DpC0PNNAsAn1S4
	 AuYNpwmgnkIUqbf1FFkKgAmMQ1XA9f76ENKxfZD/OpSGwr1oEo3Ik3RlAFFimhGpV44x1
	 +htO6PkzFb+UruL2937Q2Gu28yBp0GldTzdQbm2bYq5KyGe/TvDWkQaxpTmFFTmaWfhPA
	 JvyVqY21i9E1V8/HO2MhiGL/6nN0VbQ9p4Qd9uVE3rb9P9ZsYY/H/rUoV+xsJCnrVxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q4vAPhP/V1Bp8qYGqnFchGNpQrdWi5lSaW3Lmn/+Q0E=;
	b=yH0FLapT8kflJ3UZMmujbAtGarDh2Dno4f89OgxjhBfuqeUP/MioXoC7BYUP0sqL+afQ
	 E2TgmQgBdrKskN0MGmLNpeU+4Mn8XI6ZhcHuJ/bZKBXRkLVoZSAcKM4NO1MuV0viGLMtw
	 pK6IHqvbhjXfjNjbw+AvzqXanc4TJxbVhjf4ULPnuwXVnNtS1P0MMlYEVcpRisAeWRH6Q
	 G+5hoydndd7NCHwxqVCU8kMwTcqs4b/4phXwkF1fJHYP+dKWE8S9P1msK2kUfTbiP6D55
	 YnYLIrCr2wL4p35aLFfXtISXE8RL9Un/dmDiO52Dreg0IFDCGMET2Hn/mqsvBapSuYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGCaiakI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FF606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGCaiakI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE87D1F000C4;
	Sun, 15 Nov 2026 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775295;
	bh=Q4vAPhP/V1Bp8qYGqnFchGNpQrdWi5lSaW3Lmn/+Q0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGCaiakIfl1kezaf+/ujmceYlD7vtcZ0Ev8DWvP5MSBcLVTnKerZQofuwmGY7/LLa
	 2a0NuYDoXGKY72Uc+2yah1dVO5COdg6izZ5D2YrwEZwgtytMjy4cFYXjNdS/jx8zUp
	 Axp11qCyNEX1is3jALAC5fo5xhtgMCT1l413hb+tqmR7LteRoVhvzKWCuFYfinj0JU
	 +5PyZR1DHVG5vNz3bvhjZ52ZODUAgWO+GyaKh2uprvy9vk9/+dBBCS7JRFea8SXNC5
	 hHzfvu1hb3HmEtr+LSuXuGVjCgqKSMHQduj6w7ksO544b9HdqOI4xWUWbuhHV0iUv3
	 7Lt/WPL5eo5VA==
Message-ID: <sashiko-outbox-215850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/27] mm/damon/paddr: support REPORT_MADE type
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-15-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:41:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] mm/damon: out-of-bounds and uninitialized read in
  damon_report_exist()
- [Medium] mm/damon: phys_addr_t truncation and unit mismatch in
  damon_pa_filter_match()
- [Medium] mm/damon: uninitialized filter->report_type in
  damon_pa_filter_match()
--

commit db7c0b8660ac4e99fdce33921b7535218eaa4dc6
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support REPORT_MADE type probe filter

This commit adds support for the DAMON_FILTER_TYPE_REPORT_MADE probe
filter in the physical address space operation set by querying
damon_report_exist() over the last sampling interval.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5b773012a8764..04e95047f8cea 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -140,9 +140,10 @@ static void damon_pa_prep_probes(struct damon_ctx *c=
tx, bool set_samples)
>  }
> =20
>  static bool damon_pa_filter_match(struct damon_filter *filter,
> -		struct folio *folio)
> +		struct folio *folio, phys_addr_t pa, struct damon_ctx *ctx)
>  {
>  	bool matched =3D false;
> +	struct damon_addr_range addr_range;
> =20
>  	switch (filter->type) {
>  	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> @@ -157,19 +158,27 @@ static bool damon_pa_filter_match(struct damon_filt=
er *filter,
>  		else
>  			matched =3D damon_folio_young(folio) =3D=3D false;
>  		break;
> +	case DAMON_FILTER_TYPE_REPORT_MADE:
> +		addr_range.start =3D pa;
> +		addr_range.end =3D pa + 1;

[Severity: Medium]
Can assigning pa and pa + 1 into addr_range truncate 64-bit physical
addresses and miss reports when ctx->addr_unit > 1?

struct damon_addr_range defines start and end as unsigned long, so on
32-bit PAE/LPAE systems where phys_addr_t is 64-bit, physical addresses
at or above 4 GiB lose their upper 32 bits (and pa + 1 wraps to 0 when
the low 32 bits are 0xffffffff).  In addition, when ctx->addr_unit > 1,
pa is aligned to ctx->addr_unit, so setting addr_range.end =3D pa + 1 only
checks the first byte of the sampled unit instead of [pa, pa +
ctx->addr_unit).

> +		matched =3D damon_report_exist(filter->report_type, &addr_range,
> +				jiffies -
> +				usecs_to_jiffies(ctx->attrs.sample_interval));
> +		break;

[Severity: High]
Does calling damon_report_exist() read uninitialized or out-of-bounds
elements from damon_report_queue.reports?

In damon_submit_report(), the report is written at queue->reports[tail]
and queue->tail is then incremented, so queue->tail points to the next
slot to be written and is never wrapped when it reaches queue->size:

mm/damon/core.c:damon_submit_report() {
    ...
	tail =3D queue->tail;
	if (tail =3D=3D queue->size)
		tail =3D 0;
	queue->reports[tail] =3D *report;
	queue->tail++;
    ...
}

mm/damon/core.c:damon_report_exist() {
    ...
	idx =3D queue->tail;
	for (nr_read =3D 0; nr_read < queue->nr_reports; nr_read++) {
		report =3D &queue->reports[idx];
		if (idx)
			idx--;
		else
			idx =3D queue->size - 1;
    ...
}

Because damon_report_exist() indexes queue->reports[idx] at queue->tail
before decrementing idx, it reads uninitialized heap memory on the first
iteration while 1 <=3D nr_reports < queue->size (and never inspects index
0), and reads out of bounds at queue->reports[queue->size] and beyond once
queue->size reports have been submitted.

[Severity: Medium]
Can filter->report_type be uninitialized here when a new
DAMON_FILTER_TYPE_REPORT_MADE filter is added via damon_commit_ctx()?

damon_new_filter() allocates struct damon_filter with kmalloc_obj()
without zeroing the union, and when damon_commit_filters() creates a new
filter it only copies union members for DAMON_FILTER_TYPE_MEMCG and
DAMON_FILTER_TYPE_HUGEPAGE_SIZE:

mm/damon/core.c:damon_commit_filters() {
    ...
		new_filter =3D damon_new_filter(src_filter->type,
				src_filter->matching, src_filter->allow);
		if (!new_filter)
			return -ENOMEM;
		switch (src_filter->type) {
		case DAMON_FILTER_TYPE_MEMCG:
			new_filter->memcg_id =3D src_filter->memcg_id;
			break;
		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
			if (src_filter->range_max < src_filter->range_min) {
				damon_destroy_filter(new_filter);
				return -EINVAL;
			}
			new_filter->range_min =3D src_filter->range_min;
			new_filter->range_max =3D src_filter->range_max;
			break;
		default:
			break;
		}
    ...
}

As a result, new_filter->report_type retains uninitialized slab bytes
when damon_pa_filter_match() passes it to damon_report_exist().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D14
