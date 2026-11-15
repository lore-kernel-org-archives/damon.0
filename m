Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775040;
	b=AhqhuMH/gROCerYjOibjHx/xgIz3whKmv5bUdEOuqQ8KfCsdJt3CfqtqiREwH64Tm0Mp
	 lxi4D7FxaxRfDl8KHPXkItcLLTOANxf7san7wM3vuYuXmQA4NFkQuCaftJBewlgUvfbZB
	 SyTJXpWsmEcqEK+jPtdCD2uBOf0iGtsG9FtrGrXhBWIKtfkN53PdJwtMnx96gKaDrajDm
	 5ixqejNIUS0CRVecT39TISJXpSoPLWdFs8+FgsxxBJXUo7F4avaHGSKZzBhnzWT6yo/BZ
	 lM6OQh5tCVLZBgmGIE/Lyi2208BBanUTKpe7h18nOiI14WYRZXJtvtPU1VEog8/728w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Ikmg9N1RsKIQbI3uEth/NIY2dtjDJEnXxL3eJbP4m4=;
	b=TtLStk9u6wX2SeAiOyUOMxywZSYBFK0yshI8DcNHKkWt5BN46YM6Sa4CtXsCHz2EXteG
	 16HA7552/yJigK3mqUy3/XuYHZ4qNqmvtuPOHdxLeU+ixMB7DJZC9Zuv5WLGKrAXCYWf0
	 e+sRX0jQgR3Ja57LezC3rZJDx4jrACYwfmtHkywug90oEX6Xc5nbPi1MAwiPONqPF8ODW
	 yfsYxvzdGTEtoB9CuvjvEYR+kBVCSHvu8KGg7IaykFtSvFMg9ycQL5OLSrAR1yk2W4k96
	 ViGcJV4PZsIXIHGStkkikRncg2K6S6hHkYNIks4SfiJZZfY/PVzXB5L1XeOmiTjp40Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibTWXuln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104A606A887
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibTWXuln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3063F1F000C5;
	Sun, 15 Nov 2026 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775040;
	bh=+Ikmg9N1RsKIQbI3uEth/NIY2dtjDJEnXxL3eJbP4m4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ibTWXulnm28aRjewGrfq6X+okOL9yYiscjWw6mYnGt7knhi/F9w8MR032Xl5rDvaP
	 Inu4IFd4B5cpdoJXapkN3GLodvVDOnFSgYli8deK0COtDp8o4OQFICCna0oLS4howi
	 WJFHEbwOdYk6IIGiSj2PuhFV4ZlHRSR6TB8sSTQOlRpsnQ5C3Ow8mC0di726vKx7JQ
	 IsEzyO2ZiCNESLXtPfCJqwrGRC3lMqj3s++MkaH7TERa9Q1hoGY6UaiSdkEyXnPQh1
	 3ZlgDmPjFHmGT6A5lfI4IqnFgFDJICzjhco5R0GJ/FYS5h7Gsxy6v8zrK8Ky3puM9l
	 R0C+rcPwpLPAQ==
Message-ID: <sashiko-outbox-215847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/27] mm/damon/core: introduce damon_report_exist()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-14-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:37:19 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mm/damon/core: out-of-bounds and uninitialized read in
  damon_report_exist()
--

commit be7b07b7677627ddaaa72484649217b5172610a1
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_report_exist()

This commit adds damon_report_exist() to search damon_report_queue for a
report matching a given type, address range, and minimum age in jiffies.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c02c7fbc1d864..c60a6504d0a15 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2386,6 +2386,52 @@ int damon_submit_report(struct damon_report *repor=
t)
>  	return 0;
>  }
> =20
> +/**
> + * damon_report_exist() - Find if a report of a given condition exists.
> + *
> + * @report_type:	Type of the report.
> + * @addr_range:		Address range of the report.
> + * @jiffies_old:	Oldest jiffies to find the report for.
> + *
> + * Returns true if the report is found, false otherwise.
> + */
> +bool damon_report_exist(enum damon_report_type report_type,
> +		struct damon_addr_range *addr_range, unsigned long jiffies_old)
> +{
> +	struct damon_report_queue *queue;
> +	int lock_old_val;
> +	unsigned int idx, nr_read;
> +	struct damon_report *report;
> +	bool found =3D false;
> +
> +	queue =3D &damon_report_queue;
> +	lock_old_val =3D atomic_cmpxchg(&queue->lock, 0, 1);
> +
> +	if (lock_old_val)
> +		return false;
> +	idx =3D queue->tail;
> +	for (nr_read =3D 0; nr_read < queue->nr_reports; nr_read++) {
> +		report =3D &queue->reports[idx];
> +		if (idx)
> +			idx--;
> +		else
> +			idx =3D queue->size - 1;

[Severity: High]
Can indexing queue->reports[idx] before decrementing and wrapping idx read
uninitialized or out-of-bounds memory?

In damon_submit_report(), queue->tail is post-incremented after writing
queue->reports[tail]:

mm/damon/core.c:damon_submit_report() {
	...
	tail =3D queue->tail;
	if (tail =3D=3D queue->size)
		tail =3D 0;
	queue->reports[tail] =3D *report;
	queue->tail++;
	...
}

Because queue->tail points one slot past the newest report, the first
iteration of damon_report_exist() reads the unwritten slot at
queue->reports[queue->tail] (which is allocated with kmalloc_objs() in
damon_init() without zeroing) and never visits queue->reports[0].  Once
queue->size (1000) reports have been submitted, queue->tail reaches 1000
and the first iteration reads queue->reports[1000], one element past the
end of the array.  Also, when damon_submit_report() wraps local tail to 0,
queue->tail itself is not wrapped and increments past queue->size on
subsequent submissions.

Should idx be decremented (wrapping from 0 to queue->size - 1) before
indexing queue->reports[idx], with damon_submit_report() updating
queue->tail =3D tail + 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D13
