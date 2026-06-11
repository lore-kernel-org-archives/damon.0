Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD12C3268
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191309; cv=none; b=pLHcLell1vfVjcmdkwiczQOKvCgnE9+DKstOAsl//ekE9lDWvh0bAk4+uBlUVTOCuhUtqIkxjJ+Tjwy8euk/841jFMuQ1VyExPnsMY2qhb92FXe92jFdj58tMpjigccxyyGs/nwJanq/kXZviXwzf4zGuHKQffZ+xHsD1C7bG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191309; c=relaxed/simple;
	bh=0ccL+Tc7DdWQ4nggps1ubDSTORakY080DyZH9bTDXks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RzXcAyPdUIj8RX3Tbxp6RotroDuxtS6bC1B9W3wHSPcqk5G9dFW0BwbMq4PbXdRYH2wygOfQ7I4KBh3zsVtBdzlBLpiliMQTvOFweNDy11Iuee02AXSaE76I9oot8/xqrjOXyL+0USdaz+tq1Ca3coe/6L8itky+a3sLpj4sAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flk4AXHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flk4AXHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2821F00898;
	Thu, 11 Jun 2026 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191306;
	bh=OjiOZ4IeQzlTBaSWW1zViAxAcUzcRlxZIKkZAD/kvUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Flk4AXHA1WOjdyXUe/aG70eFCzhmjGZFura5R3ixS2W0CbE8D86sBBPsK9xvUXJZy
	 IY3xHFd9aWykQSeB4CV5aaC/+f0XPPNWaIaVe8WMmqtEQh4ztl2X0U5e/l3JzXImZ4
	 KZkXqZJMlzq0b78TWnvYFafA43TYtmU8N9L2heLMXOFsn1t9AfmeynOXWPxVKJ45sl
	 +PAL1DaosgvOWf+qJzSiJv6MCBSSJPKmByaZWnPHs8bINMXT9IFnnJ3VWcVzhK45KK
	 xxAHx9faeoCVtsRMFMJnEyjZJHijVOdLrjuP56c6W1ctG8GETeqOC6EhxGne+J3Zz5
	 YVRRKaJ3RmDSg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260611150244.3454699-3-gutierrez.asier@huawei-partners.com>
References: <20260611150244.3454699-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:21:46 +0000
Message-Id: <20260611152146.AD2821F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Mismatch between commit message documentation and actual module =
parameter name for the target PID.
- [Low] Missing Kconfig dependency causes build failure on architectures/co=
nfigs without huge page leaf support.

Pre-existing issues:
- [High] Potential divide-by-zero kernel panic in `damos_hugepage_mem_bp` w=
hen total memory evaluates to zero.
--

commit 4d499570cf03bd13f013e3c89938e2739ead1edf
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing

This patch introduces the SAMPLE_DAMON_HUGEPAGE module to monitor a task
and collapse hot memory regions into huge pages. It adds the necessary
Kconfig, Makefile, and sample code implementation.

>     SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
>     specific task. The user is expected to supply the PID of the task
>     that is going to be monitored through the monitored_pid module
>     variable.

[Severity: Medium]
Is this module variable name accurate? The commit message documents that us=
ers
should supply the PID via the monitored_pid module variable, but the Kconfig
and C code below actually define and register it as target_pid.

> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
> index cbf96fd8a8bf9..512f150aaabba 100644
> --- a/samples/damon/Kconfig
> +++ b/samples/damon/Kconfig
> @@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
> =20
>  	  If unsure, say N.
> =20
> +config SAMPLE_DAMON_HUGEPAGE
> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HUGEPAGE)"
> +	depends on DAMON && DAMON_VADDR

[Severity: Low]
Does this require an explicit dependency on TRANSPARENT_HUGEPAGE or
PGTABLE_HAS_HUGE_LEAVES?

If huge page leaves are not supported on the target architecture,
HPAGE_PMD_SHIFT evaluates to a BUILD_BUG() expression. Because
SAMPLE_DAMON_HUGEPAGE evaluates this unconditionally below, configuring a
kernel without huge page support will result in an immediate compile-time
failure.

> +	help
> +	  This module monitors a certain PID provided by the user through
> +	  monitored_pid attribute. Hot regions are determined by DAMON-based

[ ... ]

> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
> new file mode 100644
> index 0000000000000..2c7fd213a8db1
> --- /dev/null
> +++ b/samples/damon/hugepage.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +static int damon_sample_hugepage_start(void)
> +{
> +	int err;
> +	struct damon_target *target;
> +	struct damos *scheme;
> +	struct damos_quota_goal *goal;

[ ... ]

> +	scheme =3D damon_new_scheme(&(struct damos_access_pattern) {
> +				.min_sz_region =3D HPAGE_PMD_SIZE,

[Severity: Low]
This is where HPAGE_PMD_SIZE is evaluated unconditionally, which will trigg=
er
the BUILD_BUG() if the Kconfig dependencies are not updated.

[Severity: High]
This isn't a bug introduced by this patch, but can this feature trigger a
divide-by-zero kernel panic?

This problem was introduced by a preceding patch in the same series
('mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning'), and it appears to
remain unfixed at the end of the series.

Looking at damos_hugepage_mem_bp() in mm/damon/core.c:

mm/damon/core.c:damos_hugepage_mem_bp() {
    ...
    total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
    return mult_frac(thp, 10000, total);
}

Due to the nature of per-CPU counter caches,
global_zone_page_state(NR_FREE_PAGES) can drift. In extreme edge cases,
such as when nearly all managed pages are free, the free pages count can
equal or temporarily exceed totalram_pages(), causing total to evaluate to =
0.

Would passing total =3D=3D 0 to mult_frac() trigger a division-by-zero
exception?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611150244.3454=
699-1-gutierrez.asier@huawei-partners.com?part=3D2
