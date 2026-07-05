Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48AB672
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267612; cv=none; b=r6ZCPBX+1n7Z3sPFOuKhqmzM5jIO6NKu3AHx2Q+Xq54g0Y0JbAwhSJ3XXl2oxWfRxE9t3fzfIDpYhcExuxIzB0Mbuv54BVRP1nOHK7lMfyOAUsVobJwtX31wgeMZDJWg/0RICnvHDjXaaKs2EVl9A4domUdFLQ/ZxqIh7gS6/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267612; c=relaxed/simple;
	bh=/SKsDENuUzU9wzQw/Xz0M3f/Me9kWmBSdp+cVxpCcU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3gsNV6SZkQz/Kc0E2o2oNd97sbXO07J69hk6kAmJhuL4PNb9LDX3hVn5A6eiNcEi/D7LFae6LsFTXf/z3gamdgjndItFKXYAUqZatnSS2EpjVXTaiBH5JbrsP9HP9kSH+3vZDOEuORD2uAV3lI4N/8GA4LhZUKa5M5oGevHopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3CLYari; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3CLYari"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626791F000E9;
	Sun,  5 Jul 2026 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267611;
	bh=BnQ6PWAUt7rYg4xtV5DcJv1pbGdqFJLvqOjWsvtFjrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3CLYarivnEVmdmvueFDk1qxIn7+1MfNcKHgKaAGsv5iKzEi3lH6nakmSz/VfJXJl
	 gGHG8z+Tvwna97ZaB4KzhJpeEGxnL+hk+mKXL6GpzW8G+iKEB8FldaWvLCqTyo9sY7
	 auuIxY/dCx9/7vb4g//Y61nDS+rn9mbd5TEXfjTgok5/FF+1md1rsj2NG0aMAzoCOL
	 nED59VWussBmBXWmA9seX3VwLy/WOoGH66/RtNr8vW8hY2618KbFNktdfg5tiQMLCl
	 gk458n0Bw+RCZ2kZliCqMN1kgE3BC5YgoTFK/vzn++b8iGtHwcGNQbkrtKV2y8ehPW
	 YwI/m4CzlKr3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] mm/damon/core: remove start, end check in
 damon_set_region_system_rams()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705155600.96555-8-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
 <20260705155600.96555-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 16:06:50 +0000
Message-Id: <20260705160651.626791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the explicit `*start > *end` check causes invalid, inve=
rted memory ranges to be inconsistently accepted due to post-alignment boun=
ds checking in `damon_set_regions()`.
--

commit f561b43e79bb90540b8053e4d95593cfb96f6d1d
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove start, end check in damon_set_region_system_rams()

This commit removes the explicit start and end validation in
damon_set_region_system_rams_default(), relying instead on the bounds check
inside damon_set_regions() to catch invalid ranges.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3846,9 +3846,6 @@ int damon_set_region_system_rams_default(struct dam=
on_target *t,
>  {
>  	struct damon_addr_range addr_range;
> =20
> -	if (*start > *end)
> -		return -EINVAL;
> -

[Severity: Medium]
Does removing this check allow inverted ranges to bypass validation?

Looking at damon_set_regions() in mm/damon/core.c, the fallback check
evaluates the values post-alignment:

mm/damon/core.c:damon_set_regions() {
	for (i =3D 0; i < nr_ranges; i++) {
		unsigned long start, end;

		start =3D ALIGN_DOWN(ranges[i].start, min_region_sz);
		end =3D ALIGN(ranges[i].end, min_region_sz);
		if (start >=3D end)
			return -EINVAL;
	...
}

If an administrator configures an unaligned, inverted memory range
(for example, start=3D8191, end=3D4097), the post-alignment check might sti=
ll
evaluate to ALIGN_DOWN(start) < ALIGN(end) and accept the invalid inputs.

>  	if (!*start && !*end &&
>  		!damon_find_system_rams_range(start, end, addr_unit))
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705155600.9655=
5-1-sj@kernel.org?part=3D7
