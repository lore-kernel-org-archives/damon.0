Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7722874ED;
	Wed, 13 Aug 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105002; cv=none; b=F4xZQgco5mm3eukkTX6w/5iRZMSUltJPAVtZHYiDW3Fvs3nvZHLfibmwlTnVPhvFAYQLx8U+5aQjtYq2IdHiFdXEN0cSGjI6jOmRWZ/Hxsus9Z8uWjzEHaFmcSBzb2vlEHo7UqJmHsCtpdvNMOQh+3Um/bmew15jzVksKLkFpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105002; c=relaxed/simple;
	bh=AIWgF14roG2s1lL3N6s+OU/JIDgn+6qzvLO1PUr65lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHy2WEzmDtXAwQ/PbxaxE/NWc8GH7pyp3nc5tJBMSd7cd8uYr3/1btmPKNJReNdc6lFP5ERERKnT6tFReYpLIWo3iYZkBIGesuOp8C/uqD6gY/9aCOtbHeQjE/NKwImO54zh8rcHiia3UjKfuXOZKTaxEzGoGtU2nAHopKXIMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTlViCzK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTlViCzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1832C4CEEB;
	Wed, 13 Aug 2025 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755105002;
	bh=AIWgF14roG2s1lL3N6s+OU/JIDgn+6qzvLO1PUr65lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTlViCzKJ6oNXqiiP+yf5NnjgQaXzeC5n6P9xOPggqWpoRaHlwaDI1mvW60w31f7z
	 Nk4wYDNWeQJqTf13oWXlarIYS4G7HXdpOctnUB5iWisAC9T5iXxijFqW5GDfRGiyln
	 0aar22OgoB+SxaiV6DVGdHOrsuCSOKwnlhkkWCTlavbdrKC+1E7kS8qppE0a4h+kfL
	 h396yxnoXzknUv6pnRL70DK2zY7o4hxelhQfm4s71BW2VoykC6HcM0DB7+QZ0KvKJH
	 YWjrJ/xKIpVm2cugUJElax/DsAw1ksJ5mjDQdz+mXtGuc4c0PUVtl+M00Dzoj2+q7T
	 qSWYD33zElEoA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 15/16] mm/damon: the byte statistics data type in damos_stat uses unsigned long long
Date: Wed, 13 Aug 2025 10:10:00 -0700
Message-Id: <20250813171000.6345-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-16-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:07:05 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> For 32-bit systems, damos_stat now uses unsigned long long for byte
> statistics data to avoid integer overflow risks inherent in the
> previous design.

I suggested using the core-layer address unit on stat, and ask users to
multiply the addr_unit value to stat values if they want bytes value.  If we
agree on it, I think this patch wouldn't really be required.

> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  include/linux/damon.h     |  6 +++---
>  mm/damon/modules-common.h |  4 ++--
>  mm/damon/sysfs-schemes.c  | 12 ++++++------
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index aa045dcb5b5d..d85850cf06c5 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -333,10 +333,10 @@ struct damos_watermarks {
>   */
>  struct damos_stat {
>  	unsigned long nr_tried;
> -	unsigned long sz_tried;
> +	unsigned long long sz_tried;
>  	unsigned long nr_applied;
> -	unsigned long sz_applied;
> -	unsigned long sz_ops_filter_passed;
> +	unsigned long long sz_applied;
> +	unsigned long long sz_ops_filter_passed;
>  	unsigned long qt_exceeds;
>  };
>  
> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
> index c7048a449321..ae45d0eb960e 100644
> --- a/mm/damon/modules-common.h
> +++ b/mm/damon/modules-common.h
> @@ -36,11 +36,11 @@
>  #define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
>  		succ_name, qt_exceed_name)				\
>  	module_param_named(nr_##try_name, stat.nr_tried, ulong, 0400);	\
> -	module_param_named(bytes_##try_name, stat.sz_tried, ulong,	\
> +	module_param_named(bytes_##try_name, stat.sz_tried, ullong,	\
>  			0400);						\
>  	module_param_named(nr_##succ_name, stat.nr_applied, ulong,	\
>  			0400);						\
> -	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
> +	module_param_named(bytes_##succ_name, stat.sz_applied, ullong,	\
>  			0400);						\
>  	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>  			0400);
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 74056bcd6a2c..3c4882549a28 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -199,10 +199,10 @@ static const struct kobj_type damon_sysfs_scheme_regions_ktype = {
>  struct damon_sysfs_stats {
>  	struct kobject kobj;
>  	unsigned long nr_tried;
> -	unsigned long sz_tried;
> +	unsigned long long sz_tried;
>  	unsigned long nr_applied;
> -	unsigned long sz_applied;
> -	unsigned long sz_ops_filter_passed;
> +	unsigned long long sz_applied;
> +	unsigned long long sz_ops_filter_passed;
>  	unsigned long qt_exceeds;
>  };
>  
> @@ -226,7 +226,7 @@ static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
>  	struct damon_sysfs_stats *stats = container_of(kobj,
>  			struct damon_sysfs_stats, kobj);
>  
> -	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
> +	return sysfs_emit(buf, "%llu\n", stats->sz_tried);
>  }
>  
>  static ssize_t nr_applied_show(struct kobject *kobj,
> @@ -244,7 +244,7 @@ static ssize_t sz_applied_show(struct kobject *kobj,
>  	struct damon_sysfs_stats *stats = container_of(kobj,
>  			struct damon_sysfs_stats, kobj);
>  
> -	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
> +	return sysfs_emit(buf, "%llu\n", stats->sz_applied);
>  }
>  
>  static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
> @@ -253,7 +253,7 @@ static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
>  	struct damon_sysfs_stats *stats = container_of(kobj,
>  			struct damon_sysfs_stats, kobj);
>  
> -	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed);
> +	return sysfs_emit(buf, "%llu\n", stats->sz_ops_filter_passed);
>  }
>  
>  static ssize_t qt_exceeds_show(struct kobject *kobj,
> -- 
> 2.34.1
