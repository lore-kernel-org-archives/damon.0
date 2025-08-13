Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AB28CF47;
	Wed, 13 Aug 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104890; cv=none; b=NyYFeAUc69WcG6qBOxzUvVnr3lAinNyw8oO2u2KmXVnhUnfza63IDhxVu1DUd/jkwqhPvtNU+gFHA65ujTAqfzYJGMmBn5I0uGVrW4+Fy85MuUVYRhKwkZCUXVbLkCtqDPwoIC0bmus0HGAk00+pnRODCVBGO2YO5lYAjgLNetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104890; c=relaxed/simple;
	bh=0wMHb0ikQWLuZKUXgXzxLD9DLMSFgGq3hkc4J3eh53k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFmHQgb/WvhsxAe0/7KN6EwwW9lEvUNrD83z0wPhSYhh0kbuio8fJ29TV+gMBn5ewKbbnr4RnpqxhKZzYa+gUPRGLb2lcHgmg3sscpkvKH4tf6CSfUS7iAZ5akI4sGRG16Vsxd6yugpGGP3LylbXgFwMC2b4SAmkyyBFbNpzDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3X3gxJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3X3gxJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010EFC4CEEB;
	Wed, 13 Aug 2025 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104889;
	bh=0wMHb0ikQWLuZKUXgXzxLD9DLMSFgGq3hkc4J3eh53k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3X3gxJNG1yf8cWJ9B+2UL4wPC0Bh9O4ATYHfByAdIGQxRqHyoL8m2+CDxSFEoLNE
	 WZ51s5OrrvEvCArbvDMfmla1rxY84nGex6V4iQADi8/2Qm5GurLkcA5a3WZ3haK2Ae
	 szYA8tsootOEpcNGBI53NFt/7v5x14tCO/Umca4Mdh4fKw0kmQRC89lCeqnkM1C0yS
	 K8nvF8OqJez2HBYoS0B1gAsNzhUqRL0hdbfTM1jLW1AVwVMH/84MMa4Kb3x9szQvVg
	 V3tkZxAcXGNpw9yWT11s+6yjLIB2eOkaOF55Ixd+0fu6OD9NXHmgmN2Yidgd5kA2Cy
	 CuvQ+Q531b0Yg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 14/16] mm/damon/core: convert sz to byte units when updating state
Date: Wed, 13 Aug 2025 10:08:06 -0700
Message-Id: <20250813170806.6251-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-15-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:07:04 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> After introducing ctx->addr_unit, the unit of sz might not
> be in bytes. However, sz_applied is returned in bytes after
> processing by paddr.

This is not an intended behavior, but a bug of my code.  Let's update patches
3-6 of this series to return sz_applied as core-layer address unit, instead of
bytes.

> To maintain external consistency, sz
> is converted to byte units when updating the state.

Users could keep the consistency by multiplying the addr_unit, which they set
themselves.

> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  mm/damon/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b162aa1156fc..bc764f9dc5c5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1889,7 +1889,9 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  		r->age = 0;
>  
>  update_stat:
> -	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
> +	damos_update_stat(s,
> +			sz * (c->ops.id == DAMON_OPS_PADDR ? c->addr_unit : 1),
> +			sz_applied, sz_ops_filter_passed);
>  }
>  
>  static void damon_do_apply_schemes(struct damon_ctx *c,
> -- 
> 2.34.1


Thanks,
SJ
