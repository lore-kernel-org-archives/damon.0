Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2433168EF
	for <damon@lists.linux.dev>; Fri, 22 May 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470195; cv=none; b=eJtBcKOxKEk/OCHibxLF8+wT/IqEQJWv1qT0MPyLkIIxgUKes4py+DAqZX8jH+ULAFqX7KagyRKujLLBiinTEw1nqpo9YvmlQhI8FRapRc6pFnk0ood/dLIzh1DtHHsLCBfANn6Su2L6aBv+eRcGCQfRV8dP5jzNMMJfOvl/Ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470195; c=relaxed/simple;
	bh=DRB7HXsRUQPvhPFn3vYNuqRVXdW1LMbDHCI8QD22dsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jvR23BWNPrKy2Lfi3VAmPf51fdN4i6Yywq1x/AoIsGyYZngK7x/GUSxBNKN0YyVirN418u3OeOht+GLekHbODiqi59Ghm7c2c0kY3rrwA9Vo/2HzZauY0Y6LtCTapt+MVbXj7nzSCEOMC7lXtAcdYmNg22fxZbAKNZYrOQP7b/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5vtkyBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5vtkyBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF5B1F000E9;
	Fri, 22 May 2026 17:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470193;
	bh=lGuP1DT8WIj1pqluYGTI22eZvzPD/qQRteTWYrycmBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5vtkyBRn8UrE9eGvABXJTzVKCYT0TBzlk0URtwj13XGAaCgFOHZTlwRovnVAvhSf
	 ju/GwdaTY/8LJTxDzWnuq7LX0JnD+198KSgnTFjgr92Yl8ziH0BtggM2oVVbxUG7UP
	 pzv6KHF9nJQXs4vjRr9PabB1a5P8iFv/M2SlZ7fC7QYeCug3U0w+Rlw/fgCmR5HckS
	 hhFgUIQYMEAbajIXJMZhE+PfAm42BgGchrAh9hKDPYxjJOq9RHkkOpTkKddcfnuiFC
	 B2dJ5fKrOucsKjhmWV3jItXPf8mea4BKhhcb5v+gD8QSGQFXHYYoBzOcMHaPmks+Ue
	 T44rQSoRxsfYA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/4] Documentation/admin-guide/mm/damon: add
 DAMON-based Hugepage Management documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260522145518.158910-5-gutierrez.asier@huawei-partners.com>
References: <20260522145518.158910-5-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 17:16:33 +0000
Message-Id: <20260522171633.AAF5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Severe contradictions and copy-paste errors between the commit m=
essage, documentation, and parameter descriptions.
- [Low] Missing documentation section for the `quota_sz` parameter.
- [Low] reStructuredText section underlines are shorter than their titles, =
which will cause Sphinx build warnings.
- [Low] Multiple typographical, grammatical, and phrasing errors.
--

commit fc9f4527e2269a43dfb3a88b19482a76212ae0e5
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management doc=
umentation

Add documentation for the DAMON-based Hugepage Management
(DAMON_HUGEPAGE) feature, which automatically manages huge pages  by
identifying cold memory regions and collapsing them back to regular
pages. The documentation covers the module's features, operation, and
all available module parameters.

> Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management d=
ocumentation
>=20
> Add documentation for the DAMON-based Hugepage Management
> (DAMON_HUGEPAGE) feature, which automatically manages huge pages  by
> identifying cold memory regions and collapsing them back to regular
> pages.

[Severity: Medium]
This isn't a bug, but there's a contradiction between the commit message
and the actual behavior described in the documentation. The commit message
claims it manages huge pages by identifying cold memory regions and
collapsing them back to regular pages (which sounds like splitting),
while the documentation correctly states it aims to collapse hot regions
into huge pages.

> diff --git a/Documentation/admin-guide/mm/damon/hugepage.rst b/Documentat=
ion/admin-guide/mm/damon/hugepage.rst
> new file mode 100644
> index 0000000000000..4e7a8dad765bd
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/damon/hugepage.rst
> @@ -0,0 +1,258 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DAMON-based huge page collapsing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
This isn't a bug, but the reStructuredText title underline is shorter than
the title text itself. In Sphinx, an underline must be at least as long as
the text to avoid build warnings. There are a few other headers in this
file with the same issue.

> +
> +DAMON-based huge page collapsing (DAMON_HUGEPAGE) is a static kernel mod=
ule
> +that aimed to collapse hot regions into huge pages.

[Severity: Low]
This isn't a bug, but there's a grammatical error here: "that aimed to
collapse" should probably be "that aims to collapse".

> +
> +Where Proactive huge page collapsing is Required?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The amount of available memory grows faster than the amount of TLB entri=
es.
> +This leads to higher amount of TLB misses and excesive cycle wastes. Huge

[Severity: Low]
This isn't a bug, but there's a typo here: "excesive".

[ ... ]

> +commit_inputs
> +-------------
> +
> +Make DAMON_HUGEPAGE reads the input parameters again, except ``enabled``.
> +
> +Input parameters that updated while DAMON_HUGEPAGE is running are not ap=
plied
> +by default.  Once this parameter is set as ``Y``, DAMON_HUGEPAGE reads v=
alues
> +of parametrs except ``enabled`` again.  Once the re-reading is done, this

[Severity: Low]
This isn't a bug, but there's a typo here: "parametrs".

[ ... ]

> +quota_reset_interval_ms
> +-----------------------
> +
> +The time/size quota charge reset interval in milliseconds.
> +
> +The charget reset interval for the quota of time (quota_ms) and size

[Severity: Low]
This isn't a bug, but there's a typo here: "charget".

> +(quota_sz).  That is, DAMON_HUGEPAGE does not try collapsing for more th=
an
> +quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
> +milliseconds.

[Severity: Low]
Is there a missing documentation section for the quota_sz parameter? It is
explicitly mentioned here and used in the Example section later, but there
is no dedicated documentation block for it under the Interface: Module
Parameters section.

[ ... ]

> +quota_percentage_hugepage
> +----------------
> +
> +Huge page consumption to total memory anonymous memory consumption ratio=
 goal

[Severity: Low]
This isn't a bug, but "total memory anonymous memory consumption" is
repetitive and slightly confusing.

> +in bp ``(10,000)``. DAMON_HUGEPAGE automatically increases and decreases=
 page
> +collapse aggressiveness in order to achieve the given value.
> +
> +sample_interval
> +---------------
> +
> +Sampling interval for the monitoring in microseconds.
> +
> +The sampling interval of DAMON for the cold memory monitoring.  Please r=
efer to
> +the DAMON documentation (:doc:`usage`) for more detail.

[Severity: Medium]
Are these references to cold memory monitoring intentional?

The commit message and earlier documentation indicate this module tracks
hot regions for collapsing. It appears the descriptions for sample_interval,
aggr_interval, min_nr_regions, and max_nr_regions were copied from
DAMON_RECLAIM and still refer to cold memory monitoring.

[ ... ]

> +addr_unit
> +---------
> +
> +A scale factor for memory addresses and bytes.
> +
> +This parameter is for setting and getting the :ref:`address unit
> +<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_HUGE=
PAGE.
> +
> +``monitor_region_start`` and ``monitor_region_end`` should be provided i=
n this
> +unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`=
` and
> +``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respective=
ly.
> +Then DAMON_HUGEPAGE will work for 10 KiB length of physical address rang=
e that
> +starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).

[Severity: Medium]
Should this refer to a physical address range?

Since this module monitors a process via monitored_pid, it operates on
virtual memory rather than physical addresses. This also appears to be a
leftover from copying another DAMON module's documentation.

[ ... ]

> +Example
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Below runtime example commands make DAMON_HUGEPAGE to find memory region=
s of
> +the task with PID 1234 that have been accessed in the last 100 millsecon=
ds or

[Severity: Low]
This isn't a bug, but there's a typo here: "millseconds".

> +more and pages out. The pagecollapsing is limited to be done only up to =
1 GiB

[Severity: Medium]
Is the phrase "and pages out" a leftover copy-paste error from
DAMON_RECLAIM?

[Severity: Low]
This isn't a bug, but there's a typo here: "pagecollapsing".

> +per second to avoid DAMON_HUGEPAGE consuming too much CPU time for the c=
ollapse
> +operation. ::

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522145518.1589=
10-1-gutierrez.asier@huawei-partners.com?part=3D4
