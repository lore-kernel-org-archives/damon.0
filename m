Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B259323D;
	Thu, 27 Feb 2025 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616156; cv=none; b=VYRPsTaF1bp1+c8TlD1BxnbGfSvYp0WjOw8qyEQR/8IIBd0idJU9KyevyA3wg7xnwZesrRl7VMAy/SS6wBTCcMXYM8gj9DMsa6mXGu/Qo1bzow7EDJepeX+vOG4YJRzKx3JFNFhJa4SxEmfAYVOJdBn7QkgdTJQ4Ays/pH/elZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616156; c=relaxed/simple;
	bh=LXJIbPMkT+7UcF2UJzjcQfuNFcE1BU59ZW1aikiYshU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7Qxl8FyLnQtNeiKxmc5ZDjVW4/gVOI+WRG916EFY1oaxt5jhy0p29xo4JmnlT6sAaSbvWhbAbUpG6hucyhKjiPlaF4h9/Razl9LlzrhWkKNW2AWwRZZAgbKigO6fN9xW/1DkHSp+AjPLs47BBWjGRaJGbQO6vtikBn2jzl9TCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW47K3SK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW47K3SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32C8C4CED6;
	Thu, 27 Feb 2025 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740616155;
	bh=LXJIbPMkT+7UcF2UJzjcQfuNFcE1BU59ZW1aikiYshU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW47K3SK0W9wVtM8OCRMHp9d6TXboaEtLsTJjp6nDq0xMDTku8JxPy8NHkXQTZtRI
	 tOSZDquLxmBsUduUEi26OHXqfcdHioVHi3dEzss2vSuZOWI1HDMqjBOGKK3zQTTUgJ
	 ivFs6wdb9hmxCjF8XBMmdGKM+QYC9oGBuoylxjXaRZlyXuQATlmfxKSOiQD0zq4Brb
	 oINQ5JTFKR8Ygl+tvyoVu1z64sUKwNLMXOTnIjWG+RxdNlewi4SmgGVM9KOpCrHkEN
	 VJgM29g0rOFsQQtPucEVazGiIFGiZRsi6hWfNNDgi2DKyNiMao0ZrCUtPJuNXgoMRv
	 wGY7g4fjjhn4g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 7/9] mm/damon/core: set damos_filter default allowance behavior based on installed filters
Date: Wed, 26 Feb 2025 16:29:13 -0800
Message-Id: <20250227002913.19359-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 11:35:07 -0800 SeongJae Park <sj@kernel.org> wrote:

> Decide whether to allow or reject by default on core and opertions layer
> handled filters evaluation stages, based on the last-installed filter's
> behavior.  It is the opposite of the last installed filter's behavior.
> If there is any operations layer handled filters, core layer handled
> filters stage keeps allowing as the default behavior, since the last
> filter of core layer handled filters in the case is not really the last
> filter of the entire filtering stage.

The last sentence describing behavior is not really implemented with this
commit.  See below.

> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 78126a5145fd..9744ab9ca5c5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -864,6 +864,29 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
>  	return 0;
>  }
>  
> +/**
> + * damos_filters_default_reject() - decide whether to reject memory that didn't
> + *				    match with any given filter.
> + * @filters:	Given DAMOS filters of a group.
> + */
> +static bool damos_filters_default_reject(struct list_head *filters)
> +{
> +	struct damos_filter *last_filter;
> +
> +	if (list_empty(filters))
> +		return false;
> +	last_filter = list_last_entry(filters, struct damos_filter, list);
> +	return last_filter->allow;
> +}
> +
> +static void damos_set_filters_default_reject(struct damos *s)
> +{
> +	s->core_filters_default_reject =
> +		damos_filters_default_reject(&s->filters);
> +	s->ops_filters_default_reject =
> +		damos_filters_default_reject(&s->ops_filters);
> +}

->core_filters_default_reject should be 'false' if s->ops_filters is not empty,
since the last one of ->ops_filters is not the real last filter.  But this code
is not handling the case.

I will fix this in the next revision.


Thanks,
SJ

[...]
