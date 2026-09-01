Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EE26E165
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270070; cv=none; b=p7NCU5K3yviCCIz1u2HZf8SR+qVa0zEMu5xGeyI3SzflEJIzfhygpjEpINqpw/CW1V1T9AmjTXrnrb4jDAZ0z/S14nIB+yr8rzAyH0KRjJRax5Ovd+VCROoIbN43xuNztDw9cxNfKADy6Wcmm6waqi2kGuZm2Wnp/Fw6Gi3+0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270070; c=relaxed/simple;
	bh=6Ft6X3ZfG1reRUxY5iPufoyw5Jc/kOvCHNYd5oOeI94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXO1tccVIxpC+IfIc1G+or9YoFGl278DzohIblQydsrAW7zZJHH0XubmHMRxrB+rkvlrdH37/S8pHBdx6o3I9cvckvmc+5F0XbpCgjb775pGUQS5MzgvoiohwmKrg3mup0rrqjkYgMVt/7kNGjC8TCXcq5Stjo3MpckT3f7bnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWdiAWnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWdiAWnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9356D1F000E9;
	Tue,  1 Sep 2026 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270068;
	bh=2Ju3N7muwHZOEklfLH23tvPSSjD2bioiA1s0fplyAz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWdiAWnl415Lh6guInUQuhxdhgFGXH0QZDklnRS14JbRUSoNsZhYi4j+MHCVnEQJa
	 FA4A/ew7dGWse4KKwhl4kOiv9BfMLxPnRcisXzt4uIctVYjib5WLUsBjtQSET8joip
	 uOwp7Rw8kCqcEwxLUXxyv195AMOLqo13Ux97QUqG5Us6u9YX8NGYhj6kJhicWlXT+1
	 8+cJ5JuJC8IupnXIgR/Sec4AnyffPlB0IHW9HHVL1fL2Ovzdr3uo2QstrvhcfZTOuX
	 ujUDj7MlfLQmiWJP9yreUowBHu4Cza6JvMF66Dw+79ItMJbTLNfzBMiYoVqODt2OFN
	 fCMgefgwUNWQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] mm/damon/core: handle extreme memory state in
 get_node_memcg_used_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-8-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:41:08 +0000
Message-Id: <20260901134108.9356D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in basis point calculation on 32-bit systems for =
large memory sizes.
- [High] Incorrect saturation logic for negative global memory utilization =
triggers false maximum reclaim.
--

commit 23b94672ac5d1c09d669ade5732261e82d129c96
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()

This commit handles corner cases where total memory is zero or
lruvec_page_state returns more used memory than total memory. It returns
100% or 0% for used and free memory queries respectively in these scenarios.

Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ad3657d356fbc..3060edf5e4fa6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2854,6 +2854,12 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	mem_cgroup_put(memcg);
> =20
>  	si_meminfo_node(&i, goal->nid);
> +	if (!i.totalram || i.totalram < used_pages) {
> +		if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +			return 10000;
> +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +			return 0;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at similar logic in
damos_get_node_mem_bp():

    if (!i.totalram || i.totalram < i.freeram) {
        if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP)
            return 10000;
        else    /* DAMOS_QUOTA_NODE_MEM_FREE_BP */
            return 0;
    }

Can this regression trigger unwarranted memory reclaim pressure? If transie=
nt
per-CPU stats drift causes i.freeram to slightly exceed i.totalram, this
condition evaluates to true.

If free memory exceeds total memory, it implies used memory is less than 0.
Should the correct saturation be 0% used and 100% free instead? Returning
10000 (100%) for used memory tells DAMON that the empty node is completely
full, which might cause aggressive reclaim behavior on mostly empty nodes.

>  	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
>  		numerator =3D used_pages;
>  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this basis point calculation overflow
on 32-bit systems for large memory sizes?

A little further down in damos_get_node_memcg_used_bp() (and similarly in
damos_get_node_mem_bp()):

    return mult_frac(numerator, 10000, i.totalram);

The mult_frac macro evaluates its internal remainder multiplication using
the type of the numerator. On 32-bit systems, the numerator is a 32-bit
unsigned long.

If the numerator is greater than 429,496 (which corresponds to 1.75 GB of
RAM with 4K pages), the multiplication by 10000 wraps around ULONG_MAX. For
instance, 429,497 * 10000 modulo 2^32 evaluates to 2704, which then divided
by total RAM evaluates to near 0%.

Could this regression lead to incorrect memory quota enforcement for memcgs
or nodes exceeding this threshold?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D7
