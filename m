Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775284;
	b=KGCac+i3h/4mbDK/xAaMhoXrBt7tCWjeBgEFt/hgVo+pjy9rvulC/ge7oJDFoulkQTDY
	 kUXSLmC8eGrqtAFtQghVHkoic3PD74gpzUpI2dBGfdUo0wVqMVLKonFi+/VXgw2+LMhIP
	 hPXg/eXvfrD51zJNBjssYnrZRJHfNGv4PSkRFB274jfYJlt43lTHPPk1ojCw7tp1cO6Id
	 kyJrgBQFHhcySM3/r+WGhiQjl70qL75b6hYDLKCr32eLniM9Q4Yg0c4oxptOqQk1fw6FS
	 zz4XQFy60QKQBveWt/A8XYKRvZYyRXr9REAS/hyK2Dwk6eHhnkqdBsC43RuAi28IqVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=31PK8ejQi8OkMxNdvjJcNS0+QCT6SvYzZcKuJxbk+N0=;
	b=uy+kSRt7hWybJe6m2hAEKTGnP5f9USYfr8/G3wJzXYLtpJKrC1kPqyJ53Nx92z7AZGX+
	 TtbOGa2te9CInafVObdrqD7yvtPdlGAhM1/Sx9UvnPLx28g47/KMeRmjoj+qLTkdBm3Gh
	 KqWBrJnYnScbj4S4Wq23gZbGHSDW84vH3qpIyK3b6K1bnhQtOdJFXgWVoMOdBR4j0QDdy
	 b5+k0TjLXVDeVSmgBM7692KhBG6GcxtyQ4zrgQHgCnqv3dSSuVP8CviOaBEIlQI/PpWdw
	 SG/IY4GTbEKgz8ZEDStTVo8kkACUw9XJMnUebt6t4Wi6wWJSs78z9UNbwYHymNFVjLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC8ZDgAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EF606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC8ZDgAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A0E1F000C4;
	Sun, 15 Nov 2026 20:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775284;
	bh=31PK8ejQi8OkMxNdvjJcNS0+QCT6SvYzZcKuJxbk+N0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QC8ZDgAOAz/goD9F04hw0cJMzG4vhfIXnkMQU3fY2LwoClwGP8zFbjSxQx0sSJm8Y
	 8gmKsPCp4eI0Nw0F51WVqnIKG5DTr4rE+O7AWpQE2gcvcNeqsuwtzsX0SKXeB9zxAm
	 IohSyxPw1H920YflUmB3oPQH7fMD0/eMG6YOIyfwISSaN8tA+U0tUhiUGW+nEi3KiM
	 gTo0hsQD55MS3Fy0VlvtDDOLZsPTzQlSEpLybbgaAAEIFwH+j9Bp129rvm4pKIXHPs
	 2uOJRtgCbqsdii+m5vJlt5dVZR1f0LzaWB/RvfJgiazK0knymfJVzTykPOQA+TIZDh
	 d95R7NSBYb7PA==
Message-ID: <sashiko-outbox-215849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/27] mm/damon/core: implement data attribute
 report queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-3-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:41:23 +0000
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
- [Medium] mm/damon: damon_init() leaks damon_region_cache on queue
  alloc failure
- [Low] mm/damon: missing static qualifier on damon_report_queue in
  core.c
- [Low] mm/damon: struct damon_report_queue comment documents head not
  nr_reports
--

commit 10a61bc9bab6e48534e4a8552380aecaccbee97a
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement data attribute report queue

This commit adds an internal damon_report_queue structure, allocates its
buffer for up to 1,000 reports in damon_init(), and checks that buffer in
damon_initialized().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0a056949604f9..3f87a7eec442e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2334,6 +2334,25 @@ int damos_walk(struct damon_ctx *ctx, struct damos=
_walk_control *control)
>  	return 0;
>  }
> =20
> +/*
> + * struct damon_report_queue - &struct damon_report queue.
> + *
> + * @lock:	Represent if this queue is being used by someone.
> + * @head:	Head of the queue.
> + * @tail:	Tail of the queue.
> + * @size:	Size of the queue.
> + * @reports:	Array of &struct damon_report.
> + */
> +struct damon_report_queue {
> +	atomic_t lock;
> +	unsigned int tail;
> +	unsigned int size;
> +	unsigned int nr_reports;
> +	struct damon_report *reports;
> +};

[Severity: Low]
The comment above struct damon_report_queue documents @head, whereas the
struct defines nr_reports instead.

> +
> +struct damon_report_queue damon_report_queue;

[Severity: Low]
Should damon_report_queue be marked static?  struct damon_report_queue is
private to mm/damon/core.c, so leaving damon_report_queue non-static
exports it into the global namespace and triggers sparse and W=3D1 missing
variable declaration warnings.

> +
>  /*
>   * Reset the aggregated monitoring results ('nr_accesses' of each region=
).
>   */
> @@ -4308,7 +4327,7 @@ void damon_update_region_access_rate(struct damon_r=
egion *r, bool accessed)
>   */
>  bool damon_initialized(void)
>  {
> -	return damon_region_cache !=3D NULL;
> +	return damon_region_cache && damon_report_queue.reports;
>  }
> =20
>  static int __init damon_init(void)
> @@ -4319,6 +4338,14 @@ static int __init damon_init(void)
>  		return -ENOMEM;
>  	}
> =20
> +	damon_report_queue.size =3D 1000;
> +	damon_report_queue.reports =3D kmalloc_objs(*damon_report_queue.reports,
> +			1000, GFP_KERNEL);
> +	if (!damon_report_queue.reports) {
> +		pr_err("report queue alloc fail\n");
> +		return -ENOMEM;
> +	}

[Severity: Medium]
Does this error path leak damon_region_cache when kmalloc_objs() fails?
Destroying damon_region_cache and resetting it (along with
damon_report_queue.size) before returning -ENOMEM would avoid leaking the
slab cache and leaving partially initialized state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D2
