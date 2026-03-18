Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AA3DBD73
	for <damon@lists.linux.dev>; Wed, 18 Mar 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844918; cv=none; b=d1CvuoeWfMrRmN4weS52CFgBEZqq5ocwpuiCJCT/JSFmgKyJzjNVXWlRzXkKiC4etMj7f+53RvpuNoBTBrss6WGoHGimHMW347QQRiBXLLFlGTdHlL6oWPUOS7sgTGIXX0nXsVIycssPFX34Ml+8P6utYc420a5ItM/HzzD/RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844918; c=relaxed/simple;
	bh=5e8weDSY3ldu9AeUGisPGa9Ryj0nEXxqoClRV/0Qbn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sOPXtHiOl/mTxbpvfyNInSvhuKYIwmOkp5VPTO3Q3t1Ah58Ptq7VJDrxTi7QZ5dS4EXhCrLH1aghgAt+HkWxEOQuLOsp8RZhu32hZi5m2XTMvn4hpb8foRtgE9NAfxpYy7mY8/SgBZH4+yIpELOe66zZfZC/KtuK+eGSKZssr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbWjk2zqjzHnH7y;
	Wed, 18 Mar 2026 22:41:30 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 181334056A;
	Wed, 18 Mar 2026 22:41:52 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 17:41:51 +0300
Message-ID: <e51c09dc-81bd-441c-90ce-b973d21fe311@huawei-partners.com>
Date: Wed, 18 Mar 2026 17:41:50 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] mm/damon: support MADV_COLLAPSE via
 DAMOS_COLLAPSE scheme action
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <ljs@kernel.org>,
	<Liam.Howlett@oracle.com>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20260318005226.132181-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260318005226.132181-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 3/18/2026 3:52 AM, SeongJae Park wrote:
> On Tue, 17 Mar 2026 09:52:09 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>> Hi SJ,
>>
>> First of all, I just noticed that this was sent as v2 RFC, while
>> it should be v1. Bear in mind that the next series will also be
>> v2.
> 
> No worry :)
> 
>>
>> On 3/17/2026 3:32 AM, SeongJae Park wrote:
>>> Hello Asier,
>>>
>>> On Mon, 16 Mar 2026 18:38:05 +0000 <gutierrez.asier@huawei-partners.com> wrote:
>>>
>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>>
>>>> This patch set introces a new action: DAMOS_COLLAPSE.
>>>>
>>>> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
>>>> working, since it relies on hugepage_madvise to add a new slot. This
>>>> slot should be picked up by khugepaged and eventually collapse (or
>>>> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
>>>> enabled, khugepaged will not be working, and therefore no collapse
>>>> will happen.
>>>>
>>>> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
>>>> the address range synchronously.
>>>>
>>>> This new action may be required to support autotuning with hugepage as
>>>> a goal.
>>>
>>> Above all makes sense.  Thank you for posting this patch.
>>>
>>> Do you have some test results that you can also share together?  It would be
>>> nice if it can demonstrate the benefit of DAMOS_COLLAPSE over DAMOS_HUGEPAGE.
>> I will run some tests and benchmarks.
> 
> Looking forward to.
> 
>>>
>>>>
>>>> [1] https://lore.kernel.org/lkml/20260314165156.86647-1-sj@kernel.org/
>>>
>>> Seems the above link is just added by a mistake?  If not, please clarify.
>> Yes, it looks like I copied the wrong link.
>>>>
>>>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>> Reviewed-by: SeongJae Park <sj@kernel.org>
>>>> ---
>>>>  Documentation/mm/damon/design.rst | 4 ++++
>>>>  include/linux/damon.h             | 1 +
>>>>  mm/damon/sysfs-schemes.c          | 4 ++++
>>>>  mm/damon/vaddr.c                  | 3 +++
>>>>  4 files changed, 12 insertions(+)
>>> [...]
>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>>> index 3a441fbca170..6720dc70c487 100644
>>>> --- a/include/linux/damon.h
>>>> +++ b/include/linux/damon.h
>>>> @@ -140,6 +140,7 @@ enum damos_action {
>>>>  	DAMOS_PAGEOUT,
>>>>  	DAMOS_HUGEPAGE,
>>>>  	DAMOS_NOHUGEPAGE,
>>>> +	DAMOS_COLLAPSE,
>>>>  	DAMOS_LRU_PRIO,
>>>>  	DAMOS_LRU_DEPRIO,
>>>>  	DAMOS_MIGRATE_HOT,
>>>
>>> sashiko.dev adds [1] below comments.  Let me also add my comments in line.
>>>
>>> : This isn't a bug, but should a kernel-doc entry for @DAMOS_COLLAPSE be added
>>> : to the comment block above this enum?
>>>
>>> Makes sense.  'make htmldocs' may complain otherwise.  Asier, could you please
>>> add the kernel-doc comment for DAMOS_COLLAPSE in the next spin?
>> OK, I will split this patch into 2: one with the code and the other one with
>> the documentation.
> 
> Does the 'documentation' mean the change for 'design.rst'?  Or, the kernel-doc
> comment?  If that's the former case (separating 'design.rst' side change as
> another patch), that's completely good for me.
I meant the doc/mm/damon/design.rst
> 
> If that's the latter case (separating kernel-doc comment addition as another
> patch), that will make the commit trigger document build error, and the error
> will be fixed only after the followup commit is applied.  Please ensure keeping
> 'damon.h' side changes as a single patch, and therefore no warning or breaks in
> the middle of the patch series is introduced (and later fixed).
> 
>>> : 
>>> : Also, does inserting DAMOS_COLLAPSE here shift the integer values of the
>>> : subsequent enum entries like DAMOS_STAT?
>>> : 
>>> : The DAMON sysfs selftest script (tools/testing/selftests/damon/sysfs.py) uses
>>> : a hardcoded dictionary action_val to map string names to their integer enum
>>> : values.
>>> : 
>>> : If the enum values shift, the test's assertion:
>>> : 
>>> : assert_true(dump['action'] == action_val[scheme.action])
>>> : 
>>> : might fail when checking the struct memory via drgn. Could the python test
>>> : dictionary be updated to reflect the new values, or could the new action be
>>> : added at the end of the enum list?
>>>
>>> There is no test that uses DAMOS actions that defined after DAMOS_NOHUGEPAGE,
>>> so no real test will break.  But this is a good point.  It would be better to
>>> update the hard-coded value together.  Asier, could you also update the
>>> 'action_val' dict of assert_scheme_committed() function in
>>> tools/testing/selftets/damon/sysfs.py for the updated enum value in the next
>>> version?
>> OK, I will do it.
> 
> Thank you :)
> 
>>>
>>> [1] https://sashiko.dev/#/patchset/20260316183805.2090297-1-gutierrez.asier@huawei-partners.com
>>>
>>>
>>> Thanks,
>>> SJ
>>>
>>> [...]
>>>
>> Thanks for the feedback.
> 
> My pleasure.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

