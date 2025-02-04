Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092971FF7A5
	for <damon@lists.linux.dev>; Tue,  4 Feb 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710643; cv=none; b=oYrbU6A7UZQzHIugq20C9VzZSbKSMyUJYEwpECJcfFQeGrZ6FjoJBQicu8kKTb1jOE9yRmur2oSV3TF7uzPQIw2b7eb8OZAiwEgmSj85DiAxOf9Ma3HK4bcsws6Gh+AYzwb0tgRshLcCO8UmlMYtQ0J61bwhdxWSZ9OwX0Q1Rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710643; c=relaxed/simple;
	bh=GdHA7lLu4VS8qeX7AJ6pbGx/Uc8jEbD6HLfU9CeuGks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHlVNSRPSBEZifdBYN4sG+xvXI00/AmL4RgctqOme/z70cIsmviY241wIqsjtyzLF75T4pf0yf5eO1Al6o8BpHh09yOIlFXqRwTLwYFrIR2mxbDvQn85gWKNs0yRvPoiNJCi0h09LNu+HWmK+8bgFTr4X/O7ymQLDipx+3CMtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF049Uud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF049Uud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D267C4CEDF;
	Tue,  4 Feb 2025 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738710642;
	bh=GdHA7lLu4VS8qeX7AJ6pbGx/Uc8jEbD6HLfU9CeuGks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fF049Uudk1DH95emQvgW8aS9CzUQrdM36b/gbXBjV5h+DfYQVEmd9q8pmmpHWXpdS
	 Osit0JPvJASMiDxh+JiSJ1QLhhxbA7gL69eSiXp0oiA74sCuXJy0TyHRLvfKqJrVS+
	 5vc9xjM8hfq2Hk429kjXvJaT594UNBn5fagIjwHw+TYYj3MzTOJRQpHMWWdzwiakhw
	 HHuGfWMbtwQyipHUZN6xFt2hjC06+k4kBBpwVXKe2pgD1St70sbQ8DWZoykC52WTca
	 7S/f0lZOnneaNlZ/J9paDfw45qVS1qSKmp5BS0CdqedJuWVwQyZHOynmRT861/WeTH
	 OiAuu+rwPSSKQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 3/6] mm/damon/sysfs-schemes: add files for setting damos_filter->folio_size
Date: Tue,  4 Feb 2025 15:10:40 -0800
Message-Id: <20250204231040.2655-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203225604.44742-4-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  3 Feb 2025 22:55:30 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> Add min and max files for damon filters to let the userspace decide
> the min/max folio size to operate on. This will be needed to decide
> what folio sizes to give pa_stat for.

I'd prefer implementing the logic with API interface first, and then
implementing sysfs interface on top of the API.

> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/damon.h    | 11 +++++++++
>  mm/damon/core.c          |  3 +++
>  mm/damon/sysfs-schemes.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index af525252b853..6f30ceeff215 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -35,6 +35,16 @@ struct damon_addr_range {
>  	unsigned long end;
>  };
>  
> +/**
> + * struct damon_folio_size - Represents size of folio filter on [@min, @max].
> + * @min:	Min size of the folio (inclusive).
> + * @max:	Max size of the folio (inclusive).
> + */
> +struct damon_folio_size {
> +	unsigned long min;
> +	unsigned long max;
> +};
> +

I'd suggest giving a more general name, say, damon_size_range, so that we can
reuse this for any possible future size range based filters or whatever.

>  /**
>   * struct damon_region - Represents a monitoring target region.
>   * @ar:			The address range of the region.
> @@ -377,6 +387,7 @@ struct damos_filter {
>  		struct damon_addr_range addr_range;
>  		int target_idx;
>  	};
> +	struct damon_folio_size folio_size;

As this will be used depending on damos_filter->type, let's add this field in
the above union, together with addr_range and target_idx.

Also, I'd prefer calling this hugepage_size, as we discussed on the previous
version of this patch series.

>  	struct list_head list;
>  };
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c7b981308862..27323e3a800d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -776,6 +776,9 @@ static void damos_commit_filter_arg(
>  	case DAMOS_FILTER_TYPE_TARGET:
>  		dst->target_idx = src->target_idx;
>  		break;
> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> +		dst->folio_size = src->folio_size;
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 98f93ae9f59e..bc7ca43ca9c4 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -316,6 +316,7 @@ struct damon_sysfs_scheme_filter {
>  	bool allow;
>  	char *memcg_path;
>  	struct damon_addr_range addr_range;
> +	struct damon_folio_size folio_size;

Again, I'd prefer calling this hugepage_size.

>  	int target_idx;
>  };
>  
> @@ -469,6 +470,43 @@ static ssize_t addr_end_store(struct kobject *kobj,
>  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>  			struct damon_sysfs_scheme_filter, kobj);
>  	int err = kstrtoul(buf, 0, &filter->addr_range.end);
> +	return err ? err : count;
> +}

Let's keep the blank line before 'return' so that this is not unnecessarily
marked as a diff.

> +
> +static ssize_t min_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> +			struct damon_sysfs_scheme_filter, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", filter->folio_size.min);
> +}
> +
> +static ssize_t min_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> +			struct damon_sysfs_scheme_filter, kobj);
> +	int err = kstrtoul(buf, 0, &filter->folio_size.min);
> +
> +	return err ? err : count;
> +}
> +
> +static ssize_t max_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> +			struct damon_sysfs_scheme_filter, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", filter->folio_size.max);
> +}
> +
> +static ssize_t max_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> +			struct damon_sysfs_scheme_filter, kobj);
> +	int err = kstrtoul(buf, 0, &filter->folio_size.max);
>  
>  	return err ? err : count;
>  }
> @@ -519,6 +557,12 @@ static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
>  static struct kobj_attribute damon_sysfs_scheme_filter_addr_end_attr =
>  		__ATTR_RW_MODE(addr_end, 0600);
>  
> +static struct kobj_attribute damon_sysfs_scheme_filter_min_attr =
> +		__ATTR_RW_MODE(min, 0600);
> +
> +static struct kobj_attribute damon_sysfs_scheme_filter_max_attr =
> +		__ATTR_RW_MODE(max, 0600);
> +
>  static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
>  		__ATTR_RW_MODE(damon_target_idx, 0600);
>  
> @@ -529,6 +573,8 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
>  	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
>  	&damon_sysfs_scheme_filter_addr_start_attr.attr,
>  	&damon_sysfs_scheme_filter_addr_end_attr.attr,
> +	&damon_sysfs_scheme_filter_min_attr.attr,
> +	&damon_sysfs_scheme_filter_max_attr.attr,
>  	&damon_sysfs_scheme_filter_damon_target_idx_attr.attr,
>  	NULL,
>  };
> @@ -1953,6 +1999,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
>  			filter->addr_range = sysfs_filter->addr_range;
>  		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
>  			filter->target_idx = sysfs_filter->target_idx;
> +		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE) {
> +			if (sysfs_filter->folio_size.min >
> +					sysfs_filter->folio_size.max) {
> +				damos_destroy_filter(filter);
> +				return -EINVAL;
> +			}

I don't think letting users set invalid min/max is a real problem, as long as
the implementation will handle the case (no memory matches the filter).  Let's
just allow it, like addr_range case.  If we really need to disallow this, it
would better to do that from damos_commit_filter() like central point.

> +			filter->folio_size = sysfs_filter->folio_size;
>  		}
>  
>  		damos_add_filter(scheme, filter);
> -- 
> 2.43.5


Thanks,
SJ
