Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA141DE0F
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163636; cv=none; b=YBj30HyWXTjYPOnbCK76epaCtG3WVPq8pnh3a5NdnRooxtvR4Y1rgduY8INwyqEvd44202jdKvg9mo/Lxpq3G/c3imESeiO/pS3b6mwHAxC3MQ3AfTP6laHkd4mDX9j39SG41RtEMD4TKMed8CqWaQwLsIqijO5keZPfk/nri88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163636; c=relaxed/simple;
	bh=szL+c/J0S09OHKwfC27xV7XyhF0nbTR4aDGN7AbcXko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FGM5BMm7Qer0FOEpcoU93bDrH1asDlIyz4bZzKsKXlGYCwaeaUiJVHZ9WD64HENMjj9TkM4IraKQ4kConV2MbDVhXedz6Ix2g9bJoCAG/YDqH3u+1GJJDNnaZQiclkdSfYa98iCRosPgD+bsKHGa87ZS6gviLoPeKTRfnnRkgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guhe0Gx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guhe0Gx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7225F1F000E9;
	Mon, 27 Jul 2026 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163634;
	bh=VLOr+JnA3ZJKAQxEjpRPo1OZKNhxd6ZwcvofFpHai6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guhe0Gx81mb+tSj/HTnI9WmNZFqlufXZp+BKX+dAU16nOpwrrC50QA4pK5Z8PnUYC
	 XBuZyQQRV8gQqMZdt4DOeM0/xuQsgWOf06q9OhR/dIN1hNxWCxXioTvhomdfSlxKQa
	 FxHBLas7vtadwHw0pJGUE8obMsLzfBgj/X+trh5Zl6fd05Vds965p0aBIqAyz3xBv8
	 jjX8y3xde4KRQ1Mqr/5OZtq9AafnYspf6szmCTR0/zcPEU1Fs5hlvqs5TwclVsJH4H
	 3hwaN3ea9+5EZv1KGegzVGpfa0w4xBWMlh+H+PKcPJAkSc3gaFSw5/O266J+HUT3lz
	 2kcaekmO3kZzA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 01/17] mm/damon/core: introduce
 DAMON_FILTER_TYPE_PGIDLE_UNSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260727143829.86236-2-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
 <20260727143829.86236-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:47:13 +0000
Message-Id: <20260727144714.7225F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces `DAMON_FILTER_TYPE_PGIDLE_UNSET` but fails =
to implement its matching logic or expose it via sysfs.
--

--- Patch [1]: [RFC PATCH v2.1 01/17] mm/damon/core: introduce DAMON_FILTER=
_TYPE_PGIDLE_UNSET ---
commit 713d89253715d0f67d20248547ddafe132444f89
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET

This commit introduces a new DAMON filter type, pgidle_unset. It is intended
to match pages that have their PG_Idle flag unset or the page table accessed
bit set.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 0c8b7ddef9abb..a8bb9ee6979e3 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -742,12 +742,14 @@ struct damon_intervals_goal {
>  /**
>   * enum damon_filter_type - Type of &struct damon_filter
>   *
> - * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> - * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> + * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> + * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> + * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
>   */
>  enum damon_filter_type {
>  	DAMON_FILTER_TYPE_ANON,
>  	DAMON_FILTER_TYPE_MEMCG,
> +	DAMON_FILTER_TYPE_PGIDLE_UNSET,

[Severity: Medium]
Are the corresponding implementation details for this new filter type missi=
ng
from this patch?

The commit message states this will match pages that have their PG_Idle flag
unset, but the new DAMON_FILTER_TYPE_PGIDLE_UNSET variant doesn't appear to
be handled in the switch block evaluating filter types within
damon_pa_filter_match() in mm/damon/paddr.c.

Additionally, should this be exposed to userspace? The new filter type is
not mapped in damon_sysfs_filter_type_names in mm/damon/sysfs.c, which would
prevent it from being configured via sysfs.

>  };
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727143829.8623=
6-1-sj@kernel.org?part=3D1
