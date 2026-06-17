Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAA4071E7;
	Wed, 17 Jun 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702953; cv=none; b=ugdeQNbVqldOFKl5Goy/egKWL97V9gKINTl7bDLnZWY95NB1WOqtFQDmVWiVDGsaVKlqhvHLpG+QudX8tz9zGg/V1JUz4w8eDce+rNl3x3aYp7OkupP7JZB8tAlhY7BO2ZaDTlSl+VyH1/sT5xgsg34LOYrEs0jVkbvEHD/HDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702953; c=relaxed/simple;
	bh=ir/1trc+4tJGvhiPnHLZlm+GMPG8I3hydw+jeuoduVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syVH0l0V49iiXN8L/MCelMzicsUQ0Wf2MrkUmv40sEj1JwBnGu+ZSUv3JyVHCNP1eKmYXqseBLJ+lHHzzZHvz3jg7jAZ8pvCFksFTYQtRW3Tar5J4CF8txl3wsucVsp/MO3NvpimmSx9r2PLkVkDSXpfZy1lDqYdTwLnt84CgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0gIQOFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0gIQOFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE71F000E9;
	Wed, 17 Jun 2026 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702952;
	bh=l29ap0z+NgMk8b+loIJRvuRDcMjGDora34vzEfwkZDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f0gIQOFMBUe+cOrnPkfiSwdUdEN6vKwZoQuduMKyl/xeoyPjsMwkmfxMRLUyGpSYs
	 Q/pUDgV45Caa+TYJ57HL4o8CYCrVp54Wzvf1tWt2ymQKURot97o8L/4zRm5DMlw3D2
	 7YmHfvMBirwVUvKGqOYjRsdTdM/gEQQESSD5RRzK3LN2lY83F36IEm7qCeEA81PF7g
	 5QhLfx/Kk2loy/Kj1ognJwlNNRArKrB6TeKgHOwqLuCxKJfyGqiew4ERywaWQQEmZV
	 I4WwZxfCkIZ+AbUn/i2way5rcQA/1oA5DJ/ZXkgD9NLKeyGVEI1APnA04n/v03br0I
	 oTrlt3g6hsjFQ==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] samples/damon: Fix typo in Kconfig help text
Date: Wed, 17 Jun 2026 06:28:59 -0700
Message-ID: <20260617132900.83880-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617065716.750179-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jun 2026 06:57:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Fix a typo in samples/damon/Kconfig help text. Change
> "Thps" to "This".

Nice catch and fix, thank you!

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are currently in the merge
window.  Andrew might be busy for PR work.  Unless this patch is urgent, Andrew
might not able to add this patch to mm.git until next -rc1 release.  In the
case, I will request adding this after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really  urgent.

> ---
>  samples/damon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
> index cbf96fd8a8bf..182a59722879 100644
> --- a/samples/damon/Kconfig
> +++ b/samples/damon/Kconfig
> @@ -31,7 +31,7 @@ config SAMPLE_DAMON_MTIER
>  	bool "DAMON sample module for memory tiering"
>  	depends on DAMON && DAMON_PADDR
>  	help
> -	  Thps builds DAMON sample module for memory tierign.
> +	  This builds DAMON sample module for memory tierign.

'tierign' stood out.  I will fix it together on your patch, if you don't mind.
Let me know if you mind.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
