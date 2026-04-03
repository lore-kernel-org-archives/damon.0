Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF83845B5;
	Fri,  3 Apr 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233148; cv=none; b=CrtSJUs7NcANWxHT4yLuvQeAiRTCCzpl3V2ZZlhhFbZhDQcrtIDtW/cN5Jp1ML/Ti4UZBBGKiRESKgFxvSgLQLhTwZIsjc0dK7Mrv0tzPVghb48GqMKtPK/paDa0uqL2lUt1MREEsuzljkcu7qA6uLHBsNr9rw1iNX/HqDsvUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233148; c=relaxed/simple;
	bh=7zNWqrKWKBGHhtfMs4MAPonKRcJZcjaQjimH+qICKwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teQtOXn6HRsSWDRBRo2S4ppvs93ZWAK77+OeRzAelMKfBWXcgCMNepxvSoQUhO/hOU3JyGyXG8HCTcl9IgnplkvyekqCS7l7lztE/KHhkKx3SJ9alLZ46IAPouGTKESctS6n0emnYjrvu5Bf0zb9rHqTATc7k9tLFYSUju/dCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gElMBkaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gElMBkaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25748C4CEF7;
	Fri,  3 Apr 2026 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233148;
	bh=7zNWqrKWKBGHhtfMs4MAPonKRcJZcjaQjimH+qICKwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gElMBkaZhsPp2UQD5QMhiSn6Gi1LPsK7W5mjeWHtrWDbbuWe/vzrR2H7suSKrSSxE
	 yVTIKTnEodC+Fjb5DcS9YA+YgcjSQ7PdoAcFzUpHJu7z4IKApte6IXAL+eBQnAlqDL
	 dbUDB7i7YNZadu1LkjrQTtoS9vi9gvZvlptx5XDJSZ3MIcVXXhdhuuV0I8Ow3TX+K0
	 AOscofgmFB1h6N54lzj+7hrUifWij/dPRQgH1xk+gL9RPohd0jYjUEEHOBAsxgswms
	 iwTloVCgj1rZDBqk4tWxGI8OV4TPIWDo64W6QJNYceZ7M3+io3VtGuMkzHnL4seJ+4
	 7cm0rwp5B19lA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 09:19:06 -0700
Message-ID: <20260403161906.65008-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403052837.58063-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  3 Apr 2026 13:23:49 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> However, if an invalid input is provided via the DAMON_LRU_SORT
> interface, the validation failure occurs too late, causing kdamond to
> terminate unexpectedly.

As Quanmin also asked, clarifying the unexpected termination would be nice.

> 
> To reproduce:
> 1. Enable DAMON_LRU_SORT.
> 2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
>    'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
>    non-power-of-2.
> 3. Commit parameters, and observe kdamond termination.
> 
> This patch adds an early check in damon_lru_sort_apply_parameters() to
> validate 'min_region_sz' and return -EINVAL immediately if it is not
> a power-of-2, preventing unexpected kdamond termination.
> 
> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> Cc: <stable@vger.kernel.org> # 6.18.x

I remember I suggested adding stable@, but only if you think it deserve.  I'm
now not very sure if this deserves Cc-ing stable@.  As I mentioned before,
there are multiple patches to review in parallel (you are also having such
multiple patches in the queue).  Please don't expect I will follow full
contexts especially when a single person posting multiple patches in parallel
every day or two, and bear in mind with me.

Sorry about the limited bandwidth from my side.  You could also simply slow
down your pace, though.

For stable@ Cc-ing patches, more clearly describing the user impact would be
nice, and helpful for judging if it deserves that.  Could you please elaborate?

> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
>  mm/damon/lru_sort.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..3fd176ef9d9c 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err = -EINVAL;
>  		goto out;

Code change looks good to me.


Thanks,
SJ

[...]
