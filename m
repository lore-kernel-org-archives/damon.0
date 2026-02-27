Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC226E6F9;
	Fri, 27 Feb 2026 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157375; cv=none; b=I85vvJMBNRqSJ5u3o3XsrN7pWo6s2fqK4VlhE7FQulMj/UvvL+Qurp6+Caqgb3Li9zpkl3slJKq1KhcfO9+zxRgaWEt5yXkmoQkJXpAFspz7j/kXw8cOm4tDk1EQV82BiqiQ9fVGjX+b/A5wsOHsQDbilPy8pZlgR90/WOoiXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157375; c=relaxed/simple;
	bh=+3NGDKoPMiK/X0YvkLCsM35GibtNp1pBwm8kbF/eqpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRRFmpn7/iBhW0KjYBpi66H2oJAZEETlDmdA21fblErowK42qxwpf3jQYMS6u9RE8/+C2PKNagMXv6i5Kfx8sfFcO59HZadLULmi/M9sU/ZoGHltSijLdRY1+F4W8OkDtIlePiD4jviDlMsKMOmM+0Nu/4I63e0Bmxp1swVIroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA43YzXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA43YzXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192D2C116C6;
	Fri, 27 Feb 2026 01:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157375;
	bh=+3NGDKoPMiK/X0YvkLCsM35GibtNp1pBwm8kbF/eqpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cA43YzXx1Zbyf6taFSYkJjbamE5B1SW4NRtDdrh8qnAh3n3p3O+0AOhfY2n++5AYU
	 x9xJE8hLU4E4VsSZTQh6RuQCQcgbLuRJV88XcU1/VPedUoIw92IKNlTrJ1Mg7zeKP3
	 SwWt+oYVHIb6sHxGNQ69xiPCTyMNZMp/sGIrk4+czh3nSy/owVjHSNm99yOCrvLep2
	 LE8gkuHSbl9ZU3hLg2WSguA6XEJEbPf1emlin9lQpwtZ6SDsc5rm3Xa+h6BsDwsjYZ
	 XO3BA85sHXswgkZKwedIkxGiYQ1EAcieNXeoI9Qg6f7KScpqOdMSwSSl2eZqafkkjm
	 wMkmsOk5FP9lw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: Re: [RFC PATCH 1/5] mm/damon/core: introduce damos_quota_goal_tuner
Date: Thu, 26 Feb 2026 17:56:13 -0800
Message-ID: <20260227015613.91346-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212062314.69961-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Feb 2026 22:23:08 -0800 SeongJae Park <sj@kernel.org> wrote:

> Currently DAMOS quota goal feature utilizes a single feedback loop based
> algorithm for automatic tuning of the effective quota.  It is proven to
> be useful on dynamic environments that operate systems with only
> kernels.  But, no one fits all, and we got multiple reports [1,2] of
> cases that the algorithm is not optimum.
> 
> Introduce a new field of 'struct damos_quotas', namely 'goal_tuner'.  It
> specifies what tuning algorithm the given scheme should use, and allows
> DAMON API callers to set it as they want.  Nonetheless, this commit does
> not introduce a new tuning algorithm but only the interface.  This
> commit hence makes no behavioral change.  A new algorithm will be added
> by the following commit.
> 
> [1] https://lore.kernel.org/CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com
> [2] https://lore.kernel.org/20260204022537.814-1-yunjeong.mun@sk.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 9 +++++++++
>  mm/damon/core.c       | 4 +++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a4fea23da8576..25345b5f821b9 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -213,6 +213,14 @@ struct damos_quota_goal {
>  	struct list_head list;
>  };
>  
> +/**
> + * enum damos_quota_goal_tuner - Goal-based quota tuning logic.
> + * @DAMOS_QUOTA_GOAL_TUNER_CONSIST:	Aim long term consistent quota.
> + */
> +enum damos_quota_goal_tuner {
> +	DAMOS_QUOTA_GOAL_TUNER_CONSIST,
> +};
> +
>  /**
>   * struct damos_quota - Controls the aggressiveness of the given scheme.
>   * @reset_interval:	Charge reset interval in milliseconds.
> @@ -260,6 +268,7 @@ struct damos_quota {
>  	unsigned long ms;
>  	unsigned long sz;
>  	struct list_head goals;
> +	enum damos_quota_goal_tuner goal_tuner;
>  	unsigned long esz;
>  
>  	unsigned int weight_sz;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0ff190ed8a599..1c126d910fe62 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -405,8 +405,9 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  	INIT_LIST_HEAD(&scheme->list);
>  
>  	scheme->quota = *(damos_quota_init(quota));
> -	/* quota.goals should be separately set by caller */
> +	/* quota.goals and .goal_tuner should be separately set by caller */
>  	INIT_LIST_HEAD(&scheme->quota.goals);
> +	scheme->quota.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_CONSIST;

Ravi found this is resetting tuner setup in damon_sysfs_add_quota_score() in
sysfs-schemes.c.  As a result, users were unable to use goal_tuner feature.
Ravi further suggested a fix that sets the goal_tuner after damon_new_scheme(),
as suggested here.

I was thinking that's the right fix assuming the comment is right.  I was also
thinking I entirely forgot setting the goal_tuner field in sysfs-schemes.c.
But I now find I didn't entirely forget it, as the third patch of this series
does set it on the quota struct that is passed to damon_new_scheme().  However
I was stupidly forgetting the fact that damon_new_scheme() overwrites the
field, and I asked callers to set it after the call.

Now I think the above initialization and the instruction on the comment is just
wrong.  There is no reason to refuse the caller-set value in the parameter
struct.  Rather, it only confuses callers.

I will fix the issue by simply dropping the above diff.

[1] https://lore.kernel.org/20260223123232.12851-2-ravis.opensrc@gmail.com


Thanks,
SJ

[...]
