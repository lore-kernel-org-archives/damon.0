Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB694338F3F;
	Thu, 21 Aug 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797602; cv=none; b=EU0ixJEhy4j8O06om9GOBsZU/ngp7k8QTE+bNgkOZpLtW8a2OgeiqJ8vVwNuWkx4OjoFxIOg107jRHE+p31ZD9JTY2X3s5DFcEtNzj8HKxJTtgyVjzRlqrnz9tfZR8c6RzMP7FH9wiRgsO0X4MkJJw2DbOqxWDo7EvxjJsIOTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797602; c=relaxed/simple;
	bh=qIgwyDLs7gXuHaRh+NCslEDZeervdmckUOO3x2JXbFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtTbYSUcBmCLHorkAX/PVld/zYgcSyTRGcvsQGQomt4ENjnVAVJ1vXqol/y0nSqEAoubJrf8wIOA4Q9h6+OzA8JGvkQl3Re4S773U7Pe1sxPfujzhkO5jMDu1KD1sjPtR6ZSjCtYvjvkA45ouQBGMdCfrSfDtrOI7B6cC2Wt2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl1831ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl1831ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3E0C4AF0B;
	Thu, 21 Aug 2025 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797602;
	bh=qIgwyDLs7gXuHaRh+NCslEDZeervdmckUOO3x2JXbFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zl1831majxb7E4/n3F4VP0brhAGKevHYa8BJcRbodNOLWrVwuH3GQIpfLsEuHBCVT
	 QEHUC/RNpCmHK0ckETrFIWxler9iTsDxYSxtLtugrYs4y/2wRmwRJfOTA2kRqpxI/1
	 u44ZKfbvmqkFYJNaOmFoOtJs37x+DjFn/XgN6QTgC/cHVwEt0t2OSacaiUNdkConRV
	 4q2WnQ7659nxfLTd0U58Kf5r13oQxaE2fZOXG2tdyJA0j+ZfjfASeH5rpZKM5ZOX/x
	 XuPIz+65Xl1abjTNSyoST5b4x+h5R9T+PpyVvS+RLASPOdENxe1/Qfa7zyjQREO4Qw
	 8Km5sXbhcJj9w==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 11/11] mm/damon: add damon_ctx->min_region
Date: Thu, 21 Aug 2025 10:33:20 -0700
Message-Id: <20250821173320.82616-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-12-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:59 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
> bytes and cause data alignment issues[1].
> 
> Add damon_ctx->min_region to change DAMON_MIN_REGION from a global

s/min_region/min_sz_region/ ?

> macro value to per-context variable.
> 
> [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com
> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  include/linux/damon.h        |  4 ++-
>  mm/damon/core.c              | 67 ++++++++++++++++++++----------------
>  mm/damon/sysfs.c             |  8 +++--
>  mm/damon/tests/core-kunit.h  | 21 ++++++-----
>  mm/damon/tests/vaddr-kunit.h |  2 +-
>  mm/damon/vaddr.c             |  2 +-
>  6 files changed, 61 insertions(+), 43 deletions(-)
[...]
> @@ -1248,6 +1253,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>  	}
>  	dst->ops = src->ops;
>  	dst->addr_unit = src->addr_unit;
> +	dst->min_sz_region = max(DAMON_MIN_REGION / src->addr_unit, 1);

Can't we set this as src->min_sz_region?

I asked a same question[1] to the previous version but seems it was missed.

[...]

Other parts look good to me.

[1] https://lore.kernel.org/20250820215612.86678-1-sj@kernel.org


Thanks,
SJ
