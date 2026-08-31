Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E3235E92B
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201715; cv=none; b=JvnlURpYfYgexLTjv3JuOATOgJqK5+uMH5tE9wbZJ7SyuWXAsgQthAQ6kG84rqLUFK1Iv12+Cx08WrH4rbSfzA/PtFvYgNHm4oTr6WMfx7+zkWqeT2KopWCqp31viBy9xywGeI/REaQYgmkAq+seXCPLnvhOjlStwUU4bOXZAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201715; c=relaxed/simple;
	bh=hS2Z7I7LNDkdQalaQjuKxEM93IMCiyQieYAZ3HknE2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jwXJw2+P6JojyWmx0KJC0N4OSkt0NfhHxrchmpjATLJRs3+E6fz6aObwVvuguioiLSC7sw/F1ZFa46QAwxFQgqSabOzWmlLq8OxqTB10LoqepR6ejcoeSYs2BlYiz8/iomOS8w4FgrmrQmRsojNwXInqa+xxU7LtW9S6kKpGUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx8TilI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx8TilI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330251F000E9;
	Mon, 31 Aug 2026 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201713;
	bh=U8EZqC87DsT20SUiI5PzFpPlk8/EpFVH1C3W099Qv34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kx8TilI3xZN7O4C9kzoct5x0gESF1ojw13oDa4vJfP9YLgKSRbD5jbpBc6zT1wl36
	 U77bByfozuScWVrP+q+j+PWZUs+rIDjE0tFhR6Ctm1B1TewJz+RHLylJ6M64JJ6OhN
	 /YnxaDK8f+T1ve7gUeb56jhBFrPv1dhkkGODbbcSduYJ3gRtog94FtvK0LNZobsECa
	 73qP0JFHjHUlLmCj1k2mMGxylYbMVJv218XMT4PVKmL/0vJslziK+s8RYG4fGknQJ4
	 eICKl+CGNfNtLsYLf7Q/5BeTMTtyAjOoDrI/JkKZmL0pC5YpBIXASk68Wi2bOfzbXJ
	 Qbji+NL+e/cuw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 7/8] mm/damon/core: handle extreme memory state
 in get_node_memcg_used_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-8-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:41:52 +0000
Message-Id: <20260831184153.330251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect fallback values in `damos_get_node_mem_bp` when `i.freer=
am` exceeds `i.totalram`.
--

commit a048cc23be81d8e450e9ee2ce22eb0a86b0cb1ba
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()

This commit handles extreme corner cases where total memory is zero or
reported used memory exceeds total memory. It updates
damos_get_node_memcg_used_bp() to prevent division by zero or underflows by
clamping the results to 100% or 0% appropriately.

Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 75d71ac09515e..3779a04753061 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2863,6 +2863,12 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	mem_cgroup_put(memcg);
> =20
>  	si_meminfo_node(&i, goal->nid);
> +	if (!i.totalram || i.totalram < used_pages) {
> +		if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +			return 10000;
> +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +			return 0;
> +	}

[Severity: High]
This is a pre-existing issue, but I noticed a similar block of code just
above this in damos_get_node_mem_bp() that appears to handle the fallback
logic incorrectly:

mm/damon/core.c:damos_get_node_mem_bp() {
    ...
    si_meminfo_node(&i, goal->nid);
    if (!i.totalram || i.totalram < i.freeram) {
        if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP)
            return 10000;
        else    /* DAMOS_QUOTA_NODE_MEM_FREE_BP */
            return 0;
    }
    ...
}

When i.freeram exceeds i.totalram (which can happen due to per-CPU stat dri=
ft
during large frees or memory hot-remove), this logic returns 10000 (100%) f=
or
DAMOS_QUOTA_NODE_MEM_USED_BP and 0 for DAMOS_QUOTA_NODE_MEM_FREE_BP.

Since the node is effectively completely free, shouldn't it return 0 for us=
ed
and 10000 for free?

Could this cause DAMON memory reclaim schemes to trigger aggressively on
nodes that are actually completely free, potentially causing performance
regressions?

>  	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEMCG_USED_BP)
>  		numerator =3D used_pages;
>  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D7
