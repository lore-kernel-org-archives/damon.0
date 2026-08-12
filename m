Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445BA409121
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531647; cv=none; b=UgV+9LV2okX8LwWiH6wcqfFgnOpZxbhY5fS0bkbi934n+4GPrxHulu7WwvfPsK4RwMAnfc1c8KwZbftd28bexNCQo3HavC8yEO3nTBtl9tIPccApkf/xb37fE5RhYXT0MEVHiuTKQVzPgXm4R74YLLk1Frpl9NNcn1HSQlpMoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531647; c=relaxed/simple;
	bh=tJNahP9m/swL76BxqYT3EN4xPQRlbBun+UCH2Eyc0Yg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mmpYi+DRCb+FRC0uDfeeFquFCQB7DOjOi+30oFSmeQ9p6rkWpdw8tbTdr8eZ8NJR6ATeeMsl6RMLh4yt4UYyGOWkDKcefsz+vuJYxqLcPQpM+84oGcqT4AIH0Mn3DMUoGsSc8HEKpZAeuCm4RTQwOrzJ/d3dTtFj0e9V5fE+GgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwQ+YCeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwQ+YCeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A567E1F000E9;
	Wed, 12 Aug 2026 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531645;
	bh=3JGTCki3J6uU9c3J9kq96tC0pOXpci0pYjNuwulgHrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwQ+YCePC8VmxoodYXYd019M3BVEi1js9wTgp+NhB6T0ONIzs+kR7vjehT5GAYBJQ
	 8C5f1U6p/DXKNHLrzTr4riCZSVwy/nsgthdytbhRgJF5rFEJNitcDdVPZvYV+ZcaHq
	 6sjYCJRKlNAwkEGDfkU0qA8sjAeRN7O0DAB7AsDVTp6bg0mZl1lzm3vINmqivWDS8w
	 Xi84oqoM+cSOKs2iyIR6Op48PMS/f9eddA0tjnTHjrpATucW6UIFtgbPJF9rABJ9vR
	 WPCm3UTGH4bpId5COCZb9gncsZFjK+DhvMS0dzlMdrNp9jE+v6GM8GGD8+ggBInMjY
	 upx81oKItY90A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] docs/mm/damon/design: difference between
 watermarks and nr_snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812104002.15225-3-aethernet65535@gmail.com>
References: <20260812104002.15225-1-aethernet65535@gmail.com>
 <20260812104002.15225-3-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:47:25 +0000
Message-Id: <20260812104725.A567E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `nr_snapshots` i=
s incorrectly incremented per target instead of per snapshot, and skips inc=
rementing entirely if the scheme bypasses the final region of a target.
--

--- Patch [2]: [PATCH v2 2/3] docs/mm/damon/design: difference between wate=
rmarks and nr_snapshots ---
commit af16039fca7bbda3290262311f6015d553f6c65f
Author: Liew Rui Yan <aethernet65535@gmail.com>

docs/mm/damon/design: difference between watermarks and nr_snapshots

Explain the difference between nr_snapshots reaches max_nr_snapshots and
watermarks.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index 1739aeec6eb95..e7977f005ac06 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -872,7 +872,8 @@ the action to the region will fail.
> =20
>  Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set=
 as
>  non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots`=
`, the
> -scheme is deactivated.
> +scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
> +``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.

[Severity: High]
This isn't a bug introduced by this patch, but while documenting the
nr_snapshots behavior, I noticed an issue in how nr_snapshots is incremented
in the core code.

Looking at damon_do_apply_schemes() in mm/damon/core.c, nr_snapshots is
incremented per target instead of per snapshot:

		if (damos_quota_is_full(quota, c->min_region_sz))
			continue;

		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
			continue;
...
		if (damon_is_last_region(r, t))
			s->stat.nr_snapshots++;

Could this cause the scheme to incorrectly increment multiple times per
snapshot if there are multiple monitoring targets?

Also, if damos_quota_is_full() or damos_skip_charged_region() triggers a
continue on the target's last region, does this bypass the increment entire=
ly?

If a scheme frequently exhausts its quota, it seems nr_snapshots might never
increment, causing the scheme to run forever without reaching
max_nr_snapshots.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104002.1522=
5-1-aethernet65535@gmail.com?part=3D2
