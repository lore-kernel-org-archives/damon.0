Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF82F90E0;
	Sat,  9 May 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350122; cv=none; b=lekAAbdUUYQ9J3IWSa/xSb73rHJEwpJjoDzLfkbe0og/R0n4y3So37Qd3TTfJjzUBjUwDQmtEi1TdNBH0WxZUQHpx4Uaj+9Q30Ey9npHodcXSKsd3l0gL0amCYD1ccmzXVaqPt3PHl1zxiwPZx8r78KJk7x/x+QzNd7KsKwXpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350122; c=relaxed/simple;
	bh=Xue2kNTph1DeSV3TcWxLD18s+ANHdngAml/KOCEpdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7CZX6ltdgF3a8vvOGbHZzZZFfaKHLvLoq6L7OiGjSClgPmCQr8uiIwRgyMksKEvZ+AXBDuWT68HGSPqCo4z4YJsXkt4bL4uq1eBf7vNuzjErsnCC3FhDLABQfFoDiZFO/V+26Y31eHZQdChWEcogwPeIdbiotGft06BGsmZ0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1F4N4Yt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1F4N4Yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783FAC2BCB2;
	Sat,  9 May 2026 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778350122;
	bh=Xue2kNTph1DeSV3TcWxLD18s+ANHdngAml/KOCEpdGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1F4N4YtSoMiyOp/83BbhtnxXh4UyvdPh3gXp7IVv6tw2KpNQV3TLMyRbht5Yseoj
	 hRA3Sm9oBUbglj2zJjVJO3lFdOzySnQoKfWy085vV8H4frku7c4NfIqE3MQzxQEWzD
	 fh4MZpK0fbBSNo8wRs7Ey2bVfUEvrrg0VTBQx7ir6HNMCfwiZsEs1zk1RnHxZKhbT5
	 NRCrXI/j55tYRLi/wnawIZnqnxowSV238zNDmfukSjqglIZ81Jcn21Rp61Vc8iFEbl
	 +vUOI1e2XwjkchbT8qCjWBooJ3Mw1f9R6f4izaQrGwCzE5kWFF33BYyCFpz5JSG3O1
	 H+gUqKninmj9A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 08/19] mm/damon/paddr: support data attributes monitoring
Date: Sat,  9 May 2026 11:08:34 -0700
Message-ID: <20260509180835.90078-1-sj@kernel.org>
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

This code is leaking the folio.  I will add folio_put() in the next revision.

> +		if (matched)
> +			return f->allow;
> +		default_pass = !f->allow;
> +	}
> +	return default_pass;
> +}


Thanks,
SJ

[...]
