Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBD3C552D;
	Fri, 13 Mar 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773445231; cv=none; b=Rf1CsEz1DG/mOaxHK92UPXbnB13tDLOzzbN629Eq3X5bUDEb6qQlbVaVsmjgbzYw0+htWkOvzRXZfEmiYSbMbOLiYXXKG8Pq/mRCG6ysvvQwBdFNk2rmM7ffCp6DfhTnJVg9oU9DiEIOLIoGuWpRpOmlmmM86ZFnMYMO2IGwd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773445231; c=relaxed/simple;
	bh=diDZ4t93o+Rf0IOUn0/DF6Qjjum05J/e29qbsPhZkp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDMazPzygMTMSwQGbqKxuAzZtlcvmKHizCgYic4AXPpW0PARnm3oLHRLKusWotOoxe6Z1wq7yhWGIA1n6mAGwMElCHplqUxVzNpwmDaZeHrGzocXpU/3A7hOef+Jy/boWAXE3HfEMhobNGafKL2lUDO21zkRD6evrsz+kTYQnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C32twsm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C32twsm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB2C19421;
	Fri, 13 Mar 2026 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773445231;
	bh=diDZ4t93o+Rf0IOUn0/DF6Qjjum05J/e29qbsPhZkp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C32twsm7DujBauXg1gp2P4PHnRBTfRCqhPncllIb0snO1e4wxE4R1B1L6hUDjunb4
	 XnZGxadolRgl8MOApp6yycb4wCKsjGndxh51lTbLYxJJoeDRMQO02ul6pFZCFnejlV
	 NP7l/LryZ/t6PsvN+QKMMPv0417kHSVYUnAhBDLkTrGp4Amc0LijmB1S8IP2djT/ml
	 8Xn4ku0S9eJ+nvKqikSGyRejkBmbBIFFNai7TtJqcK4pZBF86SEViFe8lcuLqd0LpI
	 eAbWtEPH4oXx14NQuq9uxsqw0lq3lsqWoKz0m41tjQcgXUnQWFIPy/0zBZzXNPgSIF
	 8iJdjQe71Ai1Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/stat: monitor all System RAM resources
Date: Fri, 13 Mar 2026 16:40:22 -0700
Message-ID: <20260313234026.48872-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313044449.4038-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 21:44:47 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
> says it monitors the system's entire physical memory.  But, it is
> monitoring only the biggest System RAM resource of the system.  When
> there are multiple System RAM resources, this results in monitoring only
> an unexpectedly small fraction of the physical memory.  For example,
> suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
> 500 GiB System RAM resources in order on the physical address space.
> DAMON_STAT will monitor only the first 500 GiB System RAM.  This
> situation is particularly common on NUMA systems.
> 
> Select a physical address range that covers all System RAM areas of the
> system, to fix this issue and make it work as documented.
> 
> Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/stat.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index f9a2028483b05..3ed71db33e899 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -145,12 +145,57 @@ static int damon_stat_damon_call_fn(void *data)
>  	return 0;
>  }
>  
> +struct damon_stat_system_ram_range_walk_arg {
> +	bool walked;
> +	struct resource res;
> +};
> +
> +static int damon_stat_system_ram_walk_fn(struct resource *res, void *arg)
> +{
> +	struct damon_stat_system_ram_range_walk_arg *a = arg;
> +
> +	if (!a->walked) {
> +		a->walked = true;
> +		a->res.start = res->start;
> +	}
> +	a->res.end = res->end;
> +	return 0;
> +}
> +
> +static unsigned long damon_stat_res_to_core_addr(resource_size_t ra,
> +		unsigned long addr_unit)
> +{
> +	/*
> +	 * Use div_u64() for avoiding linking errors related with __udivdi3,
> +	 * __aeabi_uldivmod, or similar problems.  This should also improve the
> +	 * performance optimization (read div_u64() comment for the detail).
> +	 */
> +	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
> +		return div_u64(ra, addr_unit);
> +	return ra / addr_unit;
> +}
> +
> +static int damon_stat_set_monitoring_region(struct damon_target *t,
> +		unsigned long addr_unit, unsigned long min_region_sz)
> +{
> +	struct damon_addr_range addr_range;
> +	struct damon_stat_system_ram_range_walk_arg arg = {};
> +
> +	walk_system_ram_res(0, -1, &arg, damon_stat_system_ram_walk_fn);
> +	if (!arg.walked)
> +		return -EINVAL;
> +	addr_range.start = damon_stat_res_to_core_addr(
> +			arg.res.start, addr_unit);
> +	addr_range.end = damon_stat_res_to_core_addr(
> +			arg.res.end + 1, addr_unit);
> +	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);

The third argument of damon_set_regions() is the number of ranges (length of
the array passed by the second argument), so '1' should be passed.  But the
patch is passing 'addr_unit'.  It will not cause a real issue since the value
is set to '1' in this case.  But it is an obvious bug.  I will fix this in the
v2.

FYI, I found this issue from an AI code review result [1] that published on the
internet.  The review also added two more comments, but those seem irrelevant
to me, so ignoring.  I don't know who made the web site.  I only got the url
from a social.kernel.org post [2].  Whoever made the web site, thanks for the
review.

[1] https://sashiko.dev/#/patchset/20260313044449.4038-1-sj%40kernel.org
[2] https://social.kernel.org/notice/B4E8DdeZY07PseemfI


Thanks,
SJ

[...]
