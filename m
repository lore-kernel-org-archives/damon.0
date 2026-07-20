Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4B3FC5A6
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549846; cv=none; b=kAdY6WrsR0Rb/Sh8AJf+Lekci779Nq7AY6XJqX2XyFXYKcpjk3/wtiwDObiNh05sesOeK/wmQz+oJHGEdBHzM4oG4EdXGRQq4HlgnMCcYGuW3HO2dhRl8BDlYuUXuVFp4KmA9kXr9bz/u/CdBhtaS3PuImXh/8DKoOqcqo6b4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549846; c=relaxed/simple;
	bh=CjQUY3SEi/ktpL3R1Cslb5sSTNYMZO5lRS3PPQXLMks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CAEcHgwJOvmjmvko4LewYYyU2CFNvuk+O2/hM9W3oBr8kP33MrnOu0reNA9IHMkv3c2THJzKt+Ai8gwN1Ub0fNQTJ7o35z3RoL3FpyNUyMs7hXZJdp9lbfU+8E/eP4E+t41LQ78Ik8NKfOWPKQtuybmUlbHe+Ke0LONwqIqxTFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfQLzz5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfQLzz5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB21F00A3A;
	Mon, 20 Jul 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784549843;
	bh=XVYeGYhO6R7mS4cWBGP1w2DZHG1yNj/c/EyGsMzKgc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZfQLzz5b+HO7mMyT37NPyc/mMxW8YsiD//m8ER1cuGfec9VqFgXQ1Fgz5wrpgVoJd
	 paa8TgCZTraPvETlVwUjt/4/V/seb9xK48PAgqAHg7iXYNWyM359OT5PvoNx9d40Pe
	 H5r0NXcEmGZXR9+GL0BpCCgVH4gMml+jH04PSSnn7nmaPnNAQLlZl5A6pu4uN19F/v
	 FqcgNDwtneY2WXI4atKFzKT4sV7X+3nWau9Gsiy6Bj4CaU12VGCsjEUpZOR7uWHJKn
	 4XgXZtK7I5pi+bQMwO196CeKCNuqKK8Fv1YRiMxw4UaSYJ9EgrS2Y6YVAmnfcIQ8M2
	 dLLs9zwlm1qnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] Docs/mm/damon/design: Document hugepage_mem_bp
 target metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260720120140.881468-4-gutierrez.asier@huawei-partners.com>
References: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
 <20260720120140.881468-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:17:23 +0000
Message-Id: <20260720121723.BEBB21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Underflow in total used memory calculation causes division by a hu=
ge number, breaking the intended safeguard and leading to aggressive DAMOS =
actions.
- [Low] Returning INT_MAX from damos_hugepage_mem_bp() causes an integer ov=
erflow when computing the quota score on 32-bit architectures.
- [Low] The newly added 'hugepage_mem_bp' sysfs metric is missing from the =
automated sysfs selftests.
--

--- Patch [3]: [PATCH v3 3/3] Docs/mm/damon/design: Document hugepage_mem_b=
p target metric ---
commit 8b5f375e8a76a103dce1c4b0a9e133966c306366
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Docs/mm/damon/design: Document hugepage_mem_bp target metric
   =20
Document hugepage_mem_bp metric exposed by sysfs.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e0122376f43d4..e38f2ddebb341 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3007,6 +3007,24 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);

[Severity: High]
Does this calculation handle vmstat drift correctly when free pages tempora=
rily
exceed total RAM?

Due to per-CPU negative deltas on mostly idle systems,
global_zone_page_state(NR_FREE_PAGES) can temporarily exceed totalram_pages=
().
If this happens, the unsigned subtraction will underflow to a massive value
instead of zero.

This would bypass the !total check and cause mult_frac() to divide by the
massive value, resulting in 0. Could this false 0% hugepage usage cause DAM=
OS
to aggressively apply actions when it should be pausing them?

> +
> +	/*
> +	 * vmstat may lag in idle systems and lead to free pages equaling to
> +	 * the total RAM in the system.
> +	 */
> +	if (!total)
> +		return INT_MAX;

[Severity: Low]
Can returning INT_MAX here cause an integer overflow in damos_quota_score()?

If total is exactly 0, returning INT_MAX means it will be multiplied by 100=
00
in damos_quota_score():

    score =3D mult_frac(goal->current_value, 10000, goal->target_value);

On 32-bit architectures, INT_MAX * 10000 will overflow. While the wrapped v=
alue
might remain large enough to suppress DAMOS actions in practice, it breaks =
the
10000 basis point scale. Should a smaller maximum value be returned here to
avoid the overflow?

> +	return mult_frac(thp, 10000, total);
> +}

[ ... ]

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 32f495a96b17a..d9b81d7b5910e 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_q=
goal_metric_names[] =3D {
>  		.metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>  		.name =3D "node_eligible_mem_bp",
>  	},
> +	{
> +		.metric =3D DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +		.name =3D "hugepage_mem_bp",
> +	},
>  };

[Severity: Low]
Is hugepage_mem_bp missing from the automated sysfs selftests?

The tools/testing/selftests/damon/sysfs.sh script explicitly tests the other
valid target_metric strings:

    ensure_write_succ "$fpath" "active_mem_bp" "valid input"
    ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
    ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
    ensure_write_fail "$fpath" "foo" "invalid input"

Without an entry for hugepage_mem_bp, the new sysfs interface won't be veri=
fied
by the kselftests CI framework.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720120140.8814=
68-1-gutierrez.asier@huawei-partners.com?part=3D3
