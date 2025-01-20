Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE78186E58
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396499; cv=none; b=jCO9v4kNsrijQ5PTr3552mrh0sIicE7RknKUZR41MzvC7vmWTbfXiFvA2ECp1x1cjQEe31Rh2Afrgp2K3EcQSSya9e0S6BQ3ghqEHdumMtAenGJDU9t/NZl8VBVbVlUxe/kDPHb4tXJU0WnpvbzprEhRAEMsVJ7YifkFNRaz2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396499; c=relaxed/simple;
	bh=WOMMM3ZEZph/7jOGVt8Oa1TUcQa/0v+Hx8F6QlvlXjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArP3cBnYCU4BeMAve36K9F1pOIRPvscaSK8+sKApq7Qa4uc/6hqJLxVEkMmczRCrKt4zz0CWUGBkjsDyS2d44LZie2Z1+JPoZp+LXzJgaJWfirrONm8boKhEiKjk/V67x3d9Sa8wIgKOo2PO5qoa2gRF/gwKUyYbQgXmQqp4Urw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJMFcuXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJMFcuXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAC6C4CEDD;
	Mon, 20 Jan 2025 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737396498;
	bh=WOMMM3ZEZph/7jOGVt8Oa1TUcQa/0v+Hx8F6QlvlXjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJMFcuXZYe+r35XL9wRvegnlH8RFnbwSXmCE3I5fZYM+qX+bnQusPhdyenWEeDFK2
	 rNIKM3eyXmRQWl12xRUHpWJGW6eZ4iwAhcdV1RaRYiKyjGr18ZJC0vsrlfa870FeIn
	 BOYd+q+bqCeCMmQEtpJ+3ZAmGpuF2mNkSzO75YhbTN9bft9dGLVO8xA7iNgKFNzM72
	 +0EZhaRrplvfC+vRRZLk8NrEmXn+lRSztWCCIyWmmzWll/Ufcn5OoUxzlxwF9WB6d/
	 /q3liiJr7kwiEdLYa6dgqOyDJGHrjoueSIu1qnJKSZ0VWyBGD5GtiDWT1fCHiHY7IU
	 lPTAz1GXRZ2VQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 10:08:15 -0800
Message-Id: <20250120180815.36028-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120101650.3761306-2-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 10:16:50 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to gather statistics to check if memory regions of specific
> access tempratures are backed by hugepages. This includes both THPs
> and hugetlbfs.
> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
> v1 -> v2:
> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>   CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
> ---
>  include/linux/damon.h    | 4 ++++
>  mm/damon/paddr.c         | 5 +++++
>  mm/damon/sysfs-schemes.c | 3 +++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index af525252b853..b0dbf380ab76 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -326,6 +326,7 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
>   * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
>   * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
> + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> @@ -345,6 +346,9 @@ enum damos_filter_type {
>  	DAMOS_FILTER_TYPE_ANON,
>  	DAMOS_FILTER_TYPE_MEMCG,
>  	DAMOS_FILTER_TYPE_YOUNG,
> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> +	DAMOS_FILTER_TYPE_HUGEPAGE,
> +#endif

I'd prefer not enclosing this part with CONFIG_PGTABLE_HAS_HUGE_LEAVES, so that
users can simply use it.  If the config is not set, damos_pa_filter_match()
will just say nothing is hugepage, and hence will work sanely, in my opinion.

>  	DAMOS_FILTER_TYPE_ADDR,
>  	DAMOS_FILTER_TYPE_TARGET,
>  	NR_DAMOS_FILTER_TYPES,
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index c0ccf4fade24..224308140441 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>  		if (matched)
>  			damon_folio_mkold(folio);
>  		break;
> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> +		break;
> +#endif

This part looks good to me.

>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 98f93ae9f59e..3eb3ec464591 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -329,6 +329,9 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
>  	"anon",
>  	"memcg",
>  	"young",
> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> +	"hugepage",
> +#endif

Again, I'd prefer not enclosing this part.

>  	"addr",
>  	"target",
>  };
> -- 
> 2.43.5


Thanks,
SJ
