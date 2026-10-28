Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167786;
	b=c6yIss1QXk34HagvdE+DA2fxfAZ6inbqlrNfM4g4QVRm6gBCpJ9cfkgf9zuYU1IC1XmW
	 aGxBSxpavcovsgNWcm/XEzmhY2OEZCkJYlloA7K9uKbLPLubGkyWWgjRvHoEzzTMjTaUA
	 tmAuJuGaHQtrVwFhhZG4NpKzUUmv8yPrEpkXIMBN13OUseTq5XiaLTfbJCu/6hZcv9i5o
	 asnTHS+rNZSsSrBkZXVKBp12zwMj9CbJ8zGRzrm5JIkGQkKl8Vods3RXkEKHG9gqM7H3M
	 sBLE0KaTyI7CUbhngofCKv5TjnuYO3b5GmPGfxyJfiS+ZiGYm7c/nk8GL1TJ0/WK0NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167786;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=W7W8QgouVJygAFTU/QOPQhBR1kM7Toq82huy2c/7CAk=;
	b=jKstE+LxIpgq/qmx1DNB+P6Et+pJbWw+Pb+Uh8DlRNRbqwQAl6YvryIIX2/yWYCYtCro
	 qmWi/Cq+jpEnEJ6aJdi8mlVkfbf36FNP4QDvUDGE+VxtEXwEF9ri8lcqneFa9ma3P95UW
	 LrtnsRk2vbxIdBEU4BxED6spg1X5fTR+VEEgi81H6u1fXZ5HQblRMlFpC1e4HtLYyX0cb
	 Lm0nMzlDGpAcRqzEYJqEzfXelC8IpILrzvNLO/22hB6Ta3CsQn+3gmsqphRkULR7aaDfd
	 r+V9HZNRJFpnkznoXwZMe7Z1/HzoN/T/mSOgecuR3JVqWpO2GFZ5arJfcUzIgx6dNUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2+1C75S9;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAC606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 06:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2+1C75S9
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W7W8QgouVJygAFTU/QOPQhBR1kM7Toq82huy2c/7CAk=;
	b=2+1C75S9OvsLz5K40sfJSzRlBYdU/BzYWI58tMpRIf+0f0ZK2cOZMkg2juReOBynHPHQxG8TR
	tTmeA6XyS7FmG29CW8JylZa5BKgFqpekjwBkELhjh5GoiGNjizS2oYUG38F/FqoFbE36Y/xgmF/
	PUeGEdiWDebD7k2wBkYX44Q=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jDxld6q7gz1cynb;
	Wed, 28 Oct 2026 14:09:33 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C6AE40586;
	Wed, 28 Oct 2026 14:09:40 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 14:09:40 +0800
Message-ID: <b0fb80cc-4a0d-4612-beef-bf2fc398f06e@huawei.com>
Date: Wed, 28 Oct 2026 14:09:39 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/reclaim: document how to
 disable watermarks
To: SJ Park <sj@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261028053525.155909-1-sj@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261028053525.155909-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/10/28 13:35, SJ Park 写道:
> On Tue, 27 Oct 2026 22:24:24 -0700 SJ Park <sj@kernel.org> wrote:
> 
>> Hello Jinjie,
>>
>> On Wed, 28 Oct 2026 10:36:28 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>> DAMON_RECLAIM runs its scheme only while the free memory rate is
>>> between `wmarks_low` and `wmarks_mid`.
>>>
>>> But some users want to reclaim cold pages even while the system has
>>> plenty of free memory, and it is not obvious that the existing
>>> watermarks parameters can already do that. So Document the setup.
>>
>> Thank you for this patch!
>>
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  Documentation/admin-guide/mm/damon/reclaim.rst | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
>>> index ec7e3e32b4ac..23fede7d1cdb 100644
>>> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
>>> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
>>> @@ -193,6 +193,13 @@ DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
>>>  watermarks.  In the case, the system falls back to the LRU-list based page
>>>  granularity reclamation logic.
>>>  
>>> +To keep DAMON_RECLAIM always active regardless of the free memory rate, set
>>> +``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
>>> +``0``, respectively.  Then the reclamation is limited only by ``min_age`` and
>>> +the quotas.  This is useful for reclaiming cold pages even while the system
>>> +has plenty of free memory, e.g., right after an idle virtual machine is
>>> +paused.
>>> +
>>
>> I feel like above might be too detailed.  Particularly, the second sentence
>> looks too detailed.  In a sense, it is not technically correct because of
>> 'skip_anon' parameter.  We might later need to add more such controls, and I
>> concern if this kind of detailed documentation will limit such extensions.
>>
>> What about keeping only the first sentence and dropping later two sentences?
> 
> If you don't mind, I could add this patch to damon/next after dropping the last
> two sentences on my own.

Hi SJ,

It is fine with me, thanks. Please go ahead.

> 
> 
> Thanks,
> SJ
> 
> [...]

-- 
Best regards,
Jinjie

