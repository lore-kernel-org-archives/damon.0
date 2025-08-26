Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66996481CD;
	Tue, 26 Aug 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218117; cv=none; b=qzCFbm1zlAFqBQLPrI7FYgM1J8WynW+PqvuxjRugHM7foSy7oLs63vXVMh9yYpq+Q9SS43lVAH/nAXmoSLQ4/ynn4kKYzUnqjNtpo3iZO3FdFY8K8gNM+r7Xn7acI5tVnIFb7cJKV3Cq0zTl+7imlxn1Cmayl63b3CWQHMwRN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218117; c=relaxed/simple;
	bh=feW4U7ohinlgGVmRvgwizm/FFoHAZFSnfVYUwDEFhBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhN2069v6yQQWIU17U0/Aatrgje+I6u7J5jP9QX6snVRoSMRFYtDazjXjMrvkUFv+p7N2THIYtIA5q5YDNyC2BBPKMGN+XV3uhKLv0ZXUSi8hTnXw3J1crdtcno9DxR5kbn3KcDbadBRcYIrm9ulCHjZlG/DG38CsZ1oXweXHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnGD6shU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnGD6shU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07367C113CF;
	Tue, 26 Aug 2025 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218117;
	bh=feW4U7ohinlgGVmRvgwizm/FFoHAZFSnfVYUwDEFhBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnGD6shUMLWWB5w8MDuseZc3fub+Aj7VB6CmQ6avNhIIPUXCDje46h8Ed98L/xoan
	 n9/X7AqowrCMgyKT3JxEmVmjch50OqqC6ALGG9Q2Avly66fyf8ZImxO9IW0ELG26lz
	 kO/Vu1sk59Vv1H/Li9opDxRDCJRhANo7x8DE1rkPUUUPtrJXCxDOr9rJTm4pImdO4I
	 Yjk9DsQRrf9Tn0ZnNIdxxlP+bMLcsJEOwpqDNKICO0N+LcrJ6sJidPs6wl2UrS79YX
	 XcorS7q08TZ8dUqZB3ZsH2qYqPBTu4MFuc+PJiqpBMJr4zrSOKrEx+B4pg0JvWrVUL
	 7W9dHkbDzzaBQ==
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
Date: Tue, 26 Aug 2025 07:21:55 -0700
Message-Id: <20250826142155.53632-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <464f9f46-6ed5-4a78-8e06-878869f2afc4@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 12:51:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Hi SJ,
> 
> 在 2025/8/26 11:21, SeongJae Park 写道:
> > [...]
> >
> >>> ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
> >>>   From hackermail Thu Jan  1 00:00:00 1970
> >>> From: SeongJae Park <sj@kernel.org>
> >>> To: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: SeongJae Park <sj@kernel.org>
> >>> Cc: damon@lists.linux.dev
> >>> Cc: kernel-team@meta.com
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Cc: linux-mm@kvack.org
> >>> Date: Mon, 25 Aug 2025 07:41:33 -0700
> >>> Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
> >>>            return value
> >>>
> >>> Otherwise, __udidi3 linking problem happens on certain configs.
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
> >>> Signed-off-by: SeongJae Park <sj@kernel.org>
> >>> ---
> >>>    mm/damon/paddr.c | 14 +++++++++++++-
> >>>    1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >>> index 5fad2f9a99a0..09c87583af6c 100644
> >>> --- a/mm/damon/paddr.c
> >>> +++ b/mm/damon/paddr.c
> >>> @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
> >>>    	return false;
> >>>    }
> >>>    
> >>> +/* convert physical address to core-layer address */
> >>> +static unsigned long damon_pa_core_addr(phys_addr_t pa,
> >>> +		unsigned long addr_unit)
> >>> +{
> >>> +#ifdef __i386__
> >> Can we use the following condition instead?
> >>
> >> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
> > To my understanding, this issue happens only on i386, not every 32bit
> > architectures.  So I think i386 specific condition is better.
> 
> I understand. However, the aforementioned general condition is essential,
> and we should propose a new patch to address this. After introducing addr_unit,
> any 32-bit architecture should support monitoring of 64-bit phys_addr_t.

The issue is that we cannot divide 64bit values with plain '/' operator on
"i386", and hence this patch makes it to use do_div() instead of '/' on "i386".
No such or other problems at supporting 64-bit phys_addr_t is found on other
32bit architectures, to my understanding.  My understanding is that at least
you confirmed that on your arm-based test environment.  So we don't need a new
patch to my understanding.

Am I missing somthing?


Thanks,
SJ

[...]
