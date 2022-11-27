Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E373D9D
	for <damon@lists.linux.dev>; Sun, 27 Nov 2022 18:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C20C433C1;
	Sun, 27 Nov 2022 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669573376;
	bh=57HIenwr4Kxr7NNYG8vCR5qqJX7zD83iy2OLbU6pyIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Emh5Ol8sdOZJZuy9excDvXibwZaXZtYmloEpPcDw06KILvTUTJc/Dd0GyAVPgxmIq
	 0moiWYEXes3Tga3TndQa7tlyjHkJ+FNUhfkU+p7mYuACkKCVtnzGPkjfAg5XzFGhVV
	 7wa6AXUUPJCJqDgIgCOoT9fgkhMJv2Ai/LCSr9zMFVE7PLEiQnbyvmw6if3qyKK7gu
	 vYsDpH+Fu4H/7rCbR5/+6BfNDwHngS5rCuSTnzrZge9FyDpfOOFTw0jRUMg9R6OnUs
	 45rEM0Fp2lRlWBrNypsHWZDLAVej53hvOmxtuA7+MNANiWcyD2XmoFNPo2ns7jsLUQ
	 EwYSSHPt1JhOA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] mm/damon/sysfs-schemes: connect filter directory and filters directory
Date: Sun, 27 Nov 2022 18:22:54 +0000
Message-Id: <20221127182254.4850-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Nov 2022 21:21:10 +0000 SeongJae Park <sj@kernel.org> wrote:

> Implement 'nr_filters' file under 'filters' directory, which will be
> used to populate specific number of 'filter' directory under the
> directory, similar to other 'nr_*' files in DAMON sysfs interface.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs-schemes.c | 67 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index afbfc55a8e84..7f2bab617156 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[...]
> @@ -401,6 +407,57 @@ damon_sysfs_scheme_filters_alloc(void)
>  	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
>  }
>  
> +static void damon_sysfs_scheme_filters_rm_dirs(
> +		struct damon_sysfs_scheme_filters *filters)
> +{
> +	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
> +	int i;
> +
> +	for (i = 0; i < filters->nr; i++)
> +		kobject_put(&filters_arr[i]->kobj);
> +	filters->nr = 0;
> +	kfree(filters_arr);
> +	filters->filters_arr = NULL;
> +}

This function should also be called from damon_Sysfs_scheme_rm_dirs() but this
patch is missing that.  This could result in undeleted filters directory when
writing 0 to 'nr_schemes' file.  Next version of this patchset will fix that.


Thanks,
SJ

[...]
