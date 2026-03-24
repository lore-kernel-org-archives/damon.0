Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E632AAA7;
	Tue, 24 Mar 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312801; cv=none; b=LvJ3M4E9sYZOvbljotigY21N/IV92W2PBI5NCo9T7pMYljaP9wtUmPzyJyGbnBpnAqx5hYq6c2m85le+lGLI9SKYtEtCasALgbuvJ8/cia7+VK484rRHegBx/yHNoEe210rPiVwCkecaZ8MRFQXKiGBLwrDJXgJ4SpdNtt75iRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312801; c=relaxed/simple;
	bh=vjPTBgwRkNPpj8g60XG24l6u4MKrR9E2q9j+xrBCY/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fffSdwMm0XCr+zOcYjGG4+a7K7qvA4l+Bk/vJX14KqYQenU1FMcxHtUKsHL02nnvkBH8W7v4G1gL/J7fuloMxbdpn6ua4BFaeEq9TPAYX1CWk4oDhZWcIvOmESbTkpmAIljhWbIIoSgU0Wdji5VSa4oYFYzho3adrZPxiy1TCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMAN5iao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMAN5iao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB6AC2BCB7;
	Tue, 24 Mar 2026 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312800;
	bh=vjPTBgwRkNPpj8g60XG24l6u4MKrR9E2q9j+xrBCY/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMAN5iaoN2R/H4BluGxXNkZeGXMDBR6YJkTKMNLE+NO961MjiVG2tQEldY0QSzZVn
	 3BiqXbsb3fjMJEViEEfP3uus6I53jVjQR/ymhU2zWmcH/i3j7VKaRBCMwtXbkNJXWr
	 bU6WIKeMBEoHHz2wF4ogzI28eZndPd5G95BmLHe07xgBGMik/oRSuuA6jazLtc6V7J
	 VZpv/e4s9Fx33wHsLnCLYJcz5w6kBvpL7RSVelWr0WDbrFyc0FFYY+UgI8sw8tc9kJ
	 AOMoO1GSXGa1Nea/U4xJEAFGm4a9V6HAyT08GbgzLY8uST8micXKu7GlvNiBQPzks+
	 M8BA39GykcmuQ==
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
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] This patch set introces a new action: DAMOS_COLLAPSE.
Date: Mon, 23 Mar 2026 17:39:51 -0700
Message-ID: <20260324003952.86819-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323145646.4165053-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Mon, 23 Mar 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> working, since it relies on hugepage_madvise to add a new slot. This
> slot should be picked up by khugepaged and eventually collapse (or
> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> enabled, khugepaged will not be working, and therefore no collapse
> will happen.
> 
> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
> the address range synchronously.
> 
> This new action may be required to support autotuning with hugepage as
> a goal[1].
> 
> [1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
> 
> ---------
> Benchmarks:
> 
> T n: THP never
> T m: THP madvise
> D h: DAMON action hugepage
> D c: DAMON action collapse
> 
> +------------------+----------+----------+----------+
> |                  | T n, D h | T m, D h | T n, D c |
> +------------------+----------+----------+----------+
> | Total memory use | 2.07     | 2.09     | 2.07     |
> | Huge pages       | 0        | 1.3      | 1.25     |
> +------------------+----------+----------+----------+

Thank you for sharing the benchmark results!  But, I'm having a hard time to
understand what this really means.  Could you please further clarify the setup
of the benchmarks and interpretation of the results?

> 
> Changes
> ---------
> v1-v2:
> Added benchmarks
> Added damos_filter_type documentation for new action to fix kernel-doc

Please add Changelog on the commentary section [1].  Also, please consider
adding links to previous versions.

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  Documentation/mm/damon/design.rst      |  4 ++++
>  include/linux/damon.h                  |  2 ++
>  mm/damon/sysfs-schemes.c               |  4 ++++
>  mm/damon/vaddr.c                       |  3 +++
>  tools/testing/selftests/damon/sysfs.py | 11 ++++++-----
>  5 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 838b14d22519..405142641e55 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -467,6 +467,10 @@ that supports each action are as below.
>     Supported by ``vaddr`` and ``fvaddr`` operations set. When
>     TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
>     fail.
> + - ``collapse``: Call ``madvise()`` for the region with ``MADV_COLLAPSE``.
> +   Supported by ``vaddr`` and ``fvaddr`` operations set. When
> +   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
> +   fail.
>   - ``lru_prio``: Prioritize the region on its LRU lists.
>     Supported by ``paddr`` operations set.
>   - ``lru_deprio``: Deprioritize the region on its LRU lists.
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index d9a3babbafc1..6941113968ec 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -121,6 +121,7 @@ struct damon_target {
>   * @DAMOS_PAGEOUT:	Reclaim the region.
>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
> + * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
>   * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
> @@ -140,6 +141,7 @@ enum damos_action {
>  	DAMOS_PAGEOUT,
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
> +	DAMOS_COLLAPSE,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 5186966dafb3..aa08a8f885fb 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2041,6 +2041,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
>  		.action = DAMOS_NOHUGEPAGE,
>  		.name = "nohugepage",
>  	},
> +	{
> +		.action = DAMOS_COLLAPSE,
> +		.name = "collapse",
> +	},
>  	{
>  		.action = DAMOS_LRU_PRIO,
>  		.name = "lru_prio",
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b069dbc7e3d2..dd5f2d7027ac 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -903,6 +903,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_COLLAPSE:
> +		madv_action = MADV_COLLAPSE;
> +		break;
>  	case DAMOS_MIGRATE_HOT:
>  	case DAMOS_MIGRATE_COLD:
>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> index 3aa5c91548a5..c6476e63f4fb 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -123,11 +123,12 @@ def assert_scheme_committed(scheme, dump):
>              'pageout': 2,
>              'hugepage': 3,
>              'nohugeapge': 4,
> -            'lru_prio': 5,
> -            'lru_deprio': 6,
> -            'migrate_hot': 7,
> -            'migrate_cold': 8,
> -            'stat': 9,
> +            'collapse': 5

Comman is missed?

> +            'lru_prio': 6,
> +            'lru_deprio': 7,
> +            'migrate_hot': 8,
> +            'migrate_cold': 9,
> +            'stat': 10,
>              }
>      assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
>      assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
> -- 
> 2.43.0

Other than the selftest part, code looks good.  Please consider dropping RFC
tag from the next spin.  Clarifying more details about the test would be
helpful, though.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ
