Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688F1DE4E7
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054345; cv=none; b=rI88jmOdt66+NSEwZn67YPn8f2iHhKLZq1EYwOO3BQGHfryeqArUuN/LEUND4MZJifsdPskEqfUau7HDbCviheAOxHsklBxU6VZ0OZLsOZh70QratDxVqA6jrKQu84q0WWi+fQRELYek2qDYn/rYJ3uMG82hhkcy86bRdQdm99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054345; c=relaxed/simple;
	bh=qFmthluP9ufWwXn1cIYj4V+I4tC7CDEAGsr70wH9sPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm85QyHeN4c94ULj4qGU8ozzVhf+6No8Xi4nNG1GTcL7bmJDuvTwDL0FKqsNudnOkE8BkPhgeJPMMWXXhMxl3q4fKv1AjdnbIWVVXqctcH4M2Hv1Mm+HWt18OzGaCKsq2PAmoqyp6CpID2Ym/PuSjGHbV6hgjboNzAmRF/DN9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODQZYrlO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODQZYrlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9F1C4CEDF;
	Thu, 16 Jan 2025 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737054345;
	bh=qFmthluP9ufWwXn1cIYj4V+I4tC7CDEAGsr70wH9sPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODQZYrlOIA8/7EudDDu4JDv8AAjIV2jL6UpROIWuYwlYg2sKy+GfHlwntJrqP09vf
	 WhnC5yLSsx5h++8T2mYvsoXXR/vnL/gTXnEXVr8eTuJfKVBNVmJ7dMMf+9kvw7gpxW
	 cONvqOLrI2ji7JVjQw94Be8VWQsJerVMRGJsMlvh3UoL4tlVvuCxDVv8lX68ZUHAVk
	 9s6793e8RCxqvqcHsBOTIU809GaTwF43nM7GKLYPkZlFFNcdHuaBg4St/tc/y62Bti
	 LzDYqvcsGfI1FMy2FokGwXtfb7Jg59XigY0jiiZf6S4oIwF7yJOzMD/cWaHyXdreFn
	 1G3Y2uPkObSeQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Thu, 16 Jan 2025 11:05:38 -0800
Message-Id: <20250116190538.60331-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116144436.3947318-2-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 16 Jan 2025 14:44:36 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to gather statistics to check if hotest memory regions

s/hotest/hottest/?

> are backed by hugepages.

This would also be useful for not only hottest memory regions but general
memory regions of specific access temperature.  I like this.

> This includes both THPs and hugetlbfs.
> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.

Nice extension of DAMON's page level properties based monitoring!

> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/damon.h    | 2 ++
>  mm/damon/paddr.c         | 3 +++
>  mm/damon/sysfs-schemes.c | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index af525252b853..1d94d7d88b36 100644
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
> @@ -345,6 +346,7 @@ enum damos_filter_type {
>  	DAMOS_FILTER_TYPE_ANON,
>  	DAMOS_FILTER_TYPE_MEMCG,
>  	DAMOS_FILTER_TYPE_YOUNG,
> +	DAMOS_FILTER_TYPE_HUGEPAGE,
>  	DAMOS_FILTER_TYPE_ADDR,
>  	DAMOS_FILTER_TYPE_TARGET,
>  	NR_DAMOS_FILTER_TYPES,
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index c0ccf4fade24..a9e69179d45c 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -222,6 +222,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>  		if (matched)
>  			damon_folio_mkold(folio);
>  		break;
> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> +		break;

This will make build fails when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not set, like
below:

 /include/linux/compiler_types.h:542:45: error: call to ‘__compiletime_assert_321’ declared with attribute error: BUILD_BUG failed
   542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |                                             ^
[...]
 /include/linux/huge_mm.h:111:35: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
   111 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
       |                                   ^~~~~~~~~~~~~~~
 /mm/damon/paddr.c:321:48: note: in expansion of macro ‘HPAGE_PMD_SIZE’
   321 |                 matched = folio_size(folio) == HPAGE_PMD_SIZE;
       |                                                ^~~~~~~~~~~~~~


This simple test might help you reproducing it:
https://github.com/damonitor/damon-tests/blob/master/corr/tests/build_i386.sh

What about enclosing the entire case with

    #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE) ?

>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 98f93ae9f59e..de9265f7ccde 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -329,6 +329,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
>  	"anon",
>  	"memcg",
>  	"young",
> +	"hugepage",
>  	"addr",
>  	"target",
>  };

Other parts look good to me :)


Thanks,
SJ

[...]
