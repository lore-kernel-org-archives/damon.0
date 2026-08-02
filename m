Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAF3B7B70
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688546; cv=none; b=TMbPdmIbjR9DY+q9sVzHMqecpg4Si9g1PoyuRYv5q7uQ+hUFN9ghr9u9CPTjiNbMUyBA1KqZ0g+UU60qjBmskjcdzPBvTouF6f9suzYO7g7Vs6sA2jPQL1pysJCvaeygvmZWiTXxFZNvKWNlF9GbGoUBRkwc5y1MeV7DN9lJEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688546; c=relaxed/simple;
	bh=9UzzKPlRQmXHcyqaA6gs5SsrmQ/Pc3JJyQ9b/hS1g5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SiW2NasWgDHob3aBy4VrPh5iM3ntDhULeCaHeSS/7icsn4fJKGLpe6jUBEK4J3i0IMmQqFyFs5yDbvzS0/BXRVYMQ+JGD/Z3ziwyhzPhm9WLjVv1qcbZuBvJmbkm8FYs3JeoOjCLHozDJ7YVf7fEXo1o07jRJKG2q6PqE2hh9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1s7TVLO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1s7TVLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CC11F000E9;
	Sun,  2 Aug 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688545;
	bh=jmMEdMsQxKwGMvU4GAmiXBZV73zgpjW2S+ALPlsILb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1s7TVLO5YeE2LkDp0OawqzcjkzyCxQwnzLX0UiPBOMGTauyZ9Vs3ami9/R0+7YTJ
	 hvuiVWQMikRDsZPYXBdNBWHpieddWNXpBIwXJ/pvvDB8wF9IOf8bgmt2183Zubo7oV
	 byxaahS2IgaTGs0fhgylX0H7SUjb3XhB9xuXTdZ8SvZWpSaKVtA5h0NblotUfoKtB0
	 tUBQxi+/l4DmgE2EHaX5UTuslJF7vnrselZjxEOGT0q0h+0sE4dKJyrgAXWMoTzjOv
	 /JJhofcT/qRdjuabipy0KNNjc6MZ87L7gnfuEFGfddu07Lg3LeqgV8nEWskI6Jr7c+
	 y/0WuHIn9vuhw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory state
 in damon_get_node_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162631.90304-8-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
 <20260802162631.90304-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:35:44 +0000
Message-Id: <20260802163545.31CC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Returning 0 for DAMOS_QUOTA_NODE_MEM_FREE_BP when freeram > totalr=
am incorrectly forces maximum scheme aggressiveness instead of reporting 10=
0% free memory.
- [Medium] The commit message contradicts the implementation, and the uncon=
ditional return of 10000 for zero totalram breaks metric semantics.

Pre-existing issues:
- [High] Unhandled integer underflow in MEM_USED_BP and MEMCG_FREE_BP calcu=
lations when counters drift.
- [High] The patch fixes a potential divide-by-zero in damos_get_node_mem_b=
p() but misses identical unvalidated divisions in related functions.
--

--- Patch [7]: [RFC PATCH v1.1 7/9] mm/damon/core: handle extreme memory st=
ate in damon_get_node_mem_bp() ---
commit 05d27d4d51952669ff23ec9285ccb83a273556ad
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()

In an extreme and unlikely situation, si_meminfo_node() might let the
caller show zero total ram. That could cause a divide by zero in
damon_get_node_mem_bp(). Fix it by setting the totalram one byte in the
case.

Link: https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org

> In an extreme and unlikely situation, si_meminfo_node() might let the
> caller show zero total ram.  That could cause a divide by zero in
> damon_get_node_mem_bp().  Fix it by setting the totalram one byte in the
> case.

[Severity: Medium]
The commit message states "Fix it by setting the totalram one byte in the
case."

However, the implementation actually bypasses the metric type check and ret=
urns
10000.=20

Does this unconditional return contradict the intent documented in the comm=
it
message?

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3bdbf4fbf7147..e3f3ee75a3d33 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2816,10 +2816,16 @@ static __kernel_ulong_t damos_get_node_mem_bp(
>  	}
> =20
>  	si_meminfo_node(&i, goal->nid);
> -	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP)
> +	if (!i.totalram)
> +		return 10000;

[Severity: Medium]
If the metric is DAMOS_QUOTA_NODE_MEM_FREE_BP, shouldn't it report 0% free
rather than 100% free if the memory is absent (which is what totalram=3D1,
freeram=3D0 would yield)?

Does returning 10000 here break the semantic constraint that used + free =
=3D 100%?

> +	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP) {
>  		numerator =3D i.totalram - i.freeram;

[Severity: High]
This is a pre-existing issue, but if counter drift results in
freeram > totalram, does this subtraction silently underflow, producing a
massive unsigned value?

If this is passed to mult_frac(), could it generate a huge metric value,
leading the auto-tuner to mistakenly act as if the memory is massively
overused?

An identical unhandled underflow also appears to exist in
damos_get_node_memcg_used_bp() when evaluating DAMOS_QUOTA_NODE_MEMCG_FREE_=
BP
if used_pages exceeds totalram:

mm/damon/core.c:damos_get_node_memcg_used_bp() {
    ...
    numerator =3D i.totalram - used_pages;
    ...
}

> -	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> +	} else {
> +		/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> +		if (i.totalram < i.freeram)
> +			return 0;

[Severity: High]
When counter drift causes freeram > totalram, the node effectively has
~100% free memory.=20

By returning 0 (0% free memory) in this scenario, doesn't the DAMON quota
auto-tuning feedback loop interpret this as severely under-achieving the fr=
ee
memory goal, causing it to wastefully and drastically increase the reclamat=
ion
budget (e.g., pageout/demotion) on a node that is already completely free?

Should this return 10000 (100% free) instead?

>  		numerator =3D i.freeram;
> +	}
>  	return mult_frac(numerator, 10000, i.totalram);
>  }

[Severity: High]
This is a pre-existing issue, but while this patch addresses a potential
divide-by-zero when si_meminfo_node() reports totalram =3D=3D 0, does the s=
ame
unvalidated division exist in related functions?

For example, damos_get_node_memcg_used_bp() divides by i.totalram without a
zero-check:

mm/damon/core.c:damos_get_node_memcg_used_bp() {
    ...
    si_meminfo_node(&i, goal->nid);
    ...
    return mult_frac(numerator, 10000, i.totalram);
}

Similarly, damos_get_in_active_mem_bp() divides by total (active + inactive)
via mult_frac() without checking if total is zero:

mm/damon/core.c:damos_get_in_active_mem_bp() {
    ...
    if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_USED_BP)
        return mult_frac(active, 10000, total);
    return mult_frac(inactive, 10000, total);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162631.9030=
4-1-sj@kernel.org?part=3D7
