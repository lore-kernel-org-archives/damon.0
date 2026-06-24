Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4D2DAFCB
	for <damon@lists.linux.dev>; Wed, 24 Jun 2026 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300194; cv=none; b=W4PpGixMHHqyH+aCTrozd5u1lmNd37UHDqH5GXZ/aHcSYldJZ5RTE+2SOKDzvZxZNBWxJy6ZiHcthN44u0tjIwhvKUG50N7tucEmXTgbLvoVK4kMePgZaN/6kioOTy9vQVnz46KXeuZf5gEr7Xih2gHPjAhp8awQp8t/McVYjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300194; c=relaxed/simple;
	bh=m5g8Ivr73tCK84dznPafxj6EpMaAUfm1GvFUg8Q4iOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z2vIsVFChoEHwxRxd8Cn1YWzZXYirFTidEhpz1vSqsKC4bzy12R7KAdGuTyaYnnoiN6jLkwz0zOpFQBQAvJNO2L4JXuW8r02Q/tyIUM7RLRbd9ydclseqYBjvyHGd5/e/lSmip9x/aIZOrJSubup7EMzYYMSO2mRDmkgJjnYeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=p26qdZbB; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="p26qdZbB"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GasGCMkpqsIfVRcBaW6bgI7a5DEAvqZjljpM0MMljkg=;
	b=p26qdZbBK7+67oTpFgKBqJ3oBUDKLNh5aZ1m8FS9MTuXBCHiRdW81JTcl4N03FDRSm8g6TMcH
	qqnijijEnCSX9wv8ejoUIE5BnX0Yd70asQsWAJqnvaEfYcN3adfLOUjwhbGL0k3+cJI5k4+7fjK
	tQnoa4PYwpY9zT1Fp0AVKc4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4glfT341j1zRhSH;
	Wed, 24 Jun 2026 19:13:59 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id A29152012A;
	Wed, 24 Jun 2026 19:23:03 +0800 (CST)
Received: from [10.174.179.37] (10.174.179.37) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 19:23:02 +0800
Message-ID: <a9018e68-866a-c251-9e0a-67e31f4baec2@huawei.com>
Date: Wed, 24 Jun 2026 19:23:02 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: Ravi Jonnalagadda <ravis.opensrc@gmail.com>, <akinobu.mita@gmail.com>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<akpm@linux-foundation.org>, <corbet@lwn.net>, <bijan311@gmail.com>,
	<ajayjoshi@micron.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
References: <20260624001425.77489-1-sj@kernel.org>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20260624001425.77489-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi SeongJae,

On 2026/6/24 8:14, SeongJae Park wrote:
> Hello Zeng,
> 
> On Tue, 23 Jun 2026 22:08:03 +0800 Zeng Heng <zengheng4@huawei.com> wrote:
> 
>> Hi Ravi,
>>
>> On 2026/5/30 0:56, Ravi Jonnalagadda wrote:
>>> This series introduces a vendor and PMU-agnostic substrate inside DAMON
>>> that consumes hardware-sampled access reports through the standard
>>> perf-event interface.  Userspace selects the PMU through sysfs (raw
>>> type/config knobs), driving either Intel PEBS L3-miss sampling or AMD
>>> IBS Op sampling.
>>>
>>
>> [...]
>>
>>>
>>> Ravi Jonnalagadda (6):
>>>     mm/damon: add struct damon_perf_event{,_attr} and per-ctx perf_events
>>>       list
>>>     mm/damon/sysfs-sample: expose perf_events configuration via sysfs
>>>     mm/damon/sysfs: install perf_events on apply
>>>     mm/damon/core: per-CPU SPSC ring drain and damon_perf_event lifecycle
>>>     mm/damon/vaddr: implement perf-event access check
>>>     mm/damon: add damos_node_eligible_mem_bp tracepoint
>>>
>>>    include/linux/damon.h        |  80 +++++
>>>    include/trace/events/damon.h |  49 +++
>>>    mm/damon/core.c              | 403 ++++++++++++++++++++----
>>>    mm/damon/ops-common.h        |  39 +++
>>>    mm/damon/sysfs-common.h      |   6 +
>>>    mm/damon/sysfs-sample.c      | 579 +++++++++++++++++++++++++++++++++++
>>>    mm/damon/sysfs.c             |   3 +
>>>    mm/damon/vaddr.c             | 267 ++++++++++++++++
>>>    8 files changed, 1370 insertions(+), 56 deletions(-)
>>>
>>>
>>> base-commit: 4c8ad15abf15eb480d3ad85f902001e35465ef18
>>
>> I wasn't able to apply this patch series to the linux (and linux-next)
>> mainline branch, and also had trouble identifying the source of the base
>> commit.
>>
>> Would you mind sharing where this baseline is from?
> 
> TLDR: I pushed [1] a tree having this series applied on top of the baseline to
> GitHub.  Please feel free to use it.
> 
> I think the baseline was a commit on damon/next tree [2].  Because damon/next
> is continuously rebased, we cannot get the commit in a simple way.  Fortunately
> the commit is still available on my local tree.  So I applied this patch series
> on top of the commit and pushed [1] to a branch of DAMON kernel tree at GitHub.
> 
> Note that the branch is not guaranteed to exist there for long term.  But
> hopefully this series will be merged into the mainline before that.
> 
> [1] https://github.com/damonitor/linux/tree/ravi_hw_sampled_access_reports_rfc_v1
> [2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> 
> 
> Thanks,
> SJ
> 

Thanks a lot for providing the branch on GitHub. I've pulled it and
confirmed it builds cleanly on my end.

Appreciate the help!


Best Regards,
Zeng Heng
