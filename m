Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F262F7F13
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270413; cv=none; b=RSZhZNcoJRwUo1EZYvK3G6qGvdRN9RVr6/1uWe+JGwSWTJSRzrhj1zMKPolNzzI2R3m2cpx533K7xqI6WLAHTCdSeuvwFwDAW1tNNuytQcVq8F2eWvjSq0eLpfGjS9U1BTy6vGavRKdUpZdyLRdapFLxaMBPy84vlEcCzIv+0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270413; c=relaxed/simple;
	bh=tILzg9gvGdiMxCqH5QxTRU4n/jGhkSmDIKXaMjlpeww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sX4ar2eu0lg3+ZgMjFNW8RiwJJghzHpbiEiiXCDTDNjTbIJfgBH1LyXsGAKEhf+NnI7O2Jtb/oKRqm64uzJYBty4IqXRenUgJSvheVHyVFdDBfrJnFPm+4jr7TaC16qflMZPsqFVr3VrXlA2iyR+ETbyGNKVYpPeOLRjnqIifLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YajQFIe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YajQFIe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2EB1F00A3D;
	Tue,  1 Sep 2026 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270411;
	bh=HmoIda8CcxATufmVBNGF3AstSQGPf6Yh+UKH+CsTHvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YajQFIe3ULHoEdKDq7jXS6flkQlvB/4gse/B4CEAxEvRsOUsBkYH+eCiK+/FgyLe+
	 W3NbiJQuwEkG5/KuouGFPZxj+ee5o+DWKVkOVJ6bO8E6Ye8uFU5s4cCAGwbzjxRorV
	 PIr63eBNnQ5ias5m+Ca+msIMnoo1joCnWGS/GFkiPKpn7HsCYvsrpX68yOPfU4zq0e
	 dEQOytsGZZZPoHtVGtFY97ws/wtfRlv9lRtOfTJs6kXS9DyIT4dDK8h4qS4DArr9q7
	 OPmp8T3iGL13Qs6e2ivI7Bvr6jcsPHqqq2X1pDCB8dt1IN2UYs9djTIe7n/H2fzmFl
	 PwlhDNQWWyZoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] mm/damon/core: handle extreme memory state in
 get_node_memcg_used_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-7-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:46:50 +0000
Message-Id: <20260901134651.5F2EB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in `mult_frac()` leads to wildly inaccurat=
e quota calculations on architectures with 32-bit unsigned longs.
--

commit f507259fcccb65ad40eabec53de3e020582667f6
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()

In extreme unlikely situations, total memory might be zero. In less
extreme but still very unlikely situations, lruvec_page_state() calls
might let the caller show used memory larger than total memory. In the
two cases, damos_get_node_memcg_used_bp() could cause division by zero,
or return underflowed value, respectively. Handle the cases by
respectively returning 100% and 0% for used and free memory queries in
the corner cases.

Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 32cde20de2792..6288bb3b09e65 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2853,6 +2853,12 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	mem_cgroup_put(memcg);
> =20
>  	si_meminfo_node(&i, goal->nid);
> +	if (!i.totalram || i.totalram < used_pages) {
> +		if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +			return 10000;
> +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +			return 0;
> +	}
>  	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
>  		numerator =3D used_pages;
>  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
>  		numerator =3D i.totalram - used_pages;
>  	return mult_frac(numerator, 10000, i.totalram);

[Severity: High]
This is a pre-existing issue, but does this calculation overflow on 32-bit
architectures?

The mult_frac(numerator, 10000, i.totalram) macro computes
numerator * 10000 / i.totalram when the numerator is smaller than the
totalram. Because numerator is an unsigned long, this multiplication is
performed using 32-bit arithmetic on 32-bit architectures.

If the numerator exceeds roughly 429,496 pages (about 1.7 gigabytes of
memory), multiplying it by 10,000 exceeds the 32-bit integer maximum of
roughly 4.29 billion. This wraparound yields a massively inaccurate fractio=
n.

This same overflow appears to also affect damos_get_node_mem_bp() and
damos_get_in_active_mem_bp().

Could numerator be cast to a 64-bit type before multiplication to prevent
this issue on larger memory systems with 32-bit kernels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D6
