Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD053A1B6;
	Mon, 13 Jan 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803539; cv=none; b=dYVd2NfDaV+yDeQix+8jjb4boA77Am9TxUUT6/L1D1y6D0FrKDwFfFvY1rHM75HVp6qv2Nqp15ley0iwaJ0CU0Q557Rk1SdXMMqzVCkahJhjWAliDgpsrUwkBwUr3HlkBvbo5u6WNu9sZ4/kDiDxHXQJrC4uu2Xv46nh2oKrGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803539; c=relaxed/simple;
	bh=ubXq+bjMwy/AYRabDRJS7yunE1IcP6TJwdZJgnNCBlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hw/v1jc6rfdnH1DyKbZuhZPmU5h5+j2v+ZAp/1gxkl1+U07M0imvEB01xtUY2GFJzKbLssGf01Ax/opa+TuIiB3QgMQHD2L0Ju2q0cvMFgvXMUPSZZiC9R3V71wZxB+00XjnkHc2S1aik7Xicn1vCbwPKG/IOM0acnBgHTG47r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkP8ghZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkP8ghZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB78C4CED6;
	Mon, 13 Jan 2025 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736803538;
	bh=ubXq+bjMwy/AYRabDRJS7yunE1IcP6TJwdZJgnNCBlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkP8ghZkVjbg0T/f+TLgWMOzgh50xV0i8AXpFyT3MpVScYyUz7U/8dZOij/KUqbCF
	 H1LgFQmhpNsZ8tUb1teIXlRqnZL8HTElnUF7tb6bdHDn95LlqN3EWdhF3gaY+zITyE
	 POfdRlK09xtZQXLSlTXpDt4i9njzLQx/bDPN66BbRIAjVCIoeh04rWsk5IpUtikh9r
	 bzofplI8/b1rWPkuR9ABOerd3XaS4IB3KZ4WfWxvhIUqUOTJFxGRJzr60tmGmhjj3Z
	 UASP1JlhwNoy8xi9BFwPmfP43c/SMSpfOXhOXCGxirqFfrYerwgA3dYOrrphESg/pk
	 /OtltE7VUgODA==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/damon/paddr: Improve readability of damon_pa_stat
Date: Mon, 13 Jan 2025 13:25:36 -0800
Message-Id: <20250113212536.39564-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113210201.446051-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 13:01:56 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> damon_pa_stat contains an unnecessary goto statement, and the if/else
> can be re-written to be more readable.

Thank you for this nice patch!

Seems this patch conflicts with Usama's patch[1], though.  I believe Andrew
could resolve it on his own, but please let me know if any action is needed.

> 
> This patch is written on top of SJ's patch series [1], which in turn is
> written on top of another one of his series [2].
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> 
> [1] https://lore.kernel.org/all/20241219040327.61902-1-sj@kernel.org/
> [2] https://lore.kernel.org/all/20241213215306.54778-1-sj@kernel.org/

I think 'Signed-off-by:' like tags are the last part of canonical patch
format[2].  Above two links may better to be placed before the tags paragraph
if this patch has a chance to be revised.

[1] https://lore.kernel.org/20250113190738.1156381-1-usamaarif642@gmail.com
[2] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

> 
> ---
>  mm/damon/paddr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index b0c283808ba6..8cdf8320f9a5 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -509,11 +509,8 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
>  		if (!folio)
>  			continue;
>  
> -		if (damos_pa_filter_out(s, folio))
> -			goto put_folio;
> -		else
> +		if (!damos_pa_filter_out(s, folio))
>  			*sz_filter_passed += folio_size(folio);
> -put_folio:
>  		folio_put(folio);
>  	}
>  	return 0;
> 
> base-commit: 2c0573ae5b4c9c0f9d81fa0138ed0014e1baf41b
> -- 
> 2.43.5
