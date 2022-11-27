Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A993FD4
	for <damon@lists.linux.dev>; Sun, 27 Nov 2022 19:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E75C433C1;
	Sun, 27 Nov 2022 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669578684;
	bh=u/x3fW/kNN7k6/MnlQGpUtV7XW5nRo+M7USr9HpvEd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/sSpxdQIfJtGqzzYHBMhwtme35L2XQD2y8x0d09iM4lJd02TwbLUXuVYwZU2PVsX
	 6GBmJRvWvNfptTxdRvE9Jq+A61+fd11sDKZv8//W1XkfNv6BazyTHSJfgsDYGnSm77
	 qsbyvE4EpBBsuJDzRekoyBy78EKhcEuCfrvn7RPVMhpemRRk1EWYM2aZFMyz0vXYs0
	 GIu3fvGDbLa+RVv1GS/uEkALoV+HGfW49Ky4038A0mhZPX3b2u5u9JQLRo0aEFCiYz
	 tHcTqwR5mCXPD7fK2b5FvzyHcWa9ZpVm7dFXva5q3DLdZS15wyaBJzKjH2i7kNiGYB
	 upDa8qTGeo0Nw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] mm/damon/sysfs-schemes: implement scheme filters
Date: Sun, 27 Nov 2022 19:51:21 +0000
Message-Id: <20221127195121.1388-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-9-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Nov 2022 21:21:11 +0000 SeongJae Park <sj@kernel.org> wrote:

> Implement scheme filters functionality of DAMON sysfs interface by
> making the code reads the values of files under the filter directories
> and pass that to DAMON using DAMON kernel API.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs-schemes.c | 85 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 7f2bab617156..6f014b328e6f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[...]
> +static int damon_sysfs_set_scheme_filters(struct damos *scheme,
> +		struct damon_sysfs_scheme_filters *sysfs_filters)
> +{
> +	int i;
> +	struct damos_filter *filter, *next;
> +
> +	damos_for_each_filter_safe(filter, next, scheme)
> +		damos_destroy_filter(filter);
> +
> +	for (i = 0; i < sysfs_filters->nr; i++) {
> +		struct damon_sysfs_scheme_filter *sysfs_filter =
> +			sysfs_filters->filters_arr[i];
> +		struct damos_filter *filter =
> +			damos_new_filter(sysfs_filter->type,
> +					sysfs_filter->matching);
> +		int err;
> +
> +		if (!filter)
> +			return -ENOMEM;
> +		if (filter->type == DAMOS_FILTER_TYPE_MEMCG) {
> +			err = damon_sysfs_memcg_path_to_id(
> +					sysfs_filter->memcg_path,
> +					&filter->memcg_id);
> +			if (err)
> +				return err;
> +		}

Newly created filter should be added to the scheme, but this patch is missing
the code.  Will add that in the next version of this patch.

> +	}
> +	return 0;
> +}
> +
