Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775398;
	b=MP6lQrDIca8h5Rud5EQ81Y6tsrfQyfzwB0b1TM/S6ih7um11BTU9GQVYdz4sHRz8/+xn
	 gZzur6n16d1c1LVzyCGB0bqB5O4KhdDz/ZZovvFq0hn140EPGT2at8Q+tgEPIuI6VcouH
	 hLsBFBiT77YjJDy0nckr64vXZb7dnioM0NbbmORduVlvIdF5nBXoDrYhuB/dXVqPvmyRl
	 PGvgD+lIZOGuxNvf+8mYtzK43QKTAmpmWh8CMe1q+bSVhiqcBrspZnv/AAcxb49GE6pxY
	 qGRMjBdDIx5l5w3RKI6tDZK6JxwZcB+fLprhacMlSWvODullW27DbX3TJIjnGQavdZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775398;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fiik83/QhvtlEoJI3gCdvb+5phsJYJ4Jyx4TYMDaxuo=;
	b=H0ZFDZTl+lree6ZtFc4zTxuXHROjIzUz6U1cA91l4SLsbyTadaXNSlThHYqUkTRiQNSj
	 Fw2RKxhhs8ryI2nPU3grzhV4NVYDt4X4MfS2jkFojVBvXVAE8NjevLPfQ2q8AlEMAqRCf
	 by5nyZdNn1hAr/3Y0U91UqzQGT3VzHxMGAwpy3luMe3SUxjcBWKuyRw03dUEFEtfEsqlq
	 7MSjpIEfVfepyf5GckG/8DWrwtNPQMpdsAKAUqnyIHvJB+a2WVg3Ewkmsza1e7zO6S6+3
	 K1HLgm8En5wzYhAf8DbW4cSz3FQ+Zi06gOtYpT+8v5W8IWFhXDzh0PuMYYH/RweteWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMtqhsfg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304E606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMtqhsfg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6B61F000C4;
	Sun, 15 Nov 2026 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775398;
	bh=Fiik83/QhvtlEoJI3gCdvb+5phsJYJ4Jyx4TYMDaxuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMtqhsfg1BSaB6CmoHW9qLAMQOWX+U8vkukqgvaENhvjEbQcpNgFM/4HPc6empvF5
	 BQD8LqMWfJX5PudsPXZWt4csLVc+LIlZ6Vw3upjElpKKr/dP9eDqIW0kLY2e8hqAnS
	 iX/xBCVyIvAcaaH1YNVCODciUBHcQZNxVQmg5T7kzKf0g5hn+2Et2JDGwSU4L2tlZL
	 YH4eL5YW93zz16k5j+CYqf2+MhnqAOZgz0xtFCaNLSKfTADkrM4DmYRpbUL+sf/uAK
	 5BO2oTfuuFll9DxdFLY73PnIjdU3P1TSVgyP6gKnfzr2CPayFp9F1BizvvkkZx0mFD
	 PdZwvzqs3nrhA==
Message-ID: <sashiko-outbox-215852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 23/27] mm/damon/sysfs: implement submit command for
 report producer
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-24-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-24-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:43:17 +0000
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
- [High] mm/damon: OOB write in damon_submit_report() and read in
  damon_report_exist()
--

commit 2f4ed587e778c0d51407454ba3a19b21c1bc10c0
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: implement submit command for report producer

This commit adds a "submit" command to producer_state_store() so userspace
can submit manual reports via damon_submit_report().

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 5f9bb1955dfd5..0049aac6ab974 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -3107,13 +3107,26 @@ static ssize_t producer_state_store(struct kobjec=
t *kobj,
>  {
>  	struct damon_sysfs_producer *producer =3D container_of(kobj,
>  			struct damon_sysfs_producer, kobj);
> +	struct damon_report report;
> +	int err;
> =20
> -	if (sysfs_streq(buf, "on"))
> +	if (sysfs_streq(buf, "on")) {
>  		producer->enabled =3D true;
> -	else if (sysfs_streq(buf, "off"))
> +	} else if (sysfs_streq(buf, "off")) {
>  		producer->enabled =3D false;
> -	else
> +	} else if (sysfs_streq(buf, "submit")) {
> +		if (!producer->enabled)
> +			return -EINVAL;
> +		if (producer->report_type !=3D DAMON_REPORT_TYPE_USER_REPORT)
> +			return -EINVAL;
> +		report.type =3D DAMON_REPORT_TYPE_USER_REPORT;
> +		report.addr_range =3D producer->addr_range;
> +		err =3D damon_submit_report(&report);

[Severity: High]
Can repeated "submit" writes overflow damon_report_queue.reports[] in
damon_submit_report() and read out of bounds in damon_report_exist()?

mm/damon/core.c:damon_submit_report() {
	...
	tail =3D queue->tail;
	if (tail =3D=3D queue->size)
		tail =3D 0;
	queue->reports[tail] =3D *report;
	queue->tail++;
	...
}

When queue->tail reaches queue->size (1000), damon_submit_report() wraps
only the local variable tail to 0 and still increments queue->tail to
1001 instead of setting queue->tail =3D tail + 1.  On the next submission,
tail is 1001, the equality check against queue->size is false, and
queue->reports[tail] writes past the end of the 1000-element heap array.

In addition, damon_report_exist() starts its backward scan at
idx =3D queue->tail (the next free slot) and dereferences
queue->reports[idx] before decrementing idx:

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

Before the ring wraps, the first iteration reads uninitialized memory at
queue->reports[queue->tail] while the loop stops before reaching
queue->reports[0], missing a single submitted report entirely; once
1000 reports have been submitted (queue->tail =3D=3D queue->size), the first
iteration reads out of bounds at queue->reports[1000].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D23
