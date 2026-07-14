Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32749550A
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042109; cv=none; b=TFHTRk1NM/zX+pB3Kw4BpUts4vpDeChY95VIo99d4zpvcQub3xl/wa9VF5j5RRWS5yb+609jr7/bgquyEj32Zbxb+5y2+QN60uZrbsBfk+49dx5PEU1SFR837GeBsfUVJ7xpLGt0lT0x5LGlnPe8GPBTdPR578p4bO1gIogMDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042109; c=relaxed/simple;
	bh=CwUHzuJQzLRnnR3l36aGXMLjjCogjt1aCisYgrLM7Cc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHlN0tOlRSKOp0ED8BO5CBnc3ZmEfVGxyFGcHna1VVztRm+248ro/mhb+jLOw4LqWgzMh7eS9PGLrKIT4BrVDw01o5dBge4TGP5yLa8Jy5rt5TVfZfSm91hNg4pX8tJNRfYtCfMudm+AGxqn4WdCYQCgS1Wilnup7IDu9xzJXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDrIfi0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDrIfi0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9567D1F000E9;
	Tue, 14 Jul 2026 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042107;
	bh=nSe4QjMR2NkJ/saueNm4SP5NcdUhiW6qEpiYu9/56to=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDrIfi0ydkDsNaBozYFE+taUqu/68MdW1tgnBUu8gq3vlitYxPNuLTSu+GR6UIBFn
	 A1F7OChIHv4IZZzEIb2U6iTI2pciT03cotXVrjwqKhXlAV0DbuuCGNnvXme2JbmkVh
	 +AsTki8RbHzOeS8pZZFX/rSyKGn6zLeX8uY59KnEo+Tn2M3IYGzpUOE5Xxti4MZVpA
	 nKcXIHqqdkj0PIjhj5zDmnmmqhnCLBVsz+Aovt01qFNkxC9HioOZrpEydjCBGve8Ml
	 7/FkJ6BYmzCsLyVKJojAwlu/XVYNau5YytTH7b0q7lrHdq5ynFaEbfXKpf/dD5KH3V
	 hmNoP7ouuSINw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE
 auto tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260714150116.382521-2-gutierrez.asier@huawei-partners.com>
References: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
 <20260714150116.382521-2-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:15:07 +0000
Message-Id: <20260714151507.9567D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calculation of the huge page memory ratio in `damos_hugepage_mem_b=
p()` can trigger a divide-by-zero kernel panic if the calculated total memo=
ry evaluates to zero.
- [Medium] The new metric `DAMOS_QUOTA_HUGEPAGE_MEM_BP` is not exposed to t=
he DAMON sysfs interface, making it unconfigurable from userspace.

Pre-existing issues:
- [High] Preexisting division by zero vulnerability in `damos_get_in_active=
_mem_bp()` when LRU memory is empty.
- [High] A user-controlled target_value of 0 will cause a divide-by-zero pa=
nic during quota scoring.
--

--- Patch [1]: [RESEND PATCH v2 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPA=
GE auto tuning ---
commit bc154724e397943cbba0b2ca233b1c3995ce0802
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new
DAMOS quota goal metric to measure the amount of huge page
consumption to total memory consumption ratio.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 02ac34537df9a..6f87ec40db8ca 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -162,6 +162,7 @@ enum damos_action {
>   * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to total LRU memory ratio.
>   * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:	Scheme-eligible memory ratio of a
>   *					node in basis points (0-10000).
> + * @DAMOS_QUOTA_HUGEPAGE_MEM_BP:	Huge page to total used memory ratio.

[Severity: Medium]
Will this new metric be configurable from userspace?

It looks like damos_sysfs_qgoal_metric_names[] in mm/damon/sysfs-schemes.c
was not updated, which might cause target_metric_store() to return -EINVAL
when trying to configure this metric via sysfs.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b001f80681b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can total be zero here?

If the system has exactly 0 active and 0 inactive LRU pages (which could
happen if all memory is locked, used strictly by slab, or on tiny setups),
total would be 0. This might cause a divide-by-zero panic in mult_frac().

> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> +	return mult_frac(thp, 10000, total);

[Severity: High]
Could total evaluate to zero here?

Due to per-CPU drift in the vm_stat counters (global_zone_page_state),
NR_FREE_PAGES could momentarily equal totalram_pages(). Passing total =3D=
=3D 0
to mult_frac() will trigger a divide-by-zero kernel panic when the schema
is evaluated. Should we add a check for !total before calculating the
fraction?

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed another potential
divide-by-zero related to these quota goals.

In mm/damon/sysfs-schemes.c:target_value_store(), user input is parsed via
kstrtoul() directly into goal->target_value without validating that it is
non-zero:

    int err =3D kstrtoul(buf, 0, &goal->target_value);
    return err ? err : count;

Later, when the DAMON thread evaluates the quota score,
mm/damon/core.c:damos_quota_score() does:

    highest_score =3D max(highest_score,
            mult_frac(goal->current_value, 10000,
                goal->target_value));

Could a user writing 0 to the target_value sysfs file cause a predictable
and immediate system crash here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714150116.3825=
21-1-gutierrez.asier@huawei-partners.com?part=3D1
