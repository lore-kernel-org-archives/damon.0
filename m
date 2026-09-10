Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA622F3C37
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050439; cv=none; b=C9dwnv31xHTzMBw0Zi9mMmGAe9uP3QrjfajSJ64pETij9hOOyIj7XQ/SWnJfFMNURG7GU5CXi2VYMsR5+m7g4mNfVaL5MIB6CeJm7a1bANNMzLv3rlEDDLPurFqeiw+14Zm0Rg1sgKe/qDP4NK9I5sJEcHTQxgUTSgFT++AO0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050439; c=relaxed/simple;
	bh=4Q9y/+ZggsFdR3Gx++v491IjUnvzn6OGb/MSTP/PKiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rry1pTqcLuGRy6PF+bRfp0zCnLm+Zg7Y9SJhCKjuY3QHA+kKjLdp+xpadEo6fjVyy5SNka/YbOjKPBg1AB+t+IJGa77HKDHzOEB8FZvciOIMOouJSGuwR+YCh4Nb1XNNIIiyzL+9/qxtfPUIvouG3VPCsPt7PxB9FkJV/74ynMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAOYDg4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAOYDg4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D11F00893;
	Thu, 10 Sep 2026 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050437;
	bh=QFILEr177zdzKRgbgUIbcDWCXbBN0rsUjrL3SJxqOpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAOYDg4hJCBKEGlOZ54k/xAgepgYDL17dvbZCUVyGxTNciJUq9A5PttoBO8Ffb/C2
	 VgVOuhtb7bOl4FeRj9n15v67qCRJyvLCHJ33s1EpS2my2zpPXiob/gEP3BjJ12L7Zo
	 /XtkKs4PtmzQ/r0nTku2nIpV9+eLFnI9CpdqBtm1+wSZOOr09JwAj273t6ztlrXGKX
	 t4p6y9Qcp5TRbWYOBIY7+ZrurpcK7p6MlzlCSwnoIh1h9QZvjE/ZNlV5ZU9KT6Myya
	 y5cDGGts2Cz/ZtCiLjWhApvCmy3LAOeILZl9vHnPH2kHmAPn24Fgg2zKCyN3s8vsqR
	 p3a6K6NXHUVng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon/api: introduce
 DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-2-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:27:17 +0000
Message-Id: <20260910142717.916D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kerneldoc comment for `enum damos_filter_type` leaves the handl=
ing behavior of `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` unexplained and contrad=
ictory.
--

commit 78a988db300660b08e965cf2117e7ad015861252
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM

This commit introduces the DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter type
to allow API callers to target regions based on their probe_hits weighted
sum. It also updates the damos_filter structure and associated
documentation to accommodate this new filter.

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
Does this leave the handling behavior of the new filter unexplained?

The newly updated kerneldoc for enum damos_filter_type explicitly excludes
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM from the list of filters handled by
operations, but it appears to be missing from the subsequent sentence
detailing which filters are handled by the core layer.=20

This creates a contradiction where its handling behavior is undefined. Shou=
ld
it be added to the second sentence alongside DAMOS_FILTER_TYPE_ADDR and
DAMOS_FILTER_TYPE_TARGET?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D1
