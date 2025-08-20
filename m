Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59C22579E;
	Wed, 20 Aug 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728585; cv=none; b=GBo8oNAlCSVhKRKZNDJwZLHsJUSZuIkjmSOIBrjvfkUYLTZZU1fqbQTOUMsgfgPw+fd4OtCOrdPNxQvd7xR34hREvbvYsrMVfa/6Em3fdy3edBQFGsyw1XwC3IvjF1BrQ8ZjSV94u5/epANGN9AlZKfoxE4P4gCEbw5N+BfwmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728585; c=relaxed/simple;
	bh=0Hc+hko8FrAVekC8D7wSPp0TYD0KKnzwUrEEEtQlhss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDOyyeYWDNzV2qtCtOpJzSqI5Ve6d0s11KEXN3sHx5IYoUQzEeSczSEl8dBIk/ckPosOou+JFzO/02hwxdCpI1sN0XHDo7QwPn73OjuIqRiP1lVlUpF5uRHeoWJNCXxQjwp5ZIk+30JXrMQrgIqCT8PMUhDpDGNAANttM/5jKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udK2mbzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udK2mbzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C15DC4CEED;
	Wed, 20 Aug 2025 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728585;
	bh=0Hc+hko8FrAVekC8D7wSPp0TYD0KKnzwUrEEEtQlhss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udK2mbzAU+s690sSPA6XyE6lYsAdDFYHRihpYv1DVf0JRR9xVx5w8fsm0tuMskO/E
	 HKA1KLmxnYLKX1h3fLRGekAuL3qGChKObdbmBv3+tGXf3BSwC0grnEuyWVPdEz+6CW
	 YcleCkwqNssHpsbJpyfDKX3E9p/tEtFflJQlkj7mcY6GGVF3D7E5wRHV9f1FBJPVEF
	 /n4/iXFInEnYS8weecgEFBSruLLmYTkCavSgdUcj3pXHbeCSGm5IqZ6BQF+qbcc2Ky
	 XgvgiieJ01HlBslka2sY/OCzDoA3PNE16qxbEM4gQcnG0ntz4q23O8uR5DbgKXw+GF
	 c5zGm1wTdxgpw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH mm-next v2 00/12] mm/damon: support ARM32 with LPAE
Date: Wed, 20 Aug 2025 15:23:02 -0700
Message-Id: <20250820222302.88000-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250820080623.3799131-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 16:06:10 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Previously, DAMON's physical address space monitoring only supported
> memory ranges below 4GB on LPAE-enabled systems. This was due to
> the use of 'unsigned long' in 'struct damon_addr_range', which is
> 32-bit on ARM32 even with LPAE enabled[1].
> 
> To add DAMON support for ARM32 with LPAE enabled, a new core layer
> parameter called 'addr_unit' was introduced[2]. Operations set layer
> can translate a core layer address to the real address by multiplying
> the parameter value to the core layer address. Support of the parameter
> is up to each operations layer implementation, though. For example,
> operations set implementations for virtual address space can simply
> ignore the parameter. Add the support on paddr, which is the DAMON
> operations set implementation for the physical address space, as we have
> a clear use case for that.
> 
> [1]https://lore.kernel.org/all/20250408075553.959388-1-zuoze1@huawei.com/
> [2]https://lore.kernel.org/all/20250416042551.158131-1-sj@kernel.org/
> 
> Changes in v2:

It would be nice if you can also add the link to the previous version, e.g.,
like the revisions history of
https://lore.kernel.org/20250819193404.46680-1-sj@kernel.org

> - set DAMOS_PAGEOUT, DAMOS_LRU_[DE]PRIO, DAMOS_MIGRATE_{HOT,COLD} and
>   DAMOS_STAT stat in core address unit.
> - pass ctx->min_region value to replace the original synchronization.
> - drop the DAMOS stats type changes, keep them as 'unsigned long' type.
> - separate add addr_unit support for DAMON_RECLAIM and LRU_SORT from
>   this patch series.

Thank you for continuing this work!

> 
> Quanmin Yan (2):
>   mm/damon: add damon_ctx->min_region
>   mm/damon/core: prevent unnecessary overflow in
>     damos_set_effective_quota()

I left a few comments.  In essense, let's rename min_region to min_sz_region,
and separate the last fix from this series.

Other than above, looks good overall.  I think you can drop RFC tag from the
next version.


Thanks,
SJ

[...]
