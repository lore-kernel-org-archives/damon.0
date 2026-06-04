Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61E3988E4
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588126; cv=none; b=PfBU8v5wG+i9KGDHacZq/m6m/eMt6gVN+7muI5sp3bgzLhSHwdI9dv175Ful/9Bz/ihbGcp+4DgIuxXeI+Gthxehm4kuC922lLMDvVwNQ/jMhwaTXRcqSoZp1YnMKVwnJRPn+c5hRQafN8d980qoXN5yS4uZTUlynqNCHAwuRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588126; c=relaxed/simple;
	bh=jEV5ClVmP0iQTyz1nuv98exl9hqDqDobV/q1I62Xc00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MiuIVpOoRNoXKFPzfm/xgcSaGhTY/0QB50sE+m9eCSWsU9a91R1gxCLKB02Auf0kSfi2WL8ssq7LUDZnmAygU66+8+wR8JWC9G4eJvQP2RxfxlMDlYNVKrKgcnqufPnF9sQtS98XYpfnKBlROH770ZaAMyJWusx9N6cbXyW7ziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka1FP856; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka1FP856"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DB11F00893;
	Thu,  4 Jun 2026 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588120;
	bh=8xsgwUkTlRTWpGEgX6efJZuVp8eH43bfejht7ROZsvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ka1FP856N52wLFYeSyJAX6qA0iF03wsUMTJvSjrOrcn1buMoZ9Tfo2ro8DzOJZ1ag
	 VlLCOAWGy+TCgH0Qo66Hmb+NXRs5iNRARdZzEMC7HodR0KzT3DOKVHjMHW9rIpcLSM
	 NBOSPSOokiLs/CBSwp/+v2YL2A9a1Y9qBDJo1zuHLTe111Zpv+8An/yFRQLS07bOm6
	 VVRIGgGPDs+G47lnGiTXYGnFCEvnGfGGCFFfTYp0DSCJReIGxqGUihPoraRtWGXJqj
	 tNTVOYO6HzXujb/3rYgN6sROdjupp0Php21AH1w76xREVGU3hfToUoa1Es+C+igytZ
	 r/q0c1chiMH/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/4] Documentation/admin-guide/mm/damon: add
 DAMON-based Hugepage Management
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260604150338.501128-5-gutierrez.asier@huawei-partners.com>
References: <20260604150338.501128-5-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:48:40 +0000
Message-Id: <20260604154840.92DB11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Low] The newly added documentation file `hugepage.rst` is orphaned becau=
se it is not included in any Sphinx `toctree`.
- [Low] The documentation references an incorrect Kconfig symbol `CONFIG_DA=
MON_HUGEPAGE` instead of `CONFIG_SAMPLE_DAMON_HUGEPAGE`.
- [Low] Missing newline at the end of the newly added documentation file.
- [Low] Multiple spelling and grammatical errors in the newly added documen=
tation.
--

commit 24c835e6a5624692adf95a519c4c1747fca62d26
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management

Add documentation for the DAMON-based Hugepage Management
(SAMPLE_DAMON_HUGEPAGE) feature, which automatically manages
huge pages by identifying hot memory regions and collapsing
them back to regular pages.

[Severity: Low]
Is this new documentation file orphaned? It doesn't appear to be added to t=
he
toctree in Documentation/admin-guide/mm/damon/index.rst.

> diff --git a/Documentation/admin-guide/mm/damon/hugepage.rst b/Documentat=
ion/admin-guide/mm/damon/hugepage.rst
> new file mode 100644
> index 0000000000000..86104aaa4d1c3
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/damon/hugepage.rst

[ ... ]

> +Interface: Module Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +To use this feature, you should first ensure your system is running on a=
 kernel
> +that is built with ``CONFIG_DAMON_HUGEPAGE=3Dy``.

[Severity: Low]
Does this reference the wrong Kconfig symbol? The module appears to be
SAMPLE_DAMON_HUGEPAGE, so should this be CONFIG_SAMPLE_DAMON_HUGEPAGE=3Dy?

[ ... ]

> +commit_inputs
> +-------------
> +
> +Make SAMPLE_DAMON_HUGEPAGE reads the input parameters again, except ``en=
abled``.

[Severity: Low]
This isn't a bug, but should "reads" be "read" here?

> +
> +Input parameters that updated while SAMPLE_DAMON_HUGEPAGE is running are

[Severity: Low]
This isn't a bug, but should this be "parameters that are updated"?

[ ... ]

> +quota_reset_interval_ms
> +-----------------------
> +
> +The time/size quota charge reset interval in milliseconds.
> +
> +The charget reset interval for the quota of time (quota_ms) and size

[Severity: Low]
This isn't a bug, but there is a typo here ("charget" -> "charge").

[ ... ]

> +quota_autotune_feedback
> +-----------------------
> +
> +User-specifiable feedback for auto-tuning of the effective quota.
> +
> +While keeping the caps that set by other quotas, SAMPLE_DAMON_HUGEPAGE
> +automatically increases and decreases the effective level of the quota
> +aiming receiving this feedback of value ``10,000`` from the user.

[Severity: Low]
This isn't a bug, but should this be "aiming to receive"?

[ ... ]

> +Example
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Below runtime example commands make SAMPLE_DAMON_HUGEPAGE to find memory
> +regions of  the task with PID 1234 that have been accessed in the last 1=
00
> +milliseconds or more and collpases those pages into huge pages. The page

[Severity: Low]
This isn't a bug, but there is a typo here ("collpases" -> "collapses").

[ ... ]

> +Note that this module (SAMPLE_DAMON_HUGEPAGE) cannot run simultaneously
> +with other DAMON-based special-purpose modules.  Refer to
> + :ref:`DAMON design special purpose modules exclusivity
> + <damon_design_special_purpose_modules_exclusivity>` for more details.
> \ No newline at end of file

[Severity: Low]
This isn't a bug, but could we add a newline at the end of the file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150338.5011=
28-1-gutierrez.asier@huawei-partners.com?part=3D4
