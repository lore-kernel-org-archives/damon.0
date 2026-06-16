Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFA43E4BC
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623218; cv=none; b=SKfoo16Y1QqIR3r40bbB66fGg//iCS3JzTsY4ANWxyyWCtluuPCFTqL4Yy5sfIcawHOlSgAVJ+OvfADRC+pqiiRmGQ41M+IqKKxtQqNKic6r8akoKzzt3HtWVS+8DfFVUcYqqI7NZOR0jfiSiB8n8btqjb5DiQOxJ3fCm4zJq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623218; c=relaxed/simple;
	bh=3+KDCoF8huNU9SXpVue7AjThtdcEk05204NFXgv4SfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8vhJvqVAUafb+ld6w2VUYj1qMIbGLSDm9GnfFQeQeHj6zdAqKXVAViW+7X0C1xnxzEtWka3ejIjkhjtYOM29IrbGq0duv1Rz7LHILIk1RsyKw9soyxdcV7gyjK3V7F1jIagVuve3vxRXIGKjxVK0KyG7SXbUNgzUSOmBDPHh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcO8/lM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcO8/lM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E1C1F00A3A;
	Tue, 16 Jun 2026 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623217;
	bh=RTnZqUoXZIgVHOdGLi4/0DRuxm8vxQFhHgVz0h59fbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcO8/lM7mnWiJZ98MdmbM7ENHXQ1HvD3nHE3N7Q0oU+ZvVmTeaQSTdkSQg+br1aNf
	 6p+cMSZaKiuudMLzv7O6nm19r03ecF5Jr/4DQEUu+oRFZ+M6K0qJ6eTXC7O81TZswF
	 GTzvFLVP/T8c3v9qGa/VxEaLO+Bg9Vwcmi3J2vDB454sunm/MxYSz/45ExohQiDeUi
	 d0xHRgsTAAAaiMyNlf7vcVzCzkxCGQe06KenA6K4uExnGbvrIHVv+WrtW3W9MfU+pr
	 8iCsWy4PbN26Y+Zg98daZwu/PgWkq9nb9ccFYEIHOXYgkhkLqhgaAl0F1jB4gNJ7Ok
	 JL+1jRuxaLxjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150316.580819-2-gutierrez.asier@huawei-partners.com>
References: <20260616150316.580819-2-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:20:16 +0000
Message-Id: <20260616152017.29E1C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `mult_frac(thp, 10000, total)` macro call silently overflows `=
unsigned long` on 32-bit architectures, yielding incorrect DAMOS quota metr=
ics.

Pre-existing issues:
- [Critical] The `damos_get_in_active_mem_bp()` function can trigger a divi=
de-by-zero exception if there are no active and inactive LRU pages.
--

commit 812a9d3523a15be0a409c86d1076f2098e299808
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

This commit introduces a new DAMOS quota goal metric to measure the amount
of huge page consumption to total memory consumption ratio.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b001f80681b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(boo=
l active_ratio)
>  	return mult_frac(inactive, 10000, total);

[Severity: Critical]
This is a pre-existing issue, but can this divide by zero if there are no
active and inactive LRU pages?

If a system has no active or inactive anonymous/file LRU pages (for example,
immediately after early boot before userspace populates the LRU), total
evaluates to exactly 0. The mult_frac macro performs division by total,
which would trigger a divide-by-zero hardware exception.

>  }
> =20
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp =3D global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> +	return mult_frac(thp, 10000, total);

[Severity: High]
Does this calculation silently overflow unsigned long on 32-bit
architectures?

The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Because
thp is always less than or equal to total, thp / total evaluates to 0,
leaving (thp * 10000) / total.

Both thp and 10000 evaluate as 32-bit unsigned long on 32-bit systems, so
the intermediate multiplication thp * 10000 will wrap around if thp exceeds
roughly 1.75 GB (429,496 pages). This would cause the metric to under-report
hugepage usage.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150316.5808=
19-1-gutierrez.asier@huawei-partners.com?part=3D1
