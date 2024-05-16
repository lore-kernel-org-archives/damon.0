Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048D3FE4;
	Thu, 16 May 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897859; cv=none; b=Afx7elUYclOM3XJaEh7cI2SMS+POO43HJE6iiPOuggxg5O7Urzc5EQwdV2S5fb4GxWTXOIVSmZRiLYIyf6lAElc6YhibETniNxACq4Nwb5628s/hw4j3c15k+DsQK2g56dTvXpfsbJEBRWUvohDTDScwIlIBXAZtqWeFVtpLE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897859; c=relaxed/simple;
	bh=AAD7OIjCqFmLMcNQ5v7ono7dluP+5mcNBRp7Eg58oQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lp9h3xMwxOhYF3ANfRljdDdQxXe4yerZHxolpKNM3+JCXLRTJAs8wseBqWGREMOlGoLn5iEDTHrhpkVyDdETJ+6yMiJzFgJyOXKkqv1CngqbjDod3jESAHXMH3+4u+osWb6uC+ZdjPmau5B3tt2q2pnan32Bc386yecSuqhCi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxD8ae5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxD8ae5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B7FC113CC;
	Thu, 16 May 2024 22:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715897858;
	bh=AAD7OIjCqFmLMcNQ5v7ono7dluP+5mcNBRp7Eg58oQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxD8ae5IBngYzxe+Zyl4LQ9G5AqJ7yHFqIM0EvRpFImFiNOBflfEE1BrJBCbfWmr/
	 dOZ9/ZsN1TSpE2axXkQPYBz1kM7E8bWS9DvLuejr3+zMj0EcwQz2nq8N6/sMD7NIPi
	 bpadvLwYHJsya+qjB9wwSvyEwU9WndwIpmlsR0ASUxIwDO6RUdYCMTFdYl+0Ki/B3Q
	 efNMggAy0dZjNiHYl88RyEU7Pcs4m2izSe4x/OCVvYO/PplzryTP6qeVh8/BQUIARn
	 QyB124mDs+KUtb7rvLCOruihnSEa7RZZdAPWeYG02okKDQuE7tRyRL1/AMyIFOf3hq
	 US9p2HKQY3IHQ==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/7] DAMON multiple contexts support
Date: Thu, 16 May 2024 15:17:35 -0700
Message-Id: <20240516221735.82564-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515152457.603724-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Alex,


Adding high level comments first.  I will try to read each patch and add
detailed comments to those as soon as I get some time.

Also, please Cc linux-mm@ for DAMON patches.  I'd also recommend cc-ing
linux-kernel@.

On Wed, 15 May 2024 18:24:50 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> Currently kdamond uses only one context per kthread
> and most of its time it sleeps, so utilizing several
> contexts can scale kdamond and allow it to use
> another set of operations.

Thank you for this patchset.  I believe this change is important for DAMON's
long term vision.

A quick question for a clarification and proper prioritization, though, since
size of this patch series is not very tiny.  Does this patch series is for your
real usage?  If so, could you please clarify your usage and how this patch
series can help?

> 
> This patch-set implements support for multiple contexts
> per kdamond.
> 
> In pseudo code previous versions worked like
> the following:
> 
> 	while (!kdamond_should_stop()) {
> 
> 		/* prepare accesses for only 1 context */
> 		prepare_accesses(damon_context);
> 
> 		sleep(sample_interval);
> 
> 		/* check accesses for only 1 context */
> 		check_accesses(damon_context);
> 
> 		...
> 	}
> 
> With this patch kdamond workflow will look
> like the following:
> 
> 	while (!kdamond_shoule_stop()) {
> 
> 		/* prepare accesses for all contexts in kdamond */
> 		damon_for_each_context(ctx, kdamond)
> 			prepare_accesses(ctx);
> 
> 		sleep(sample_interval);
> 
> 		/* check_accesses for all contexts in kdamond */
> 		damon_for_each_context(ctx, kdamond)
> 			check_accesses(ctx);
> 
> 			...
> 	}

The overall idea makes sense to me.

> 
> To try this you can use modified kernel[1] and
> damo[2]. I also have written few simple shell scripts[3]
> to collect data for damo.
> 
> 	[1] https://github.com/onlyoneofme/damon-multi-contexts.git
> 	[2] https://github.com/onlyoneofme/damo/tree/multi-contexts

Looking forward to the patch for DAMO be submitted, or PR-ed!

> 	[3] https://github.com/onlyoneofme/damon-multi-contexts-tests.git

Do you have a plan to integrate this into DAMON selftests or damon-tests?

> 
> Alex Rusuf (7):
>   mm/damon/core: kdamond_struct abstraction layer

Let's make the subjects clear what it does.  For example, this patch's subject
could be "add kdamonds_struct abstraction layer".  Similar comment for other
patches.  Also, I think '_struct' suffix of 'kdamond_struct' is not really
needed.  Let's remove it if there is no special reason to add it.

>   mm/damon/core: list-based contexts organization

I think this can be squashed into the first patch?  If not, could you please
let clarify?

>   mm/damon/lru_sort: kdamond_struct abstraction layer
>   mm/damon/reclaim: kdamon_struct abstraction layer

Does these two patches mean lru_sort and reclaim are broken by the first patch?
Let's keep everything unbroken in middle of the patchset, to help bisect.

>   mm/damon/core: rename nr_running_ctxs -> nr_running_kdamonds

I think this would also better to be together with the first patch?  I know
this does not break something, but makes reading patch bit complex.

>   mm/damon/core: multi-context support
>   mm/damon/core: multi-context awarness for trace events

I think these two patches should be squashed into one patch.  Otherwise, the
trace point is broken in the middle of the patch series, right?

> 
>  include/linux/damon.h        |  48 +++-
>  include/trace/events/damon.h |  14 +-
>  mm/damon/core.c              | 497 +++++++++++++++++++++--------------
>  mm/damon/lru_sort.c          |  31 ++-
>  mm/damon/modules-common.c    |  35 ++-
>  mm/damon/modules-common.h    |   3 +-
>  mm/damon/reclaim.c           |  30 ++-
>  mm/damon/sysfs.c             | 306 +++++++++++++--------
>  8 files changed, 629 insertions(+), 335 deletions(-)

> 
> -- 
> 2.42.0


Thanks,
SJ
