Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1B43E483
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563994; cv=none; b=a56FxCOwoHne0449i0gpoK7OmCPdipM/2UTwVMxRG1bFI4/ce59/YG8hbwwyZ/dHo/W3J8DPgkhDdfR36cLamQVC/W4a1gJ5FPTMKKkEWqNw2mAlm33wvhp1vxGIOVOShQs4pzV8RgAp9NEs0MXqkaF2qEyDkX6BbPc+QMmtKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563994; c=relaxed/simple;
	bh=mIMcIka/1cSoHKn84uzjhpOAvTEP5EReJmU1o2HgxpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFVyg2FF+aSp67NP5Q4yE2zmARazbVNcRprKfM/ucb1cOz/Bl+f4jwXuaEh3eekvPnV/hm7Ek9ela8gvBPsjMGj1Lti8FiTIjztnQ4mbiEokTvObLKw8GO0onIL1VCWTiLq6iEWi85ybtd+nIArqgrAScQSBJqQPbHsoVQCy0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwfZzjx0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwfZzjx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F429C2BCB3;
	Thu, 30 Apr 2026 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563994;
	bh=mIMcIka/1cSoHKn84uzjhpOAvTEP5EReJmU1o2HgxpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PwfZzjx0TP8fhKwXTTE7NUfYEfv1AubyhsSdn5NgxhoQQdodQBbhm04Y/po8saKjG
	 1dIixdSgMHpKg4sFQkF4365vEphC1f2uJcOt1XvYtzmzCvHW6brDxFagHLyEhTqbMq
	 8r5ksRLZde0+aD1+M51TZqQmXF8wJyftH9+T59u+23x8xw8crr23y6jhmaZyPRmfOv
	 MKYyIw6ErWOm4OpE/lLye6iYliAYPDFJV5dID+S1HjlXe//gWSNUlK35Ke2PKbp/NA
	 bkJGPYHiepJJrTFF30i7MDwuNyR0bRGT4/JouiqwhUlh4cYIQ18bikzHLU0qbYd+Xk
	 BfgRP+9P2030w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 4/4] Documentation/admin-guide/mm/damon: add
 DAMON-based Hugepage Management documentation
Reply-To: sashiko@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260430134139.2446417-5-gutierrez.asier@huawei-partners.com>
References: <20260430134139.2446417-5-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 15:46:33 +0000
Message-Id: <20260430154634.2F429C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] The commit message contradicts the documentation regarding the p=
urpose of the feature.
- [Medium] The documentation contains misleading copy-paste artifacts from =
DAMON_RECLAIM.
- [Low] Module parameters `quota_sz`, `monitor_region_start`, and `monitor_=
region_end` are referenced but missing from the parameter list.
- [Low] ReStructuredText title underlines and overlines are shorter than th=
e title text.
- [Low] Typographical and grammatical errors throughout the documentation.
--

commit 9b382ff592df88342968dca086c2635e151edeb9
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management doc=
umentation

This commit adds documentation for the new DAMON-based Hugepage Management
(DAMON_HUGEPAGE) feature, outlining its operation, use cases, and configura=
ble
module parameters.

> Add documentation for the DAMON-based Hugepage Management (DAMON_HUGEPAGE)
> feature, which automatically manages huge pages by identifying cold memory
> regions and collapsing them back to regular pages. The documentation cove=
rs

Is this description accurate? The documentation states the module aims to
"collapse hot regions into huge pages". The commit message seems to describe
the opposite behavior (finding cold regions to split into regular pages).

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

This isn't a bug, but the underlines and overlines are shorter than the
title text (32 characters). This will trigger "Title underline too short"
warnings during the Sphinx documentation build.

> +
> +Where Proactive huge page collapsing is Required?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The same reST underline issue is present here.

> +
> +The amount of available memory grows faster than the amount of TLB entri=
es.
> +This leads to higher amount of TLB misses and excesive cycle wastes. Huge

This isn't a bug, but there's a typo here ("excessive").

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

This isn't a bug, but there is a typo here ("parameters").

[ ... ]

> +quota_reset_interval_ms
> +-----------------------
> +
> +The time/size quota charge reset interval in milliseconds.
> +
> +The charget reset interval for the quota of time (quota_ms) and size

This isn't a bug, but there is a typo here ("charge").

> +(quota_sz).  That is, DAMON_HUGEPAGE does not try collapsing for more th=
an
> +quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
> +milliseconds.

The parameter quota_sz is referenced here, but it appears to be missing
its own parameter definition section. Should it be added to the list?

[ ... ]

> +monitored_pid
> +----------------
> +
> +PID of the task that is going to be monitored for hot regions.
> +
> +quota_percentage_hugepage
> +----------------

This isn't a bug, but the underline is shorter than the title text
"quota_percentage_hugepage" (25 characters).

> +Huge page consumption to total memory anonymous memory consumption ratio=
 goal
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

Does DAMON_HUGEPAGE monitor for cold memory? The introduction states
it identifies hot regions. It looks like this description might be a
copy-paste artifact from DAMON_RECLAIM.

The same description of "cold memory monitoring" is repeated for
aggr_interval, min_nr_regions, and max_nr_regions below.

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

Similar to quota_sz, the parameters monitor_region_start and
monitor_region_end are actively referenced here but lack their own
definition sections. Are they missing from the documentation?

[ ... ]

> +Example
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Below runtime example commands make DAMON_HUGEPAGE to find memory region=
s of
> +the task with PID 1234 that have been accessed in the last 100 millsecon=
ds or

This isn't a bug, but there's a typo here ("milliseconds").

> +more and pages out. The pagecollapsing is limited to be done only up to =
1 GiB

Does DAMON_HUGEPAGE page out memory? This looks like another copy-paste
artifact from DAMON_RECLAIM.

This isn't a bug, but there's also a typo here ("pagecollapsing" instead
of "page collapsing").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430134139.2446=
417-1-gutierrez.asier@huawei-partners.com?part=3D4
