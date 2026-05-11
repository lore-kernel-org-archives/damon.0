Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CDD2F8EB0;
	Mon, 11 May 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459733; cv=none; b=uy3252szhlSsoh7yAJWtmxjk8/6dz1sHlJF/eaZ3XdYPA4e6lmYtYrXPJoVzFK4qgVsO+4Ij/N6t7gFIh8OdXbkrX0dyy4h48ViG1uBh7tD9ctiij6kR1B86rGkl5daINMLLipIv0LfJlM8JIlKIrkqwS8p9ytiEbFabhUoDAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459733; c=relaxed/simple;
	bh=hhM9AGOB1FqTGF4XS1kUrjzVkjTnG35yYkXRJVptY5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIfzI8MjR1qOyV1VRGBRPsWwaqWHLysBtnS9ROyB68LXg3CGyNvbPo7tSCeJKY9jroFpoRawyEXSwbj+0TGJHQBCOsk7HDGoVTDjimKGTYUvFFv7MBn+mHC2RNpkVq2/GeRGYuiea80M9IBwSoK8drrmXDUsep0qUBOwIKvQ3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fopj/VR9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fopj/VR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF2C2BCB8;
	Mon, 11 May 2026 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778459733;
	bh=hhM9AGOB1FqTGF4XS1kUrjzVkjTnG35yYkXRJVptY5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fopj/VR9NcRqixzFA6VIBiisfD4SgFhiUyw2Z94dCIKxzISj5EpRRIWOHBfEfpL+6
	 ga12i5J0D2WhRPaSVbc4GfCx7zq+i2bilem0jk1rSOFX9+rSMKc5Cy6dCUY6JpD9VN
	 P7PJP8h90U0uUnFbC2bKjM5YgI3dNfYJ5+EEMt383S5EJYi4q8bPJZOedMlb5mBB91
	 1NKNif4USPNNil2M3ZsgGMX3AaTHWpQxi9kNPltbuPpGvmLz6+UuvB/BB0o86StFVY
	 dZtDYKqhfERYgtZJuY3n3yHQ1KEO8L9GoSyil+MN93DpsYi3HCSYRcT2gIVAtwCwps
	 qM9zJRVwFG8mg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 08/19] mm/damon/paddr: support data attributes monitoring
Date: Sun, 10 May 2026 17:35:25 -0700
Message-ID: <20260511003525.81099-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-9-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 13:52:09 -0700 SeongJae Park <sj@kernel.org> wrote:

> Implement and register damon_operations->apply_probes() callback to
> support data attributes monitoring.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/paddr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5cdcc5037cbc1..cacfbf774ca4f 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -120,6 +120,50 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
>  	return max_nr_accesses;
>  }
>  
> +static bool damon_pa_filter_pass(phys_addr_t pa, struct damon_probe *p)
> +{
> +	struct damon_filter *f;
> +	bool default_pass = true;
> +
> +	damon_for_each_filter(f, p) {
> +		bool matched = false;
> +
> +		if (f->type == DAMON_TEST_TYPE_ANON) {
> +			struct folio *folio = damon_get_folio(PHYS_PFN(pa));
> +
> +			if (folio)
> +				matched = folio_test_anon(folio);
> +		}
> +		if (matched)
> +			return f->allow;
> +		default_pass = !f->allow;
> +	}
> +	return default_pass;
> +}

This code is not respecting damon_filter->matching.  I will fix this in the
next version.


Thanks,
SJ

[...]
