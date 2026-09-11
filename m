Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914030567D
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135470; cv=none; b=TzQOARJMC+OPa2BS9bOINAsCIoZVi5RW/tcTnezcLKifDQGWASAj97iEXrdHcrm/jqRfwaKIn7ibSQieMTit0x+wGh8bBj2ai4fNzgnxuuViItRDvNzNJuhAMs0HIw5z6RfzS6veV4/+LJu0sNEOgR6ZHUJUd336xVaJUjKjwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135470; c=relaxed/simple;
	bh=qxIP6mYCj4OZdJPfyOKfEe1gUxbQAWIOH13PNLWZ1DQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RmQGGOUm3wNylmVG9GE0lkWkWVVaj5GxDf9yS9U6V+XoucP8+qUhIP6AdsdL+QG7+kgSyO46rXOPWQauqt81VPKXDBWmIPv4OehRvKpPOt0m9eDPX+bJnimdX0dQSr9h48uEerWAUQQCGy4VBM9isDg0eut3wdTwzNZKdaEj8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlUMo6fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlUMo6fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390011F000FF;
	Fri, 11 Sep 2026 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135465;
	bh=foS8GLkDLgcvy8zk+1qgcqW6Zg0Nsu60j6r36hxO11s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlUMo6flgAotKF0pO9wB2JYQeTk736W35RNm6NREaJjYE8rGcSg55wD0+urnmqyCA
	 0J4E6yRDU8NXRT25jI5Dt70liCGRyx7gvb6mcwip4rdZhBVK8vy1nW586DW7FzFyDM
	 VCzwyGgB7GutXMsQfe9lloaT6z2DBuzneNeKIvr6wMx5U5glXh34MCwamntUKzMoRn
	 mXFRDymTsY38HRdKUO5tiM1H/iAIHvhK3idiybcJ8SmRLqX+nfYuDcdixRMqHVBdIv
	 rwGaOCzvDfxXSzjvM2ftVrB1ZrASYP1yXvhnaYfVxT5cw/Us0500SC7aDXdbPstZvG
	 b8DkqNa3w84tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] mm/damon/api: introduce
 DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-2-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:04:24 +0000
Message-Id: <20260911140425.390011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The docstring for damos_filter_type omits DAMOS_FILTER_TYPE_PROBE_H=
ITS_WSUM from the list of core filters in the second sentence, creating a c=
ontradiction in the documentation.
--

commit e68a3c149b1b27ea94bc8212e0cde17817f1e4cc
Author: SJ Park <sj@kernel.org>

mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM

Update DAMON kernel API to introduce new DAMOS core filter type,
PROBE_HITS_WSUM. It allows API callers to describe the DAMOS action
target regions based on their probe_hits weighted sum.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 16800b3dc379b..9e84bdeb5616d 100644
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
This isn't a bug, but should &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM be included
in this second sentence?

The first sentence explicitly excludes it from being handled by the underly=
ing
operations, but the second sentence omits it when listing the filters handl=
ed
by the core layer.=20

Could this omission in the enum damos_filter_type docstring confuse develop=
ers=20
about whether PROBE_HITS_WSUM is accounted as 'tried'?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D1
