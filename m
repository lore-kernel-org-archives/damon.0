Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E123FE37B;
	Tue, 24 Mar 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361582; cv=none; b=ZWhfiU1JmVkVY4LsKJiPAivLJx2B4KqLLV23YWoYRkEEuwavJZ1MK5HXtNXCxcIFgNZeWfE6jKPx56+K2TNRzoB37wYTNm4H5oTh9ozAdX7XJQrmzkmwvsGKXr63v3s32r5V5qWyrzqTZ6wuoZNPEi4T9I6NuS5EQ+/h3JOw2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361582; c=relaxed/simple;
	bh=R67EKc7NRuD/wiIvZo05R08AzOlBa2CEd878B2zKNJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HntRK3a0pA31GqECPUieBY24bQ3ydwvDOYYg13Yl8JwkPXpa1pyxza49kzyfieACaAgHchhpgNlFOTmrGGn08lwKcSV5Ah+TB+/c8U1224mcEwHY7Uo08l4mSKHK37jgoBVek3MJKXFBiU7piWIo55pW34YW9Wve26qm54fT9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp6Wdyut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp6Wdyut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B455CC19424;
	Tue, 24 Mar 2026 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774361582;
	bh=R67EKc7NRuD/wiIvZo05R08AzOlBa2CEd878B2zKNJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hp6WdyutUOSgeEyipB4ayrX4y+JtZtuf1cYBQ5b0ClfwmzI86AbGagTkwWRMEsrWE
	 /6vxU9HL20Hseu/i8XL4QDSwzAAxoayBk2+1Qfu7c98uT+UdDro+AgVlRLNg1d5bF4
	 1gnU5Oa2yyQxPnXXOgMt7qQcTp75OxPhiaMlPPf1F7tavd7gw2G7x/spb+xjnJsqBH
	 mKokgkgFuqN3tVwRwWrcJGlVO7+OU4v27VoIS11WaxhnH6/bTnyPMq3GL85Sdt9jPm
	 1W8+Bd655SEQM/i9UhhHes1p+kAPh8c8B9hu7h4p9yjR/wCHVr5NRRQCuKTDspzPIv
	 eUSlRU2KkDLNQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
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
Date: Tue, 24 Mar 2026 07:12:57 -0700
Message-ID: <20260324141257.91322-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <48580762-eec3-49b6-b17a-59fa486bebec@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 16:57:22 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 3/24/2026 3:39 AM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > On Mon, 23 Mar 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> >> working, since it relies on hugepage_madvise to add a new slot. This
> >> slot should be picked up by khugepaged and eventually collapse (or
> >> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> >> enabled, khugepaged will not be working, and therefore no collapse
> >> will happen.
> >>
> >> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
> >> the address range synchronously.
> >>
> >> This new action may be required to support autotuning with hugepage as
> >> a goal[1].
> >>
> >> [1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
> >>
> >> ---------
> >> Benchmarks:
> >>
> >> T n: THP never
> >> T m: THP madvise
> >> D h: DAMON action hugepage
> >> D c: DAMON action collapse
> >>
> >> +------------------+----------+----------+----------+
> >> |                  | T n, D h | T m, D h | T n, D c |
> >> +------------------+----------+----------+----------+
> >> | Total memory use | 2.07     | 2.09     | 2.07     |
> >> | Huge pages       | 0        | 1.3      | 1.25     |
> >> +------------------+----------+----------+----------+
> > 
> > Thank you for sharing the benchmark results!  But, I'm having a hard time to
> > understand what this really means.  Could you please further clarify the setup
> > of the benchmarks and interpretation of the results?
> I will fix the cover in the next version, which I will submit soon.
> 
> I tested the patch in a physical server with MariaDB 10.5. I run
> sysbench to load the server.
> 
> I check 3 scenarios:
> - DAMON action hugepage for the database task, THP as never
> - DAMON action hugepage, THP madvise
> - DAMON action collapse, THP never
> 
> I compared the memory consumption, both in overall in the server and
> anonymous huge page consumption. The results are in the table
> 
> T n: THP never
> T m: THP madvise
> D h: DAMON action hugepage
> D c: DAMON action collapse

Thank you for sharing the details of the setup, Asier.

> 
> +------------------+----------+----------+----------+
> |                  | T n, D h | T m, D h | T n, D c |
> +------------------+----------+----------+----------+
> | Total memory use | 2.07     | 2.09     | 2.07     |
> | Huge pages       | 0        | 1.3      | 1.25     |
> +------------------+----------+----------+----------+

Could you please further share interpretation of the results?  What these
results mean?  Does it show some benefit of DAMOS_COLLAPSE?

Also, how is the performance?  Does it show some difference?

> > 
> >>
> >> Changes
> >> ---------
> >> v1-v2:
> >> Added benchmarks
> >> Added damos_filter_type documentation for new action to fix kernel-doc
> > 
> > Please add Changelog on the commentary section [1].  Also, please consider
> > adding links to previous versions.
> > 
> >>
> >> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >> ---
> >>  Documentation/mm/damon/design.rst      |  4 ++++
> >>  include/linux/damon.h                  |  2 ++
> >>  mm/damon/sysfs-schemes.c               |  4 ++++
> >>  mm/damon/vaddr.c                       |  3 +++
> >>  tools/testing/selftests/damon/sysfs.py | 11 ++++++-----
> >>  5 files changed, 19 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> >> index 838b14d22519..405142641e55 100644
> >> --- a/Documentation/mm/damon/design.rst
> >> +++ b/Documentation/mm/damon/design.rst
> >> @@ -467,6 +467,10 @@ that supports each action are as below.
> >>     Supported by ``vaddr`` and ``fvaddr`` operations set. When
> >>     TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
> >>     fail.
> >> + - ``collapse``: Call ``madvise()`` for the region with ``MADV_COLLAPSE``.
> >> +   Supported by ``vaddr`` and ``fvaddr`` operations set. When
> >> +   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
> >> +   fail.
> >>   - ``lru_prio``: Prioritize the region on its LRU lists.
> >>     Supported by ``paddr`` operations set.
> >>   - ``lru_deprio``: Deprioritize the region on its LRU lists.
> >> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >> index d9a3babbafc1..6941113968ec 100644
> >> --- a/include/linux/damon.h
> >> +++ b/include/linux/damon.h
> >> @@ -121,6 +121,7 @@ struct damon_target {
> >>   * @DAMOS_PAGEOUT:	Reclaim the region.
> >>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
> >>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
> >> + * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
> >>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
> >>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
> >>   * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
> >> @@ -140,6 +141,7 @@ enum damos_action {
> >>  	DAMOS_PAGEOUT,
> >>  	DAMOS_HUGEPAGE,
> >>  	DAMOS_NOHUGEPAGE,
> >> +	DAMOS_COLLAPSE,
> >>  	DAMOS_LRU_PRIO,
> >>  	DAMOS_LRU_DEPRIO,
> >>  	DAMOS_MIGRATE_HOT,
> >> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> >> index 5186966dafb3..aa08a8f885fb 100644
> >> --- a/mm/damon/sysfs-schemes.c
> >> +++ b/mm/damon/sysfs-schemes.c
> >> @@ -2041,6 +2041,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
> >>  		.action = DAMOS_NOHUGEPAGE,
> >>  		.name = "nohugepage",
> >>  	},
> >> +	{
> >> +		.action = DAMOS_COLLAPSE,
> >> +		.name = "collapse",
> >> +	},
> >>  	{
> >>  		.action = DAMOS_LRU_PRIO,
> >>  		.name = "lru_prio",
> >> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> >> index b069dbc7e3d2..dd5f2d7027ac 100644
> >> --- a/mm/damon/vaddr.c
> >> +++ b/mm/damon/vaddr.c
> >> @@ -903,6 +903,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >>  	case DAMOS_NOHUGEPAGE:
> >>  		madv_action = MADV_NOHUGEPAGE;
> >>  		break;
> >> +	case DAMOS_COLLAPSE:
> >> +		madv_action = MADV_COLLAPSE;
> >> +		break;
> >>  	case DAMOS_MIGRATE_HOT:
> >>  	case DAMOS_MIGRATE_COLD:
> >>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
> >> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> >> index 3aa5c91548a5..c6476e63f4fb 100755
> >> --- a/tools/testing/selftests/damon/sysfs.py
> >> +++ b/tools/testing/selftests/damon/sysfs.py
> >> @@ -123,11 +123,12 @@ def assert_scheme_committed(scheme, dump):
> >>              'pageout': 2,
> >>              'hugepage': 3,
> >>              'nohugeapge': 4,
> >> -            'lru_prio': 5,
> >> -            'lru_deprio': 6,
> >> -            'migrate_hot': 7,
> >> -            'migrate_cold': 8,
> >> -            'stat': 9,
> >> +            'collapse': 5
> > 
> > Comman is missed?
> > 
> >> +            'lru_prio': 6,
> >> +            'lru_deprio': 7,
> >> +            'migrate_hot': 8,
> >> +            'migrate_cold': 9,
> >> +            'stat': 10,
> >>              }
> >>      assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
> >>      assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
> >> -- 
> >> 2.43.0
> > 
> > Other than the selftest part, code looks good.  Please consider dropping RFC
> > tag from the next spin.  Clarifying more details about the test would be
> > helpful, though.
> > 
> > [1] https://docs.kernel.org/process/submitting-patches.html#commentary
> > 
> > 
> > Thanks,
> > SJ
> > 
> 
> SJ, should I remove the RFC tag for the next version?

If you feel comfortable with it, please do so.


Thanks,
SJ

[...]
