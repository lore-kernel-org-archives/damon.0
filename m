Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00153F9FB
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027015; cv=none; b=CRBuXbH0p5evfa0g1TSZHXMe3kGjMwQvtIJLjT8SCOmJRg/B6jM+oGwb/ZAuQPsoZ5vpmhKAiFT4To6Y82r8FmLwvlxLL9G96hUYAB2vxfCuxaptgfI1d0vxQ9m7hLkxq90byWjzgAnnGlcU9f3VJT1P6w/xGtcib8gYOo8d3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027015; c=relaxed/simple;
	bh=BW1DjHtjmwU0CMTZ0f7M8zSYe+IGUOmEJYC6wNr5Dus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A9voD2tyNaFKlYHcFbwgnNcr7nlqwT446Ywh9uX+fuIq2Jy0iYkbuh3YhEYxz+tnZEnc93zI9SH5+QQVo3/q5+DfiZMYSTKot+lKyffmV20CBuca+OtSbUQav3B8aWOU9RFz+f0oFdZV8d7LCFKnZANTCmbbrnrG8v/FtVgCTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1snfCiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1snfCiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17B51F000E9;
	Thu,  2 Jul 2026 21:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027013;
	bh=u5Y28qNQfcl/uDYcK29yBNr+GNX89b8QiQVDC5kTn2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1snfCiRzwM78q6Qc1gaV5SqB3VPyb9cBW+umaKZMSe5DQ4KkCVaOvryrg5dcsOgi
	 cfxnUsyn6hGKIpZ5GEZSmfxTVD26eW2SBTtOjCQ6Y1uEfLYyGk8ZNsPrsVedXUaCa/
	 kTPTpmGHMKBpFlYd3f3K1YqRs4sb58CjlK78usq4hwQCFGIlU0lVU+Ksc8/ERVc5Ac
	 43R1hLJrIefkVdVDgNHOTpEgfarottal3/SiZO44ZNeMMiYfI+qmgsWcLTxQ+K1xHM
	 IS8CyZbwov6O0COpOzS+NN3VsUzEwTcPFDVeaAT3cP1ZuDuYnpb39N2zyMxMfmm66O
	 M26btyhek5E/Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 7/8] mm/damon/core: remove start, end check in
 damon_set_region_system_rams()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702210551.95167-8-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
 <20260702210551.95167-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:16:52 +0000
Message-Id: <20260702211652.A17B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the explicit `*start > *end` check introduces inconsist=
ent input validation, allowing inverted or zero-size ranges to be silently =
accepted.
--

commit ad7c7a8a7766992d5ad4dbe1c23874e807f45071
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove start, end check in damon_set_region_system_rams()

damon_set_region_system_rams() validates user inputs to avoid creating a
negative size region.  But DAMON core avoids zero size, too.  The check
is incomplete.  The complete check is done inside damon_set_regions(),
which is eventually called from damon_set_region_system_rams_default().
Drop the incomplete and unnecessary check.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 179ce6b0a542d..dba53a41a1025 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3812,9 +3812,6 @@ int damon_set_region_system_rams_default(struct dam=
on_target *t,
>  {
>  	struct damon_addr_range addr_range;
> =20
> -	if (*start > *end)
> -		return -EINVAL;
> -

[Severity: Medium]
Does removing this check allow invalid inverted or zero-size unaligned boun=
ds
to be silently accepted?

The commit message claims that a complete check is done inside
damon_set_regions(). However, looking at damon_set_regions(), the validation
acts on aligned values:

mm/damon/core.c:damon_set_regions() {
    ...
	for (i =3D 0; i < nr_ranges; i++) {
		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=3D
				ALIGN(ranges[i].end, min_region_sz))
			return -EINVAL;
	}
    ...
}

If unaligned invalid bounds are passed (for example, start=3D4095 and end=
=3D20,
or start=3D20 and end=3D20), they are rounded to valid blocks (e.g., 0 to 4=
096)
by ALIGN_DOWN and ALIGN.

Because they evaluate to a valid positive range after alignment, they escape
the >=3D check and are silently accepted.

Should this explicit check be kept to ensure unaligned invalid bounds are
correctly rejected before alignment?

>  	if (!*start && !*end &&
>  		!damon_find_system_rams_range(start, end, addr_unit))
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702210551.9516=
7-1-sj@kernel.org?part=3D7
