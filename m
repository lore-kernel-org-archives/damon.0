Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D23EA97A
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801228; cv=none; b=O05dEveVrq9qJivzQu5rW4WBy9wsf8Yeg/1dj3oCh3rmOLS1PR455xqjGVmreKLUA+56PQ/bYF8Vd8hYGWyABz4cvrP22DtGhmwe5PaltUCylz5b9/twvaK4Fcz4aZ+3SbaovWBDsfCg7mhPb7AAHWmfR0EivPHyBtGJKdg5VNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801228; c=relaxed/simple;
	bh=kG6F1Koo2Uq1PxgbjlBldNzolsfGioNmHxIw8rdx2X0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxFCMSVgyAsB25PaKLM6bTP5P+2LNj19NaBHUbn6ZSZiOCk8oS8VbqN4k4gDwJzQQzeBZ0jVepOqCr+EflSQpHEGsmFAvShDED5MueHNuOJRc8Szdh1RjZiMBmcqa0TsFI5Lm1aQmWU2ncL828YgbHrR6ZlbJ+oG4R4sqKUZCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1XGE/1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1XGE/1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A93F1F00A3A;
	Mon,  7 Sep 2026 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801226;
	bh=3h7tiP26CH/weAeEWQuo2bL6NTZy7e+xPfuPbqBQyog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k1XGE/1zsOqZIVuaxAa4oCNv53G9DUodhrdxpxXHQEYAnGt22inTG3frL2axT92Yj
	 ca8yK/Uw4UZM2NloO6kItg3mrYmuhRk9uO+yLCsjYLpgi8OjdC7mKBOsDYW6piulB0
	 D7UPuxWgvaVMCkCE69fumMFjHSGufTJSfWXD+PtH/v7F2yW+zN/t+ShzBn+q/1shsK
	 hr4t6ltDu1/33jprSoVOJarVW1D7wrOBs9pJhIjRg45N+b/gGICsQ0PuOnc916aQl3
	 +kXmmhddpRKGMYV8EP3vcOdE6pZsQlCy2xcUKOGYmhJeygd5qIcmkGGg/RkOgu1RMq
	 K/zXuMBLbfrUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: reset invalid quota->charge_target_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260907165529.98874-1-sj@kernel.org>
References: <20260907165529.98874-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 17:13:46 +0000
Message-Id: <20260907171346.9A93F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added fix for invalid `charge_target_from` pointers is b=
ypassed if a scheme's quota is dynamically disabled, leaving the scheme per=
manently broken.
--

commit f88287bb2670346a5987d086e0731c7ba6d0b19e
Author: SJ Park <sj@kernel.org>

    mm/damon/core: reset invalid quota->charge_target_from
   =20
    DAMOS can suddenly stop working if a target process that quota just
    fully charged in it is terminated.  Fix by catching and processing the
    corner case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106ed..2c58be9edbde4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3318,6 +3334,8 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>  			damos_trace_esz(c, s, quota);
>  	}
> =20
> +	damos_reset_invalid_charge_target_from(quota, c);
> +
>  	if (!c->ops.get_scheme_score)
>  		return;
> =20

[Severity: High]
This is a pre-existing issue, but does this bypass the newly added reset if=
 a
scheme's quota is dynamically disabled?

If a user hits the corner case where charge_target_from becomes invalid, and
then dynamically disables the scheme's quota via sysfs (setting ms=3D0 and
sz=3D0), damos_adjust_quota() will return early before the reset is reached:

mm/damon/core.c:damos_adjust_quota() {
	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
		return;
	...
}

Because damos_skip_charged_region() does not check if the quota is enabled
before evaluating charge_target_from, it will continue to skip all regions
forever:

mm/damon/core.c:damos_skip_charged_region() {
	...
		if (t !=3D quota->charge_target_from)
			return true;
	...
}

Could the pointer reset be moved before the early return in
damos_adjust_quota(), or could the skipping logic be updated to handle
disabled quotas?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907165529.9887=
4-1-sj@kernel.org?part=3D1
