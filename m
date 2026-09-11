Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824503203B4
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089610; cv=none; b=CCmlUQTTb6s33/VfInrt3np+xa0p6v5TJrDMGAZd+4uSaT1uQIpymTr7ICugrp4ZHCAU6gFB5Crdvb7Uu87lliUr2rAeAcnDbEE244rgfcZBsw4cOuE0g/YOC0NW3nvKYd1mV2rAoTbcB9md6IUGfxh0ZWHnoyFnGi+RkV6aOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089610; c=relaxed/simple;
	bh=yiPAaZP+zOla8tfJb9hXz9sqwIDZqXhT/7Rps8e1YF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WsHqy+UwJ9bSmeDDbX4+7t2J+M4iWwbHl3JL7aUNCuhkTqSH9lCLxsdjKy9OVRhbmxTNcmnyLzRHXujEqKSUtEO4uf4OTl2ZxEdTAvBeQqbt0TLuGX4aOLqeH7lvXLDLqztXYDZBue1aMJoSmi9fCSrA1PXHJTQEuyphJA6a/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCObLw90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCObLw90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0397B1F000FF;
	Fri, 11 Sep 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089607;
	bh=OZOOUszJyfWvw7ZjH7+uXcQbBkl+MVV6GZPl8e/vfy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bCObLw901ySkw01IQMVF6rGXtmgJNlchdGaYVV2YfDuloj8RbWI3i/0NdCKPUUJ7d
	 1R1kLeNwqk8ay2YkdGhr819CowXEZIR8uomeZSo204hezaKcgwuP/Zqy6f+HwLmUEP
	 /I22A/zR1eJbmV/lQf0ICPvlPKCEb5pKq7qxXLsWJlS/DWB5F2BQVs5reeED8CNBTO
	 E5gA/6TF6/zBfzb/I/69fihsz47BDjnGGPc3xKkJPxavE8rVaiZAG1iV39XEDmJU+s
	 2xgxrGIOESfWdZZbaoiUJ/AkbBFa39rAxJM8hEiojnfyj6aVmFJFJykdvZ+NBW8NPa
	 v8pzbY3VJu9XQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 1/7] mm/damon/api: introduce
 DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-2-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:20:06 +0000
Message-Id: <20260911012007.0397B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc update for `enum damos_filter_type` creates ambiguit=
y regarding the handling of `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM`.
--

commit 901df9c4ed650529dec43469f4e3c96f3bf07c6f
Author: SJ Park <sj@kernel.org>

mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM

This commit updates the DAMON kernel API to introduce a new DAMOS core
filter type, PROBE_HITS_WSUM. It allows API callers to describe the DAMOS
action target regions based on their probe_hits weighted sum.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 871d26adf6ae5..ef99ff778ae10 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -399,14 +399,15 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>   *
> - * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
> - * are handled by the underlying &struct damon_operations as a part of s=
cheme
> - * action trying, and therefore accounted as 'tried'.  In contrast,
> - * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are han=
dled
> - * by the core layer before trying of the action, and therefore not acco=
unted
> - * as 'tried'.
> + * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET a=
nd
> + * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &str=
uct
> + * damon_operations as a part of scheme action trying, and therefore acc=
ounted
> + * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
> + * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
> + * trying of the action, and therefore not accounted as 'tried'.

[Severity: Low]
Does this documentation update leave the handling of
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM ambiguous?

The first sentence excludes DAMOS_FILTER_TYPE_PROBE_HITS_WSUM from being
handled by damon_operations, but the second sentence does not add it to the
list of filters handled by the core layer.=20

Could the second sentence be updated to explicitly mention
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM so developers reading the kernel-doc for
enum damos_filter_type know exactly when its evaluation phase occurs?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D1
