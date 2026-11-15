Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775273;
	b=rFe89BX90SNK7do59OCL1088mocFhSdxMpWA6iWZ0YZfn1l3ETn/0J/625gunJ0+RS2D
	 SLrYyy3NwcYDM0D4UmTsPuF9YRTwVaWE1rlkyF5/9ZR5q02O3FOIeBUVgjXOejahTNreb
	 k0Q3VzNC0nAxoYMg3PlWVjMhqp5e5q+6nlqwYA4BicBVS6RWWqIMr32raj/0BAGNX9IDB
	 RdJUcAxhY1LMhazwVksg8ZzDaquK/qKOpCJKCLgc06SLUQPd3DXD+zUXraHeRd/3f2hYR
	 0oAutuk3Mf7AdzwaeWM/53Dq4ibP/SHYGKgvR2LUFIGzPcwSJkUMgkd++yQf84lKmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PSxkxgjUByaP/FYRn8+uu178H4zEv9vDMaVbpvfzlA0=;
	b=HmRVoIEaBLGMXPyNM5JP9DCWRfJGP61ri/i5Xef6dxhP5IyKY3GoiJQ3+J2v/1KRtiVv
	 07v0CeR9GfN+Vi8Nm23Jh00gMW74XByaw1/Gn4yq4XDAJeOfeVvKKiOq7Jwr3zx4ZV34S
	 ngmVnusFfl9TL1Ycg5sNiDy/r2Wscrwzij74akGneSxHpc26EFadT6i/wWu3rsVX+gmd0
	 D2urXOvbtVG3SVTNffQjdw5TxjhLjzxORc/Kqgcwu5ucYu5cqNuZEzq7C4emfSrPWw3TB
	 e+/WUwK6jAf1v3vzD2ooJBAryLXPjgaYPUw3yhx9MrdGATK+4iqtBRPqWHMW9MLBK9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wah75oXT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD0606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wah75oXT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6ED1F000C4;
	Sun, 15 Nov 2026 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775273;
	bh=PSxkxgjUByaP/FYRn8+uu178H4zEv9vDMaVbpvfzlA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wah75oXTv2g4ttvtDi6nwIIBo8lsoWaTHCTLZLfGxhNDoypBNWWYtaVdjs8CtVFnn
	 vFbClSO25JEdibuy+6h6C9kbRRDHAbHR2taRqwmbyPuHe24Wdnepx5JVLqwqtPTJ+b
	 kCyfdl6/1mRnRzVjsOwwV9SMMdCHyLzFatUSGIdogPj92ZQ+F3fK4K4BeCSdEkmQJg
	 WdlhqRzml3rLrUVeaFp3TYEhrlTuMkSGWUCPIhwMFcARw2vgGW1Lela+YTq60DuMIW
	 Hb6kIm+cOjT+WABlKfDWu6JfnoFcORM2oWiL3fxB3SHqlwEEk3jmsr8SRhfws9bkRm
	 irecO7xFTbLsA==
Message-ID: <sashiko-outbox-215848@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 16/27] mm/damon/sysfs: support REPORT_MADE type
 probe filter setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-17-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:41:12 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] mm/damon: out-of-bounds and uninitialized access in
  damon_report_exist()
- [Medium] mm/damon: uninitialized report_type in damon_commit_filters()
--

commit 6058e18a855d5b73c171dc4b94eb6031f06fdc63
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: support REPORT_MADE type probe filter setup

This commit adds "report_made" to the DAMON sysfs probe filter type list
and copies the filter's report_type when setting up probe filters.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index ca971cf1dcf6d..1c171af4590a8 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1016,6 +1016,10 @@ damon_sysfs_filter_type_names[] =3D {
>  		.type =3D DAMON_FILTER_TYPE_ACTIVE,
>  		.name =3D "active",
>  	},
> +	{
> +		.type =3D DAMON_FILTER_TYPE_REPORT_MADE,
> +		.name =3D "report_made",
> +	},
>  };
> =20
>  static ssize_t type_show(struct kobject *kobj,

[Severity: High]
Can enabling DAMON_FILTER_TYPE_REPORT_MADE filters cause uninitialized and
out-of-bounds accesses on queue->reports[]?

In damon_submit_report(), each report is stored at queue->reports[tail] and
then queue->tail is incremented, so queue->tail points to the next slot to
write rather than the most recent entry:

mm/damon/core.c:damon_submit_report() {
    ...
	tail =3D queue->tail;
	if (tail =3D=3D queue->size)
		tail =3D 0;
	queue->reports[tail] =3D *report;
	queue->tail++;
    ...
}

When damon_pa_filter_match() calls damon_report_exist() for a report_made
filter, the loop reads queue->reports[idx] starting at idx =3D queue->tail
before decrementing idx:

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

While queue->nr_reports < queue->size, the first iteration reads the
unwritten slot at queue->reports[queue->tail] and the loop stops before
checking queue->reports[0].  Once queue->tail reaches queue->size,
damon_report_exist() reads out of bounds at queue->reports[queue->size],
and the next damon_submit_report() wraps only the local tail variable
before incrementing queue->tail past queue->size, causing subsequent
submissions and lookups to write and read out of bounds on the heap.

> @@ -2336,6 +2340,8 @@ static int damon_sysfs_set_filters(struct damon_pro=
be *probe,
>  		} else if (filter->type =3D=3D DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
>  			filter->range_min =3D sys_filter->range_min;
>  			filter->range_max =3D sys_filter->range_max;
> +		} else if (filter->type =3D=3D DAMON_FILTER_TYPE_REPORT_MADE) {
> +			filter->report_type =3D sys_filter->report_type;
>  		}
>  		damon_add_filter(probe, filter);
>  	}

[Severity: Medium]
Does committing a new DAMON_FILTER_TYPE_REPORT_MADE filter to a running
context leave new_filter->report_type uninitialized?

When damon_sysfs_commit_input() commits the context built here via
damon_commit_ctx() -> __damon_commit_ctx() -> damon_commit_probes() ->
damon_commit_filters(), newly added filters are allocated with
damon_new_filter(), which does not initialize the union in struct
damon_filter, and the switch in damon_commit_filters() does not handle
DAMON_FILTER_TYPE_REPORT_MADE:

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
			...
		default:
			break;
		}
    ...
}

As a result, damon_pa_filter_match() passes uninitialized slab memory in
new_filter->report_type to damon_report_exist().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D16
