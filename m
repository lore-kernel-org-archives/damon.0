Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E543D6CAA
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539735; cv=none; b=lZUGz/kouRA9aCU7pNZAfvXySn8oSec92sIi0FEVUbh2tnxpneSZqZ6ccf+Vgwx22qkabgJvDtvIsYmenpYHqkyHFh9OFiOZ3x4G7WaQCyKQ0PYf5kcl796jSDIj3iud5H+mewjoddUTLNANDK2+BMSjOW6lizE8Ft8Qxv/f+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539735; c=relaxed/simple;
	bh=N+H5FUd+DJ1KPc1+uGEeoXAi0iso0vSoevuGkotyq5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VcAjevpSKmTE7sG+ibIFtXp/F3LMP3uW5vDo/OOmrRh156m0mLfZD7dIHy5XL1izbZ5KZed+RbbjuUUQwUvVmSImWHW8yFuIHdBV5KEPiMQ0toW/MW0NP08rzXCtEjghSZ1mztiGO7mfWqc5+0OIGpUUWllBW9maIN3aW98/tlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=lhrVe85S; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="lhrVe85S"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XUHwliFvt2Gn1hvyINNY2v9lEgIqckSiVz0mxRwlukg=;
	b=lhrVe85So4F1nplZW+dS/HTMHu+U35OXYXBpcPmRehHDm2a6Xzp3Cfh7CM2JvmaKbds49NOZW
	vxw/Tk4YSp+PzrC17MFdk3bHk2bwiptUEupYUTPHhWhmhWMptG7I5GrhnWqhju5sCKWuvc2O8gu
	Qg0b4pF8stRNZ0xNioPPvyU=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h3Zv71bMmzHnH55;
	Mon, 20 Jul 2026 17:28:19 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AF654058D;
	Mon, 20 Jul 2026 17:28:41 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 12:28:40 +0300
Message-ID: <a168a9f2-953b-4ecb-98ee-ec6b27f4d963@huawei-partners.com>
Date: Mon, 20 Jul 2026 12:28:40 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
To: Lian Wang <lianux.mm@gmail.com>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <npache@redhat.com>,
	<ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>, <ryan.roberts@arm.com>,
	<daichaobing@sangfor.com.cn>, <wangkefeng.wang@huawei.com>,
	<zengheng4@huawei.com>, <kasong@tencent.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <lianux.wang@processmission.com>,
	<kunwu.chan@linux.dev>
References: <20260720030327.80153-1-lianux.mm@gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260720030327.80153-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi Lian,

On 7/20/2026 6:03 AM, Lian Wang wrote:
> DAMOS_SPLIT splits large folios in a target region down to a
> configured target order, using the existing split_folio_to_order().
> No new core-mm code or exported symbols are introduced.
> 
> Based on mm-unstable at 61cccb8363fc ("mm/swap, PM: hibernate:
> atomically replace hibernation pin").
> 
> Different addresses within a PMD-mapped folio resolve to the same
> PMD Accessed bit.  Accesses to a small part of the folio can
> therefore coarsen DAMON's observed hot set relative to the actual
> working set.
> 
> DAMOS already provides promotion actions (HUGEPAGE, COLLAPSE) but
> has no corresponding demotion action.  DAMOS_SPLIT fills this gap.
> It is a mechanism, not a policy -- it does not decide which folios
> to split.  Selection is left to DAMON's existing access patterns,
> filters, and future probe/PMU signals.
You should mention why page split is be needed. The fact that page
collapsing exist doesn't necessarily mean that split should exist.

I agree that it is a nice feature, but it should be backed in the
cover letter.
> target_order selects the split target: 0 for order-0 base pages,
> or a supported smaller mTHP order.  Both anonymous and file-backed
> folios are supported.  The locking follows split_huge_pages_in_pid()
> in mm/huge_memory.c.
> 
> Tests
> =====
> 
> damos_split.py (VM + Kunpeng 920):
>   anon THP -> order-0 split: PASS
> 
> sangfor_exp.py (Kunpeng 920, tmpfs, 4096 MiB):
> 
>   - Created a 4 GiB PMD-mapped tmpfs workload.
>   - Applied DAMOS_SPLIT with target_order=0.
>   - ShmemPmdMapped dropped from 4194304 KiB to 0 in every round.
>   - Repeated for five rounds without functional failures.
> 
> The functional selftest (damos_split.py) is included in this series.
> Additional experiment scripts and raw results are available on
> request.  Performance characterization using masim [1] and KMB [2]
> is in progress.
> 
> [1] https://github.com/sjp38/masim
> [2] https://gitee.com/OpenCloudOS/kernel-multi-bench
> 
> Open questions
> ==============
> 
> - Selection policy: this series keeps folio selection outside the
>   action and relies on DAMOS access patterns, filters, and quotas.
>   Is this the appropriate layering for future probe-based signals?
> 
> - Hysteresis: khugepaged may re-collapse a just-split folio.
>   Should cooldown live in DAMON policy or khugepaged?
> 
> - File-backed folios: adjust target_order upward to filesystem
>   minimum, or keep current "fail and skip"?
> 
> Beyond the action API itself, feedback on real workloads that need
> proactive large-folio demotion is particularly welcome.  Follow-up
> work will evaluate candidate selection signals, including DAMON
> probes and hardware-assisted sampling, as well as target-order
> selection and split/collapse hysteresis.  Those policies are
> intentionally kept outside this series.
> Changes since v2 [3]
> ====================
> 
> - Split-only series (collapse deferred).
> - Dropped SPE feedback (mechanism/policy separation).
> - DAMOS_MTHP_SPLIT -> DAMOS_SPLIT.
> - order field in existing union (no struct size increase).
> - Added functional selftest (damos_split.py).
> - checkpatch: 0 errors, 0 warnings.
> 
> [3] https://lore.kernel.org/20260701123000.00000-1-lianux.mm@gmail.com/
Could you add v1 as well?
> 
> Lian Wang (Processmission) (3):
>   mm/damon: introduce DAMOS_SPLIT action
>   mm/damon/vaddr: implement DAMOS_SPLIT handler
>   selftests/damon: add functional test for DAMOS_SPLIT
> 
>  .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
>  Documentation/mm/damon/design.rst             |  5 +
>  include/linux/damon.h                         | 15 ++-
>  mm/damon/core.c                               |  2 +
>  mm/damon/sysfs-schemes.c                      | 48 +++++++
>  mm/damon/vaddr.c                              | 90 +++++++++++++
>  tools/testing/selftests/damon/Makefile        |  1 +
>  tools/testing/selftests/damon/_damon_sysfs.py |  9 +-
>  tools/testing/selftests/damon/damos_split.py  | 99 +++++++++++++++
>  tools/testing/selftests/damon/sysfs.py        | 11 +-
>  10 files changed, 279 insertions(+), 8 deletions(-)
> 

-- 
Asier Gutierrez
Huawei

