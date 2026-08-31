Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D21374E45;
	Mon, 31 Aug 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206436; cv=none; b=OnzmsUfCJPe/+S0mjJIv26WrrpntRda/zmGaJ+IoQwEa84CgjXdmSDRcrmdknIJfjCHmGGsw+cHJG7vJxy8GgMj4Xw4QNf229HNcg2J8STUYDWpC4prlM+TxwgLyNlSAHp9zeGpbQHHhCdRymN+p10nEWdK2apAlzO7WoQeZJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206436; c=relaxed/simple;
	bh=n4hgCmenkUA0yQOe4qWvt357tiWyOedxqXVmXIH3JaI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fa1onnPWN8G2CWpUnv9ex5Tb0KMr+0EnvsZxOdrhVuaPgNcsHetxSbHhY5jo36KjVjtvg1OxUrjFrJBQlxE3xY0KVuQBtIkvBzI1aikjR6yeZH32RHMpwQA4Hj6mcBaXu2gLIPPFnoe3IrtYfzTOyTaxf7BNPmcYt8tUG8LYQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pU1g/ni1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pU1g/ni1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KD9yzIj2ChMKwwwuCxZ07mabXpAm8XFsPfqRMa8Gidg=; b=pU1g/ni1Q8VNIKWqixQp9DPlLZ
	RKgJ0VTCZG5/fQTqCP+E9gZrN7JP4xCLRo4D2f9ZMwAC3fa1MZ0YWZRIjB4u3+erb45GAWOXHh37K
	rNuE8d3hCyyAFLK5sLT2rmU/qwd3B6D/1j4p1PHPVDkNOPBWk+9uuP7oCwCY0zG2f9bdQf5XkLEqB
	eMrocPSb+a/chLMvccv29MFIUR9jyjJiNroXmQczR3R33TLmnJVeVH4nw4rEXNNYizALXhpsSBPT5
	9XOYC4VKFBPb3EAx7t750pksfaChxOEanXTp/7+i8F3k+S9c6xS+DO5ZmrEsKg0cmnW17PIkEUVCn
	xkvIsPvw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x18BA-0000000APTS-3Euq;
	Mon, 31 Aug 2026 20:00:28 +0000
Message-ID: <107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infradead.org>
Date: Mon, 31 Aug 2026 13:00:26 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp
 target metric
From: Randy Dunlap <rdunlap@infradead.org>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260831144732.80910-1-sj@kernel.org>
 <20260831144732.80910-4-sj@kernel.org>
 <f06ca3de-1cd9-4082-8c66-f6a26e417824@infradead.org>
Content-Language: en-US
In-Reply-To: <f06ca3de-1cd9-4082-8c66-f6a26e417824@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/26 8:45 AM, Randy Dunlap wrote:
> Hi,
> 
> On 8/31/26 7:47 AM, SJ Park wrote:
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Document hugepage_mem_bp metric exposed by sysfs.
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> Reviewed-by: SJ Park <sj@kernel.org>
>> Signed-off-by: SJ Park <sj@kernel.org>
>> ---
>>  Documentation/mm/damon/design.rst | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
>> index aed6cb1cf4831..a8c163475ef2b 100644
>> --- a/Documentation/mm/damon/design.rst
>> +++ b/Documentation/mm/damon/design.rst
>> @@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
>>    bp (1/10,000).
>>  - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
>>    of a node in bp (1/10,000).
>> +- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
>> +  (1/10,000).
>>  
>>  ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
>>  ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
> 
> I've looked thru the entire design.rst file and cannot find anything telling
> me (or anyone) what "bp" means.  Explain??

OK, I found it on the internet. I still think that it would be a
good idea to say "basis point" one time (the first time that it is used).


-- 
~Randy

