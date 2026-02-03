Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CA1B4223;
	Tue,  3 Feb 2026 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081792; cv=none; b=HmJJtO/XjF7VIUpti+fzi5FLlC/JzEg9Ng09ncUbQX5phYdRKCUIc/B0TiM3q9RGYfQYAu0zjs8Mhm9Ln6EYwZyaS6RO0NeSbJ/LtAOBpRDFAqkDBiNn8npWXTIJ71YvJDZdWIb4ORTR4OF3GoFxGC+AbHZCgGOKpyOXAvbImIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081792; c=relaxed/simple;
	bh=IgpK8TNN+i/1sHRlMuthVmqs5VzwjRwumGrfu+Q/0aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh7MlbYsfopErUm+r5D1hFDWWHgIeCt29wYv3d311o7Rjx0t/pq1Y5z9YvIg64QxHImgjioMpJzgEgWgKUeolleyfgnJO5Wl9oqSyAD3d7rCAGKy9SWs8Q5dgjoIXPu8zYq2lHDnrOoEjqWi6GJtR1/RBYBOJESPb3iJ5yRZdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8Mv14IQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8Mv14IQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03677C116C6;
	Tue,  3 Feb 2026 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081792;
	bh=IgpK8TNN+i/1sHRlMuthVmqs5VzwjRwumGrfu+Q/0aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8Mv14IQttEktkk7rT3/Ou6g3Z5Y34x2R8lMALQaNWDhmZquidqCuCpFoPn99pwLi
	 EMyPPfo0Yl1wXzj4Stk1e1dmRpir2Q3ugdwwSy1xm7//2OzAyKXc6Cuu/pSXQhm/t6
	 PonfpXnSpk/BuU2lt0jcRMkZQe/Pqj90mRoUSm3TIcmSVU+LBVEDyB2+TBD/K4/a7V
	 hd4UeVk/XQMzjJNIaGTyscYO78Vg/RNw2Wf5KTmwSEoEDkBBhT8N12XVn3e40BTEvc
	 Py8Zcj9HRxZb8vN7KQH42f0d8tTK43Vk5T53rnjDjt6eKlN9HwsaWPzB9mDRDmp6QR
	 Y+iNSJ9LUu9qg==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/4] mm/damon: Support for synchrounous huge pages collapse
Date: Mon,  2 Feb 2026 17:23:04 -0800
Message-ID: <20260203012304.67686-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202145650.1795854-3-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2 Feb 2026 14:56:47 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> * Support for huge pages collapse, which will be used by
>   dynamic_hugepages module.
> 
> * Include the new module for compilation
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/Kconfig      | 7 +++++++
>  mm/damon/Makefile     | 1 +
>  mm/damon/vaddr.c      | 3 +++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3813373a9200..de5a994f92c2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -142,6 +142,7 @@ enum damos_action {
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,
>  	DAMOS_MIGRATE_COLD,
> +	DAMOS_COLLAPSE,

Please update the kernel-doc comments for this new action, by the time you drop
the RFC tag from this patch series.

>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>  	NR_DAMOS_ACTIONS,
>  };
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 8c868f7035fc..2355aacb6d12 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -110,4 +110,11 @@ config DAMON_STAT_ENABLED_DEFAULT
>  	  Whether to enable DAMON_STAT by default.  Users can disable it in
>  	  boot or runtime using its 'enabled' parameter.
>  
> +config DAMON_HOT_HUGEPAGE
> +	bool "Build DAMON-based collapse of hot regions (DAMON_HOT_HUGEPAGES)"
> +	depends on DAMON_VADDR
> +	help
> +	 Collapse hot region into huge pages. Hot regions are determined by
> +	 DAMON-based sampling
> +

Apparently you wanted to introduce the above change on the next patch, but
mistakenly added here?

I'm also feeling the name might be better to be simpler.  What about... say,
just DAMON_HUGEPAGE?  We might want to extend that for general access-aware
huge pages.

>  endmenu
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index d8d6bf5f8bff..998bddc17819 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
>  obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
>  obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
>  obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
> +obj-$(CONFIG_DAMON_HOT_HUGEPAGE)	+= modules-common.o dynamic_hugepages.o

Ditto.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 23ed738a0bd6..4acbc1a6a5be 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -970,6 +970,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_COLLAPSE:
> +		madv_action = MADV_COLLAPSE;
> +		break;
>  	case DAMOS_MIGRATE_HOT:
>  	case DAMOS_MIGRATE_COLD:
>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
> -- 
> 2.43.0


Thanks,
SJ

[...]
