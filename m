Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83C298CA6;
	Fri, 17 Oct 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718514; cv=none; b=GsOk1IpuIjN62nHooTtEqcjaIR2qrwsKwzx2U4coHPacM4/A9EjvrSDHI8iX6agvyj1Oa2Hl/eAgfPpybff6e42LE87GfZRtlZWaZHITYTlVhsytkTvDcSgWzD4IzG93CWzmCKOyrEIvn5h8yyENCPi7XZ053R4NxQI0ztLX7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718514; c=relaxed/simple;
	bh=y6vYbALsJkMlFJydwFebCPjCAMuCiquwR51ZP9B99Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HklE6hlWQSKZdgdjAOytcWEnPOAlhkVg551VRlqdiErr3csRHijSN14zMMXv4cuKvTZg2d0/bjo/6vm8Sz92H0eqaRi0cqOTs079eJ/BBvJ5osNrNiGsat3grJPmiSyWeblDnVB2/E/TIYRPEZf9tUSZvuZ05viehmX66pSHiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvib35gR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvib35gR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D86C4CEE7;
	Fri, 17 Oct 2025 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718513;
	bh=y6vYbALsJkMlFJydwFebCPjCAMuCiquwR51ZP9B99Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvib35gR53GA95T0WTt9rTSAbf8JRkzineRX9qYxrL0MAZE+MbO5z2EXazWk4zd0E
	 2X5u+UvXa6WaJFaRocHXa4iaq7BRw2i+XYLLwSAEatPT9e1r6g9LNGlIc+qJXq7ASH
	 /TVIPLRKcWPc9/1VK1Tj5mR9hCqJutjQBBfVVzubKfr5HHYmVMlOy4gEfGIpNxrztL
	 hnPwIAhuOeggTsP1KQKhG6S5dHWC56rfxc+SXJUWx+dBlq9csN5Ph6M3wFXrYXYdRc
	 0hGgvHgKQDmqEkdYK3s/aARELIJ+jckxlkIg1NGZs8pr/BSkY/hG2RzdcCgVijcG60
	 mlvcBx8ywGjMw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH] mm/damon: add a min_sz_region parameter to damon_set_region_biggest_system_ram_default()
Date: Fri, 17 Oct 2025 09:28:28 -0700
Message-ID: <20251017162831.116160-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4c2e5879-e554-49c0-8f05-094031cbb64a@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Oct 2025 11:12:00 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Hi SJ,
> 
> 在 2025/10/17 3:48, SeongJae Park 写道:
> > On Thu, 16 Oct 2025 18:47:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >
> >> After adding addr_unit support for DAMON_LRU_SORT and DAMON_RECLAIM,
> >> the related region setup now requires alignment based on min_sz_region.
> >>
> >> Add min_sz_region to damon_set_region_biggest_system_ram_default()
> >> and use it when calling damon_set_regions(), replacing the previously
> >> hardcoded DAMON_MIN_REGION.
> > Can we add more detailed description of the end user issue on the commit
> > message?  My understanding of the issue is that the monitoring target address
> > ranges for DAMON_LRU_SORT and DAMON_RECLAIM would be aligned on
> > DAMON_MIN_REGION * addr_unit.
> >
> > For example, if user sets the monitoring target address range as [4, 8) and
> > addr_unit as 1024, the aimed monitoring target address range is [4 KiB, 8 KiB).
> > But damon_set_regions() will apply DAMON_MIN_REGION as the core address
> > alignment.  Assuming DAMON_MIN_REGION is 4096, so resulting target address
> > range will be [0, 4096) in the DAMON core layer address system, and [0, 4 MiB)
> > in the physical address space.
> >
> > So the end user effect is that DAMON_LRU_SORT and DAMON_RECLAIM could work for
> > unexpectedly large physical address ranges, when they 1) set addr_unit to a
> > value larger than 1, and 2) set the monitoring target address range as not
> > aligned in 4096*addr_unit.
> >
> > Let me know if I'm misunderstanding something.
> >
> > Also, if you encountered the issue in a real or a realistic use case, adding
> > that on the commit message together would be very helpful.
> 
> Thank you for the additional explanation! Your understanding and description of
> the issue are entirely correct.
> 
> Our ultimate goal is to have the monitoring target address range aligned to
> DAMON_MIN_REGION. In the original logic, however, damon_set_regions() did not
> take the newly introduced addr_unit into account, and directly performed core
> address alignment based only on DAMON_MIN_REGION. As a result, the monitoring
> target address range was aligned to DAMON_MIN_REGION * addr_unit, causing
> DAMON_LRU_SORT and DAMON_RECLAIM to potentially operate on incorrect physical
> address ranges. Therefore, we need to use min_sz_region instead of
> DAMON_MIN_REGION in damon_set_regions().

Thank you for confirming!

> 
> I will add the detailed commit description in the v2 patch.

Looking forward to the v2!

> 
> >> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> >> Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
> > Let's break this patch into two patches, so that we have one fix per broken
> > commit.
> 
> Yes, I actually considered splitting it up before submitting this patch, but found that
> doing so might make the patches look odd. Since we're modifying the input parameters
> of damon_set_region_biggest_system_ram_default(), all the call sites of this function
> need to be updated accordingly. It seems we might need to split this into three patches:
> 1. Preparation patch: Add the min_sz_region parameter to
>     damon_set_region_biggest_system_ram_default(), passing ctx->min_sz_region in stat.c,
>     and passing DAMON_MIN_REGION when calling this function in reclaim.c/lru_sort.c?
> 2. Fixes patch 1: Modify lru_sort.c to pass param_ctx->min_sz_region.
> 3. Fixes patch 2: Modify reclaim.c to pass param_ctx->min_sz_region.
> 
> I'm not entirely comfortable with this approach. Would it be acceptable to submit this
> as a single patch?

I think you can merge the first and the second patch into one single patch,
resulting in two patches each fixing the issue on DAMON_LRU_SORT and
DAMON_RECLAIM in the order.  It doesn't look odd to me.


Thanks,
SJ

[...]
