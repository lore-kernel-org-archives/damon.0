Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F341A561
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190692; cv=none; b=FxHarfyDc63D9Y4SrP2VrrVuDFjNiNJ9r7AP1aiRnGtlZq7TCLsjP8aEgcpIjsIB0di5SzlFoHwLC4cf9ktSX0mOoGbYkhaGPzh/pgl1uyD8ew5A/MaVG/rH0PB+Ub/m8T4AHN8NcM4TgGPyz2ANjD2vYUKr4z+IS8w2K4/Z0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190692; c=relaxed/simple;
	bh=FScW0ajsS8D7AosuTqMXXj4h6Vo4HEyviBxnCGTn9kU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GrKCgMwjcXqNR/CPH8shUx/DUrauPAVGWN6i78zdkL+h8Z82wa69cNcaTZ3tFe67GdL1z73hpilU7g1NwyXIUJH0rtQ5vW2mm1hyBdJbN2LdF7alOUNAPK5GNGNyNhDqIHDWJuGzJH9YRXzgzL1zYqO9exYP7Hb7Ix9QUSENP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PamO0hN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PamO0hN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87BE1F000FF;
	Mon,  5 Oct 2026 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190690;
	bh=ttMdcdU6lrbw7ocRExqqFszt9GoQBx3Z7980J6e2TKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PamO0hN+z6zbcXSU3hD8DQhHvOskQQh9dtxSiJwI1PQF5cAFXlWv/MsY8F2GSHhbK
	 70FqUMwVw5OzTsOkxtYqzCmUI5gxFOHIxVZTzl7XUEVKeiyvlSrzPpkq/r6oqq+JSd
	 fo809qjLS4LmYHfc0tKQ8DSxxBN3ChrHyClHyL65ywOVQvxDdwHHY6OCoHIL8VMq6c
	 SVP2VA0YhzCNVJc3ABO26av/bIOhBc4dztzEa7kqGpo9GI6vOqRVc5B1+5FiHuIPkE
	 97Q30tIeIpaQ++8vfUX9sADduE7wGkG7XiEabSQA6HUkOth4AmH7+mCI7+rtKru2AZ
	 auepuKPWuOZNg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 8/9] mm/damon/core: cap the region merge
 threshold per target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-8-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-8-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:58:10 +0000
Message-Id: <20261005085810.A87BE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: integer truncation in max_thres bounds calculation
--

commit a10e8369d2fd5c44226b6327f0cddd983be70366
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/core: cap the region merge threshold per target

This commit modifies kdamond_merge_regions to cap the merge threshold for e=
ach
target individually during the regular merge pass. It also adjusts the
maximum threshold for probe-weighted contexts to ensure escalation passes
continue to run even when weighted hits exceed the normal maximum threshold.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e3c29d7cff23d..7c0df07f0a908 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -4167,12 +4167,40 @@ static noinline_for_stack void kdamond_merge_regi=
ons(struct damon_ctx *c,
>  	unsigned int nr_regions;
>  	unsigned int max_thres;
>  	bool count_age =3D true;
> +	bool use_probe_hits =3D damon_has_probe_weights(c);
> =20
>  	max_thres =3D damon_nr_samples_per_aggr(&c->attrs);
> +	/* weighted scores can exceed max_thres; threshold is max score / 10 */
> +	if (use_probe_hits)
> +		max_thres =3D max(threshold * 10, max_thres);

[Severity: Medium]
When the true maximum merge score is not a multiple of 10, does this
calculation cause max_nr_regions to be violated?

Because kdamond_fn() calculates the initial threshold by dividing
max_merge_score by 10, the remainder is discarded:

mm/damon/core.c:kdamond_fn() {
    ...
    kdamond_merge_regions(ctx, max_merge_score / 10, sz_limit);
    ...
}

When kdamond_merge_regions() attempts to restore the max_thres ceiling
via threshold * 10, it loses the remainder (e.g., a max score of 29
yields threshold 2, restoring a ceiling of 20 instead of 29).

Will the escalation loop then terminate prematurely when it reaches 20,
leaving regions with score differences up to 29 unmerged and the total
region count above the configured limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D8
