Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE22D24B2;
	Wed, 27 Aug 2025 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262567; cv=none; b=KMRPyBMT4LlO/5JxU762221vReho/CULk2Szf322LZaOgvsSx5b8zDqdrMhk+Eog1BzIFWn9NF7zy2upalOBFvcjQeTgYxpIO8OxTWVV+YdodgkwufW3MmApQJNcnzxpKKxF0bA/iS4eW/NzKXXv4TFYkYDcN+Ah/HC7XD5Tjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262567; c=relaxed/simple;
	bh=5F9aykt8eK0WG+hcHahSzeOf9LKNCcllQsRTkdWNiSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTc5h1bLmyG9cQGQBP0y/TNuQGps2Bap4pIk+2IaRMDZsJFwv7J0YSIrL1/BjogL/T02TODBgHV6L4UAqYExU+vfE2vLMkw0pS4D+JcVSnAIzZIYY34GHiEGcBOW+IqOEDNCRtXeMKOCMHNtVlfHxncwkjzdBrmLn8SnXcuPbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp6Jz1NV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp6Jz1NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8077DC4CEF1;
	Wed, 27 Aug 2025 02:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756262566;
	bh=5F9aykt8eK0WG+hcHahSzeOf9LKNCcllQsRTkdWNiSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hp6Jz1NVTn+W6ZZo3gfoxOP0Lrh23qMpSGMhrs95ozCXNlHVoiwJngSB4hiLQp+v7
	 ioKOKNuxYFYucbsa7dy9ZylMsrFeUGgssTibfWCBLn4aRRP98S2et+T01XDSmFdKYW
	 oJ7e+2Yy9T6gsbBaz8qc0vYiEe+a4LicRC3MvYwGWa9JzvLgNtEX1/p//UjmwmIWmY
	 tQrWptpPE3JYIUPXl36urLIEfQPnEcRv3L8YmzR05TjCLNp7sp2FVvb4vG/aOo2m8k
	 wodJUPWoCq8Og3Mdtn72FU5mLG/iIc6tcB6XaFvMLYFRkae/cxJ7yF4CfXxU+/ALIR
	 DQWvmezYb6Bcw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Tue, 26 Aug 2025 19:42:44 -0700
Message-Id: <20250827024244.58979-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c8c3d0d5-e9e1-44de-8722-1e7d09786b51@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 10:21:41 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> 
> 在 2025/8/26 22:21, SeongJae Park 写道:
> > On Tue, 26 Aug 2025 12:51:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >
> >> Hi SJ,
> >>
> >> 在 2025/8/26 11:21, SeongJae Park 写道:
> >>> [...]
> >>>
> >>>>> ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
> >>>>>    From hackermail Thu Jan  1 00:00:00 1970
> >>>>> From: SeongJae Park <sj@kernel.org>
> >>>>> To: Andrew Morton <akpm@linux-foundation.org>
> >>>>> Cc: SeongJae Park <sj@kernel.org>
> >>>>> Cc: damon@lists.linux.dev
> >>>>> Cc: kernel-team@meta.com
> >>>>> Cc: linux-kernel@vger.kernel.org
> >>>>> Cc: linux-mm@kvack.org
> >>>>> Date: Mon, 25 Aug 2025 07:41:33 -0700
> >>>>> Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
> >>>>>             return value
> >>>>>
> >>>>> Otherwise, __udidi3 linking problem happens on certain configs.
> >>>>>
> >>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
> >>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
> >>>>> ---
> >>>>>     mm/damon/paddr.c | 14 +++++++++++++-
> >>>>>     1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >>>>> index 5fad2f9a99a0..09c87583af6c 100644
> >>>>> --- a/mm/damon/paddr.c
> >>>>> +++ b/mm/damon/paddr.c
> >>>>> @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
> >>>>>     	return false;
> >>>>>     }
> >>>>>     
> >>>>> +/* convert physical address to core-layer address */
> >>>>> +static unsigned long damon_pa_core_addr(phys_addr_t pa,
> >>>>> +		unsigned long addr_unit)
> >>>>> +{
> >>>>> +#ifdef __i386__
> >>>> Can we use the following condition instead?
> >>>>
> >>>> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
> >>> To my understanding, this issue happens only on i386, not every 32bit
> >>> architectures.  So I think i386 specific condition is better.
> >> I understand. However, the aforementioned general condition is essential,
> >> and we should propose a new patch to address this. After introducing addr_unit,
> >> any 32-bit architecture should support monitoring of 64-bit phys_addr_t.
> > The issue is that we cannot divide 64bit values with plain '/' operator on
> > "i386", and hence this patch makes it to use do_div() instead of '/' on "i386".
> > No such or other problems at supporting 64-bit phys_addr_t is found on other
> > 32bit architectures, to my understanding.  My understanding is that at least
> > you confirmed that on your arm-based test environment.  So we don't need a new
> > patch to my understanding.
> >
> > Am I missing somthing?
> 
> This is because I seem to have made a mistake earlier: I adjusted the local
> compilation toolchain. When the __udivdi3 issue mentioned above occurred, it
> reminded me of a potential problem. After switching to a completely new environment
> for testing, I discovered the __aeabi_uldivmod linking error in arm, which is similar
> to the __udivdi3 issue.🙁

Thank you for sharing this.  Then I agree the current fixup is insufficient.

Andrew, could you please drop this patch series from mm tree for now?  I will
further discuss with Quanmin about the proper fix and post next version of this
series with the proper fixup.

> To prevent similar environment-related problems in the
> future, I suggest adjusting the condition to the following:
> 
> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
> 
> Please consider approving this fix.

I'm yet in travel, and I'd like to take more time on thinking about the proper
fix.  Quanmin, could you share more details about your test setups, both for
the compiling success case and failing case?


Thanks,
SJ

[...]
