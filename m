Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D204964F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898544; cv=none; b=acPDBFFA6BM8VMACpFYUhsv8e5q60UHSibQcqmmWTRW6xMeTvaCne+FJaFCNjDrBvNb+ElgNVeBbi+2ZKK9PXVAHHHQfAcn1KA9+o3bdqGPIKZEp82Ti3Kvo4+gQLOtgDjpkrHIFYAVvjllruo9Flb9NgzuvXbDxZCqQBldJsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898544; c=relaxed/simple;
	bh=FfBiiExV/n0RB0n8evT083lbZCxV9DTqYF20BR9CX3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=km4w92Hv/JUATYXuhuIXTn2obNrLg7ONUH5L1wGKho6ahj3AChv3a/2eFXwpVIu96mPiNcHSUjFcyZfLNH0DhHoDWzwJHklqYxzVstixrQ+XUustQ0lSwUJ3KzEUngJzxkvDkraZl9OXytt6E7kr8dTckKL2HfPGTIVeoJdalzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiFkyFIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiFkyFIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86311F000E9;
	Fri, 19 Jun 2026 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898542;
	bh=jfOuPRITNof+LxQ0qkA33ZIWtXaFkWzEi10A8I8Qbws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eiFkyFIzDolpUpA8Q15iKGOn/usJPCV6JhWj6mB2LsdVwdhQJ6cjW4XEzNWytEVuJ
	 UeFrLaTKpLxIBoxnTwjJpVwAjlWRv9RYQrfKZoE4M/V/MjrHu198BnJDc7LqO19Lcx
	 HTIaoik5hy3dNDZMvuCqzWFMUAT//d43HxUHEqo1ZOM65QKcnjqsuLZ4Ss/Fk8KLz2
	 svHq3dMX1KD67AKt2IDudNNrs9KQkIMyfU3txf23+ilHr4sYdmh4PmI7TJUcHS3BGI
	 0QwmvR04csVJx2bPj2wezL2evJfREhbmWY2UFchBFYrmdNM7l6lrgtJEZk5vk8RUiO
	 U7neYboNw8GUA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/13] mm/damon: remove damon_region->nr_accesses_bp
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-14-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:49:02 +0000
Message-Id: <20260619194902.A86311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale comment in kdamond_fn() references the removed nr_accesses_bp=
 field.
--

commit 7fe8c1a02c74da4804760b45a04f15189947a500
Author: SeongJae Park <sj@kernel.org>

mm/damon: remove damon_region->nr_accesses_bp

This commit removes the unused nr_accesses_bp field from struct damon_regio=
n,
as well as its associated kernel-doc comments.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 4f73d27979f0b..a18d905f28e14 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -77,7 +68,6 @@ struct damon_region {
>  	struct damon_addr_range ar;
>  	unsigned long sampling_addr;
>  	unsigned int nr_accesses;
> -	unsigned int nr_accesses_bp;

[Severity: Low]
Is this a minor regression that leaves a stale comment in kdamond_fn()?

Looking at mm/damon/core.c, kdamond_fn() still explicitly references the
nr_accesses_bp field:

mm/damon/core.c:kdamond_fn() {
    ...
				 * information reset for all regions.  Then,
				 * following kdamond_reset_aggregated() call
				 * will make the region information invalid,
				 * particularly for ->nr_accesses_bp.
    ...
}

Should this comment in mm/damon/core.c be updated or removed to reflect the
field's deletion?

>  	unsigned char probe_hits[DAMON_MAX_PROBES];
>  	struct list_head list;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D13
