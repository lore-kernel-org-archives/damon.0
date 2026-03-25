Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD91DE3DB;
	Wed, 25 Mar 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402201; cv=none; b=UzjF9Wtlca0ywLZarlHXxj+cPjB72meRF79YJK173GlmJvdW3KAmRsf4KrHO9VGl43Fiybh69z1BGAyarWL+aDVmNm6VFU+bTmyfgCftFt21dOhOZVnFcCYC61LDqchvpGsnUaC1LsebkeiPP2vzmlVj7TFky1K7Th2qLmaHzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402201; c=relaxed/simple;
	bh=5SbBFDgIR67bL1d5NEGk//PNELzmL89PM+jsBTcyznw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7wZojKPysznIVSghyZIcFv427RN1z9/yRAEaR5OU1LfPcCK7iTuxQYjpXpvXbWQmNm/rpPc0fF/yyxS7n4WmmLobWvay5FpqIg8by5HKPkRCYW4SRm77JnAYNFU91ngpWPUD6lc1EyxklA/7FEdQRHI/LCGEiXyCF0uq+Gi2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a757H79L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a757H79L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F3EC19424;
	Wed, 25 Mar 2026 01:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774402201;
	bh=5SbBFDgIR67bL1d5NEGk//PNELzmL89PM+jsBTcyznw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a757H79Li4IBGL1ALHzdgXLsUTHiTqglD9EdIalBAY+hP+BAUeddSjXsAlrkiFi13
	 EIggSReE8akulpv/CyWmPxpcf7tpSOkE+B1FP6fXiX9qUXTPSEzpb6GG/zIYhBdUq6
	 vNEFD2neVHf+Xl5mrjiJ+LZc5IlVzWIjNeKOxGGOJY9K8JvxYfPEBL/CqoIrgt3JT/
	 TwnAorebRYKCIOguye8khPH5fWqF7aD689ZtIJrnMjOy4Q4GYpSs9u/4Nam8dxtXMx
	 1JL7bErJSHbzRP1/zaNtgG1YFEL1qIxpAjf4GPM+BedeMPhk+L+oPO9Fpa+sIbinrD
	 ZXjDhTc7H5feQ==
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
Date: Tue, 24 Mar 2026 18:29:53 -0700
Message-ID: <20260325012954.85785-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a07479d-0ddb-442e-bc1b-027f4c6d3b77@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 18:01:23 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 3/24/2026 5:12 PM, SeongJae Park wrote:
> > On Tue, 24 Mar 2026 16:57:22 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >>
> >>
> >> On 3/24/2026 3:39 AM, SeongJae Park wrote:
> >>> Hello Asier,
> >>>
> >>> On Mon, 23 Mar 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> >>>
> >>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>>
> >>>> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> >>>> working, since it relies on hugepage_madvise to add a new slot. This
> >>>> slot should be picked up by khugepaged and eventually collapse (or
> >>>> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> >>>> enabled, khugepaged will not be working, and therefore no collapse
> >>>> will happen.
> >>>>
> >>>> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
> >>>> the address range synchronously.
> >>>>
> >>>> This new action may be required to support autotuning with hugepage as
> >>>> a goal[1].
> >>>>
> >>>> [1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
> >>>>
> >>>> ---------
> >>>> Benchmarks:
> >>>>
> >>>> T n: THP never
> >>>> T m: THP madvise
> >>>> D h: DAMON action hugepage
> >>>> D c: DAMON action collapse
> >>>>
> >>>> +------------------+----------+----------+----------+
> >>>> |                  | T n, D h | T m, D h | T n, D c |
> >>>> +------------------+----------+----------+----------+
> >>>> | Total memory use | 2.07     | 2.09     | 2.07     |
> >>>> | Huge pages       | 0        | 1.3      | 1.25     |
> >>>> +------------------+----------+----------+----------+
> >>>
> >>> Thank you for sharing the benchmark results!  But, I'm having a hard time to
> >>> understand what this really means.  Could you please further clarify the setup
> >>> of the benchmarks and interpretation of the results?
> >> I will fix the cover in the next version, which I will submit soon.
> >>
> >> I tested the patch in a physical server with MariaDB 10.5. I run
> >> sysbench to load the server.
> >>
> >> I check 3 scenarios:
> >> - DAMON action hugepage for the database task, THP as never
> >> - DAMON action hugepage, THP madvise
> >> - DAMON action collapse, THP never
> >>
> >> I compared the memory consumption, both in overall in the server and
> >> anonymous huge page consumption. The results are in the table
> >>
> >> T n: THP never
> >> T m: THP madvise
> >> D h: DAMON action hugepage
> >> D c: DAMON action collapse
> > 
> > Thank you for sharing the details of the setup, Asier.
> > 
> >>
> >> +------------------+----------+----------+----------+
> >> |                  | T n, D h | T m, D h | T n, D c |
> >> +------------------+----------+----------+----------+
> >> | Total memory use | 2.07     | 2.09     | 2.07     |
> >> | Huge pages       | 0        | 1.3      | 1.25     |
> >> +------------------+----------+----------+----------+
> > 
> > Could you please further share interpretation of the results?  What these
> > results mean?  Does it show some benefit of DAMOS_COLLAPSE?
> 
> In the first row is the total memory consumption in GB by the server
> and in the second row the huge page consumption.
> 
> What this table shows is that DAMON action "hugepage" doesn't lead
> to any hugepage collapse unless THP is set to madvise. If DAMON
> action is set to "collapse", hugepage collapses happen, even when
> THP is disabled. The memory consumption for DAMON "collapse" is
> slightly lower than with "hugepage", since madvise applies to the
> entire server and other application may request to collapse pages
> through madvise.
> 
> Regarding the performance, I saw improvement from no hugepage at all
> to use of hugepages. No significant difference between "hugepage" and 
> "collapse" actions. I will have a look to the logs and publish it a bit
> later.

Makes sense, thank you for clarification Asier!

So this result shows the functionality well.  Meanwhile, it doesn't clearly
show performance gain.  Given the small size of the change and rationale of
MADV_COLLAPSE that I believe explored when it was introduced, I think this test
result is also good.  I wouldn't strongly require more tests for this patch.

That said, if you find some more interesting thing from logs, please share, by
or after the next version of this patch.


Thanks,
SJ

[...]
