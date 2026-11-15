Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775361;
	b=nIFi/M209KTgf0Z2J7p66q5JFSeHZQublqpN3UK5h4ZbG76hyNKbFtu6p01E2dRnZUj5
	 992mfN5uzsrrbNheXHzqI1M1G/pbaS44raNcAVYoKZ0XH9VQWdqtx7kLfsmciHoC4VE0Q
	 SAmbakt8pP4fwxEgP/I/kUs3nEWrGn/QsE2TlbO6PiKCg7KkHL1sisymmGxQ87oMVn6+n
	 1u0VJwtAHvdScAbjlL1Wto1K9x82BCA+s6eUj6UfbzXkukKQak6hd+gMcWqK7TV3uK249
	 XgU59CJ43VyXCr+9sM+x3hC/mszrkpatfkDQ+f/Oc9NnyubAtIrtCDvn+1AMeicXjnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J+fnsq6nNb+xpVBHQjdCD20xN1KOTbGtm9ZI5ilhmXQ=;
	b=boSJ67Rk3rS2fWf11SCnXh3fdannMOUSMqfmunv25nbGsBvHaWuTsTKCa1VqwHmH0jde
	 JIaYjCj21DIjJ6VGjT0UNEthBnre1JMAO+tyJ2ndU3bPVQGbwcCkhm36wTM1QCB1Fmws7
	 uy/+SF8+AWHYZSFOq5P6NM95yEUb4KiHG02eSvbPG6c4xDka5MKO/2J0BC2AV1PoBgwoO
	 LUrcR4Nl2DxSX7jeAkVXkU6W8PN0qH8O78SLKd7EQykEoH7ARQgMq+qSKzSRJmwSgXxwN
	 HsdejrT2EpVebQ1tgQqh6TLEEMZMxApG7iGljZhLg6SrZ2FV1oNRPt6/yM2nZKM60ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwQHu0Ih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A338606A33D
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwQHu0Ih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9191F000C4;
	Sun, 15 Nov 2026 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775361;
	bh=J+fnsq6nNb+xpVBHQjdCD20xN1KOTbGtm9ZI5ilhmXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwQHu0Ihzk7asjxuCCKyAoub+Dl6eWnzX31BDUHVHZ/uc+OYXFXix3OqRDrJHVw4c
	 BVdZ5ugXhFLRXY7BXa1mJHZbdadQZZYw6BJq/uyXkk7n78edKN5+RvU+01o7PBTZfk
	 eJNcA4+dFSKSW7DyemrVUplsg+dlRIwbI3s3frM9XunF9DjPZvwT6b4BMvgbfHNghq
	 EBJNva0C1AefbYTjROMQDhnTX7bX3bWwRrCKODeiyROj33Ys6x7Fokp6tfwVVkyXlL
	 o2DIfBuuywkTxmfx4BbRUZBT+6zrTJlrLvcFxD0kw9TyHRS1+PgfyEd0YA425o56Mr
	 Xs/YEEhJovOqw==
Message-ID: <sashiko-outbox-215851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/27] mm/damon/core: introduce
 damon_submit_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-4-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:42:40 +0000
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
- [High] mm/damon/core: out-of-bounds write in damon_submit_report() on
  queue wrap
- [Low] mm/damon/core: missing Return section in damon_submit_report()
  kernel-doc
--

commit bcb278386fb51304d0c224892db9744bf9e27c8f
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_submit_report()

This commit adds damon_submit_report() to enqueue a data attribute report
into the DAMON internal report queue using CAS-based try-locking.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3f87a7eec442e..06b85d00e38d9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2353,6 +2353,36 @@ struct damon_report_queue {
> =20
>  struct damon_report_queue damon_report_queue;
> =20
> +/**
> + * damon_submit_report() - Enqueue a given report to DAMON internal buff=
er.
> + * @report:	The report to enqueue.
> + *
> + * This function can be called from any context including the NMI contex=
t.
> + */
> +int damon_submit_report(struct damon_report *report)

[Severity: Low]
This isn't a bug, but the kernel-doc comment for damon_submit_report() is
missing a Return: section describing the 0 and -EBUSY return values, which
triggers a kernel-doc warning under W=3D2 builds.

> +{
> +	struct damon_report_queue *queue;
> +	int lock_old_val;
> +	unsigned int tail;
> +
> +	queue =3D &damon_report_queue;
> +	report->jiffies =3D jiffies;
> +	lock_old_val =3D atomic_cmpxchg(&queue->lock, 0, 1);
> +	if (lock_old_val)
> +		return -EBUSY;
> +
> +	tail =3D queue->tail;
> +	if (tail =3D=3D queue->size)
> +		tail =3D 0;
> +	queue->reports[tail] =3D *report;
> +	queue->tail++;

[Severity: High]
Does this write out of bounds of queue->reports[] after the queue wraps?

When queue->tail reaches queue->size, only the local variable tail is
reset to 0 while queue->tail++ increments queue->tail to queue->size + 1.
Every subsequent submission then bypasses the tail =3D=3D queue->size check
and writes past the end of the queue->reports heap array, corrupting
adjacent slab memory.  Updating queue->tail =3D tail + 1 would wrap the
index properly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D3
