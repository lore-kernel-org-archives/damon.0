Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE13F23C4
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190864; cv=none; b=jwDLzOgFvyrYuF3sbX8eFo6vXXGgnuJrEO3+ZrA2VrAh3Z5ImlquH/YxQDT5IEfSTeUo3TJYorxQZXsM/CepE+mjisL8gIx/QdHLzyC/o4NbwCJlolZ6Q/heh7jojAzl9WN2h/8T9mAErCJy0rkT/aAKdcykpolxo/KZJ6/iEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190864; c=relaxed/simple;
	bh=ZRUvT3Hwcsyca06shh9J3gZvWWz/6K1mluB1pjrShJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t/hQOmWVmM4L00HCX7FZthrTz1xGAjKLdAUR91Ldb+su+Vly7M8gcIM/28jS9NuFErVlXzqRhsq+Y7Ba5u/Tpzv956JoefhsXSPjUKYnQevPosfr7QMNWGgErAGtR94unPNS65I8C/nCycxxuucWNcLz50sIIw4tKwlF/1Xu1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezD2Jac5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezD2Jac5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B591F00898;
	Thu, 11 Jun 2026 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190863;
	bh=BFx2TpUQ/KKIR5n9hguB9TNscofbsidG0OSoBQkAKTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezD2Jac5HMI7n8PVPBWDAvENfgHA62SuByVLI5vENXurA3R0k3UU0Cw64WVAhyp31
	 fRA5aXnUinr2GPpxSo30bUa5eVUoIT2E3NXlwfR92Asbn9ip7Ykv4ajjjH8eeEsoNf
	 fxQXBG0YszMEmDJxUxXK7ziAHPMNBirNjZhqPvM8t0g0AVMIYvoZfzY/9EvF8tm5kY
	 RnF3dDX6Tyrj3DYYxqgzeN/hVdXTqMDRVj05wWrkYLAvGhEdEyjkERlBObe2uasEFy
	 miiRJHKbJZjMwJsy7CBPjf6b+FStruG5hwEs3ceGTfkK/lgwMdo1iIuXVbKP48Gpob
	 OdTfvy0mTrxuQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 4/4] Documentation/admin-guide/mm/damon: add
 DAMON-based Hugepage Management
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260611150244.3454699-5-gutierrez.asier@huawei-partners.com>
References: <20260611150244.3454699-5-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:14:22 +0000
Message-Id: <20260611151423.27B591F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly states that the module collapses =
hot memory regions 'back to regular pages'.
- [Medium] The documentation incorrectly claims the page collapsing limit i=
s up to 1 GiB per second, whereas the code restricts it to 128 MiB per seco=
nd.
- [Medium] The documentation incorrectly describes the huge page quota perc=
entage metric as a ratio against anonymous memory.
- [Medium] The documentation claims administrators can provide dynamic manu=
al feedback to adjust the quota, but the module lacks runtime update capabi=
lities.
- [Low] Missing newline at the end of the newly added documentation file.
- [Low] Multiple typographical and grammatical errors in the documentation.
--

commit 9d20df125ff887031458f9f9da39b696dcac8419
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management

This patch adds documentation for the DAMON-based Hugepage Management
feature. It covers the module's features, operation, and all available
module parameters.

> Add documentation for the DAMON-based Hugepage Management
> (SAMPLE_DAMON_HUGEPAGE) feature, which automatically manages
> huge pages by identifying hot memory regions and collapsing
> them back to regular pages.

[Severity: Medium]
Does this module actually collapse huge pages into regular pages?

The documentation below correctly notes that the module collapses regular
pages into huge pages. Could the commit message be updated to reflect the
actual operation?

> diff --git a/Documentation/admin-guide/mm/damon/hugepage.rst b/Documentat=
ion/admin-guide/mm/damon/hugepage.rst
> new file mode 100644
> index 0000000000000..470ae2bc8cc31
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/damon/hugepage.rst

[ ... ]

> +quota_autotune_feedback
> +-----------------------
> +
> +User-specifiable feedback for auto-tuning of the effective quota.
> +
> +While keeping the caps that set by other quotas, SAMPLE_DAMON_HUGEPAGE
                     ^^^^^^^^^^^^^^^^^^

[Severity: Low]
This isn't a bug, but there is a typo here. Should this be "caps set by"?

> +automatically increases and decreases the effective level of the quota
> +aiming receiving this feedback of value 10,000 from the user.
   ^^^^^^^^^^^^^^^^

[Severity: Low]
This isn't a bug, but there is a typo here. Should this be "aiming to recei=
ve"?

[Severity: Medium]
Does the module actually accept runtime feedback for the quota?

Unlike other DAMON modules like reclaim, this module does not seem to have a
commit_inputs mechanism to apply runtime updates to the DAMON context.=20

Since quota_autotune_feedback is only read once during
damon_sample_hugepage_start(), is this dynamic feedback mechanism supported
by the code?

> +SAMPLE_DAMON_HUGEPAGE assumes the feedback value and the quota are posit=
ively
> +proportional.  Value zero means disabling this auto-tuning feature.
> +
> +Disabled by default.
> +
> +quota_percentage_hugepage
> +-------------------------
> +
> +Huge page consumption to total memory anonymous memory consumption ratio=
 goal
> +in bp (10,000). SAMPLE_DAMON_HUGEPAGE automatically increases and

[Severity: Medium]
Is this ratio actually based on anonymous memory consumption?

Looking at damos_hugepage_mem_bp(), it calculates the ratio against the tot=
al
system used memory:
totalram_pages() - global_zone_page_state(NR_FREE_PAGES)

Could this be updated to reflect it does not just use anonymous memory?

[ ... ]

> +Example
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Below runtime example commands make SAMPLE_DAMON_HUGEPAGE to find memory
> +regions of  the task with PID 1234 that have been accessed in the last 1=
00
              ^^

[Severity: Low]
This isn't a bug, but there is an extra space here.

> +milliseconds or more and collpases those pages into huge pages. The page
                            ^^^^^^^^^

[Severity: Low]
This isn't a bug, but there is a typo here. Should this be "collapses"?

> +collapsing is limited to be done only up to 1 GiB per second to avoid

[Severity: Medium]
Is the limit actually 1 GiB per second?

The underlying module statically sets the quota limit (damos_quota.sz) to
128 * 1024 * 1024 (128 MiB) with a reset_interval of 1000 ms.

> +SAMPLE_DAMON_HUGEPAGE consuming too much CPU time for the collapse opera=
tion. ::
> +
> +    # cd /sys/module/damon_sample_hugepage/parameters
> +    # echo 1234 > target_pid
> +    # echo Y > enabled
> +
> +Note that this module (SAMPLE_DAMON_HUGEPAGE) cannot run simultaneously
> +with other DAMON-based special-purpose modules.  Refer to
> +:ref:`DAMON design special purpose modules exclusivity
> +<damon_design_special_purpose_modules_exclusivity>` for more details.
> \ No newline at end of file

[Severity: Low]
This isn't a bug, but standard POSIX text file and Linux kernel coding
guidelines require a trailing newline at the end of the file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611150244.3454=
699-1-gutierrez.asier@huawei-partners.com?part=3D4
