Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E5BA2E
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750648600; cv=none; b=BQZW5xBwN76BirKdTMwVKfGvUGCnlxJ26dv56Sy5/xj7nyaea0BOR/nPZG21M3ChCG/L7m+v0u5NQ+S9dseH3PM4Yq31HrFx0SF/2hsrEqiTI+UwwlUkNrxYKzBzJe7qWQMIFbP6wdLwll9AYh/H5BVb54G7f9HF/zD60WAasig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750648600; c=relaxed/simple;
	bh=KmF5tiOONkkcQoUwxxjWSXuK9OuVaPphSQ95ha2unyA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vrxn/PlHNzbQV324elU/7Pg9GpzMQHBw7Tiw59l27sfRLiBaKCIk2lIUkqjolJK7kjSHZjkaoqVwoa6/yfB0SAtkKLRX8Vsl3j3izjM4J65TB0UtSPNDWeImTIbHfSYzphfCSrS2emZM0pbchYCxvNXJZdb5YUwA8gLd9/yEbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-55-6858c7100f23
Message-ID: <f6739a52-eb5e-4a88-9796-b53f18869059@sk.com>
Date: Mon, 23 Jun 2025 12:16:32 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 3/3] samples/damon: fix bugs for damon sample for start
 failures
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250622162935.51108-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250622162935.51108-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnoa7A8YgMgylNUhZz1q9hs3jy/zer
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9Tsz4zeLxYvNMxgCWKC6blNSczLLUIn27BK6M3mWL
	mAr2S1d8mfqLqYHxjmgXIyeHhICJRM/7/Uww9vGG7cwgNq+ApcSsLXPAbBYBVYn2o5NZIOKC
	EidnPgGzRQXkJe7fmsEOYjMLzGSUeHOKB8QWFgiTmLhiOxtEXERidmcb2BwRAUWJc48vsoLY
	QgJGEgfnbADrZRNQk7jychLYDZwCxhL9H64yQfSaSXRt7WKEsOUltr8FuYcL6M4FbBL9Jxew
	QBwtKXFwxQ2WCYyCs5DcNwvJ7llIZs1CMmsBI8sqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMBA
	X1b7J3oH46cLwYcYBTgYlXh4E3giMoRYE8uKK3MPMUpwMCuJ8B5yCssQ4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwOjF42Tm4Pl70uKUDck2xh+nVOi9
	+M5zQv1m/69vJw5VszeuerPgwaToiI/TtnBMe/t9/cyGvi7nLV+nSWyymyB184H0kd7qqYYL
	d7dEMfo4WX+r3ria7S57Nkv52ne5c+Y13F7Ptf/fTtvMjed7Uvwt5y7P2BPJ1BNi+uaE6m6G
	GRMCnnzUvLpSiaU4I9FQi7moOBEArtq7pXACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXCNUNLT1fgeESGwe99vBZz1q9hs3jy/zer
	xeG5J1kt7q35D2R9fcNk8XvbCjYHNo9NqzqBxKdJ7B4nZvxm8XixeSajx7fbHh6LX3xgCmCL
	4rJJSc3JLEst0rdL4MroXbaIqWC/dMWXqb+YGhjviHYxcnJICJhIHG/Yzgxi8wpYSszaMgfM
	ZhFQlWg/OpkFIi4ocXLmEzBbVEBe4v6tGewgNrPATEaJN6d4QGxhgTCJiSu2s0HERSRmd7aB
	zRERUJQ49/giK4gtJGAkcXDOBrBeNgE1iSsvJzGB2JwCxhL9H64yQfSaSXRt7WKEsOUltr+d
	wzyBkW8WkjNmIVkxC0nLLCQtCxhZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG8rLaPxN3
	MH657H6IUYCDUYmHd4V3RIYQa2JZcWXuIUYJDmYlEd5DTmEZQrwpiZVVqUX58UWlOanFhxil
	OViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYxXklwneVmuM43yX7Axy1tuT6yPK/elW/cX
	T06Lelyt5lZjm65eNuvuQm3fB2EX2iVPaZpXvGnc6PiPtU69MFzSlS24aWLc9xAbn5Vffta4
	zbEr/iTE/uVU6k6b1ZZZ7PprfQTUuBy43q7bUvVkZhnL9qerBPKvHtXlv7rIxFW4d4697h1G
	FSWW4oxEQy3mouJEAAjiNFNgAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

On 6/23/2025 1:29 AM, SeongJae Park wrote:
> Hi Honggyu,
> 
> On Sun, 22 Jun 2025 21:09:25 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> The damon_sample_{wsse,prcl,mtier}_start() can fail so we must reset the
>> "enabled" parameter to "false" again for proper rollback.
>>
>> In such cases, setting Y to "enabled" then N triggers the following
>> crash because damon sample start failed but the "enabled" stays as Y.
>>
>>    [ 2441.419649] damon_sample_prcl: start
>>    [ 2454.146817] damon_sample_prcl: stop
>>    [ 2454.146862] ------------[ cut here ]------------
>>    [ 2454.146865] kernel BUG at mm/slub.c:546!
>>    [ 2454.148183] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>        ...
>>    [ 2454.167555] Call Trace:
>>    [ 2454.167822]  <TASK>
>>    [ 2454.168061]  damon_destroy_ctx+0x78/0x140
>>    [ 2454.168454]  damon_sample_prcl_enable_store+0x8d/0xd0
>>    [ 2454.168932]  param_attr_store+0xa1/0x120
>>    [ 2454.169315]  module_attr_store+0x20/0x50
>>    [ 2454.169695]  sysfs_kf_write+0x72/0x90
>>    [ 2454.170065]  kernfs_fop_write_iter+0x150/0x1e0
>>    [ 2454.170491]  vfs_write+0x315/0x440
>>    [ 2454.170833]  ksys_write+0x69/0xf0
>>    [ 2454.171162]  __x64_sys_write+0x19/0x30
>>    [ 2454.171525]  x64_sys_call+0x18b2/0x2700
>>    [ 2454.171900]  do_syscall_64+0x7f/0x680
>>    [ 2454.172258]  ? exit_to_user_mode_loop+0xf6/0x180
>>    [ 2454.172694]  ? clear_bhb_loop+0x30/0x80
>>    [ 2454.173067]  ? clear_bhb_loop+0x30/0x80
>>    [ 2454.173439]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Thank you for finding and fixing this!
> 
>>
>> Since it's just a sample module, no need to add it to stable tree.
> 
> I agree this is not a real bug.  But, even a bug in DAMON unit test was
> deserved to get a CVE id.  Hence I'd suggest adding at least Fixes: tag here,
> and let stable kernels maintainers to decide whether to pick this up to stable
> kernels or not.  I can help backporting if needed.
> 
> If you agree, I think we could add
> 
> Fixes: b757c6cfc696d ("samples/damon/wsse: start and stop DAMON as the user requests")
> 
> If we want to make stable kernel maintainers' life easier, we would better to
> split this into three patches, for each module, and add appropriate Fixes, as
> below.

Spliting this into three patches is okay.

> 
> For wsse,
> Fixes: b757c6cfc696d ("samples/damon/wsse: start and stop DAMON as the user requests")
> 
> For prcl,
> 
> Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
> 
> For mtier,
> 
> Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
> 
> Could you please do so?

If we do, then this patchset has to come before "enabled" renaming patch.

In addition, I remember mixing stable and non-stable patches together in the
same patchset isn't welcomed by Andrew or other stable tree maintainers.  So I
might be better to split those three fix patches into a separate patchset.

The only thing that bothers me in that case is writing cover letter for simple 2
or 3 patches as they are relatively simple.

But it isn't that hard so can manage those in the next spin.

> 
>>
>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> Regardless of your agreement on adding Fixes:
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ

Thanks,
Honggyu

> 
> [...]

