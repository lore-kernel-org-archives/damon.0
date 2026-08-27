Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E25286D5D
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805950; cv=none; b=sz19oozkuypH2P/gZWbuGSNp2wAjQhAbrGh9qiMdGQQs5YRUIou4eK/buTXdqDdtuHjbpPxx41UG2TOfCSQae7un1ay8KYAGXhotPJ0F24AbGpSP+cXDvMEhsE66vjfFUDI15YoUqP3J75/JaYGnocRa3etIyQZX8WDwn2Jnm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805950; c=relaxed/simple;
	bh=nEL9oTZUheXtw7xsncQOoX64LCY+HZn87Wr9ASzY7BU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eU7Ah+ay84mT+1wTK32dNRHprph0NWM1/Yttoghf4tdGcJ9p+7I1k5DqFRUt/SXiKml0LLgnWjyg5Rum/bF7ktprc9zvc5HsPiGbBniOnUf7cKEfwOOiUGB+Kxu4v0rDULLHetrBIr/sfi4/KfEiXpkGII//OXPf2SQASBww2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fys9i/Ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fys9i/Ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E8B1F000E9;
	Thu, 27 Aug 2026 04:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805948;
	bh=1J1j0HvK3gQIP/fqZ+TJIcoPYPmaV0rS5t47rsg4cI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fys9i/Ac9HUBUL3aJOon0Px6a4qKj62PQiU4D0NpTnlRrtPLAlp/tBC+pubPeiVha
	 6SHjvMPWu8tkdlZOtP1YU1QmYMecxH0A6yPr7k1D3mvU94UxcJrUUFhqfti80p+9ay
	 c8soADjAMF2JbrJa3vV54qr+2wDmK3WeJ7q/sDOBY9B14i9BCA7kXe15gh7w1M9ABe
	 wDsVI/aJ70NY9NLOdpRoaNKAWg8YH1Ek5yV0oncatrmHu/ox5wwcLCYHv3zfZ2spKY
	 maO5uMdHMxTzLQNWvsKoJd4BM4ikKrZEI463p1jxUGXNaEXKdJnXIAWQyv8KY/UuA3
	 HR4+HpVO7Ejkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: initialize
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827042920.93580-2-sj@kernel.org>
References: <20260827042920.93580-1-sj@kernel.org>
 <20260827042920.93580-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 04:45:47 +0000
Message-Id: <20260827044548.65E8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Implicit declaration of function 'damos_get_some_mem_psi_total' cau=
ses a compilation error.

Pre-existing issues:
- [High] The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric's 'nid' field is not c=
opied when committing a quota goal parameter update, leading to an uninitia=
lized node ID being used for eligible memory queries.
--

commit 9597a197ecbd4f36e4fa8dfa9bd1bdbb5a5f1d93
Author: SJ Park <sj@kernel.org>

mm/damon/core: initialize damos_quota_goal->last_psi_total

Initializes the last_psi_total field at the beginning of kdamond and during
each commit for SOME_MEM_PSI_US type quota goals. This prevents unexpected
adjustments during the first iteration of the feedback loop.

Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..6f360d61390ad 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1122,6 +1122,9 @@ static void damos_commit_quota_goal_union(
>  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
>  {
>  	switch (dst->metric) {
> +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +		dst->last_psi_total =3D damos_get_some_mem_psi_total();

[Severity: Low]
Does this cause a compilation error due to an implicit function declaration?

The function damos_get_some_mem_psi_total() is called here, but it appears
to be defined later in mm/damon/core.c without a prior forward declaration.

> +		break;
>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		dst->nid =3D src->nid;

[Severity: High]
This is a pre-existing issue, but does this switch statement omit the
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric?

When a user configures a DAMOS quota goal using the
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric via sysfs, a new quota goal is
allocated in damos_new_quota_goal() via kmalloc_obj(), where the memory is
not zeroed.=20

Because DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP is missing from the switch stateme=
nt
in damos_commit_quota_goal_union(), its nid field is not copied over during
parameter updates. This leaves the node ID uninitialized and potentially
causes eligible memory queries to evaluate using garbage data, completely
breaking the metric's functionality.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827042920.9358=
0-1-sj@kernel.org?part=3D1
