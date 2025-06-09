Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A6256C61
	for <damon@lists.linux.dev>; Mon,  9 Jun 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472797; cv=none; b=R7mNxWr1ngwqRRIn+WtfGYiDGSfXAfRfux0KZZivGZ1sreWFN2oGJB+JOFME+859Ab1DPqkFRGRetrDwoi37j2O0EhhuFYl1FHttlJ1mTMsyyJlyoYNGb0DqxK82rieTnhhi3kAl3DM9FEb2Afboc41/xQk/tfc2BG7Hh5xtuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472797; c=relaxed/simple;
	bh=+VVH0BT2UtobRbMKs1mWx4K6nmkRc6PMAGV9twqtCpQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LxqL+bXrRwTLNOKq1oPppw2WpCeEhWaqxrR8HTgqtZtcesIM1mLpCwT4vsRU7zQ7I7A0uSD7MmTx7ecaNVhdY8QcyWkN/e12J+dDCd6knG+Ef/E+wCap+a1KqIKKrsyWwkBnz4wKBhB9PYavyecM8aZ1ag4YPVpdOUtKEt1HsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-9c-6846d6161ec1
Message-ID: <c75e8237-1411-4ac6-8def-f20c255f7e06@sk.com>
Date: Mon, 9 Jun 2025 21:39:50 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "david@redhat.com" <david@redhat.com>, "mhocko@kernel.org"
 <mhocko@kernel.org>, "zhengqi.arch@bytedance.com"
 <zhengqi.arch@bytedance.com>, "shakeel.butt@linux.dev"
 <shakeel.butt@linux.dev>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
To: SeongJae Park <sj@kernel.org>, Simon Wang <wangchuanguo@inspur.com>
References: <20250530194016.51798-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250530194016.51798-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsXC9ZZnoa74NbcMgydXGC3mrF/DZvHk/29W
	i6/rfzFbrN7ka3F51xw2i3tr/rNanJy1ksXi9bdlzBbPZ81lsjj89Q2TxfHPz5ktPl05wO7A
	4/HvxBo2j8Nv3jN7nNixgdlj06pONo9Nnyaxe5yY8ZvFY2HDVGaPF5tnMnp8fHqLxeP9vqts
	Hp83yQVwR3HZpKTmZJalFunbJXBl3G3YxFQwWbNi58S3bA2MVxW7GDk5JARMJG6vamKBsXfP
	a2EEsXkFLCXuXG5lBrFZBFQk5vT8h4oLSpyc+QSsXlRAXuL+rRnsXYxcHMwCy1kkls9cANYg
	LBApseJWPxuILSLgLrHx/h2wuJCAkUTLvhtgzcwCIhKzO9vA4mwCahJXXk5iArE5BYwlbjVc
	YYeoMZPo2trFCGHLSzRvnc0MskxCoJ1dYsq0XiaIqyUlDq64wTKBUXAWkgNnIdkxC8msWUhm
	LWBkWcUolJlXlpuYmWOil1GZl1mhl5yfu4kRGH3Lav9E72D8dCH4EKMAB6MSD++Jy24ZQqyJ
	ZcWVuYcYJTiYlUR4V4KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2C
	yTJxcEo1MIZtO573/LHsrl+fl5+2DRTxYV45/3P5+yNPF+b73J17/spShVlv55Z/5DDLd3h0
	Oi98zbUnz7+tufbX/u5mlThG2z6bA4v8pdS6bCaHnsvNWvgsYzr3tccrXSM6q3YIfrlyf2JG
	lP0bI88Ec89Ltz1WH/2ycK6R2Lyi73vtJtlkh9f/nCwcZcCvxFKckWioxVxUnAgAZ1OzrroC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhmqGlpyt2zS3D4NEyA4s569ewWTz5/5vV
	4uv6X8wWqzf5Whyee5LV4vKuOWwW99b8Z7U4OWsli8Xrb8uYLZ7PmstkcfjrGyaL45+fM1t8
	unKA3YHX49+JNWweh9+8Z/Y4sWMDs8emVZ1sHps+TWL3ODHjN4vHwoapzB4vNs9k9Pj49BaL
	x/t9V9k8Fr/4wOTxeZNcAE8Ul01Kak5mWWqRvl0CV8bdhk1MBZM1K3ZOfMvWwHhVsYuRk0NC
	wERi97wWRhCbV8BS4s7lVmYQm0VARWJOz3+ouKDEyZlPWEBsUQF5ifu3ZrB3MXJxMAssZ5FY
	PnMBWIOwQKTEilv9bCC2iIC7xMb7d8DiQgJGEi37boA1MwuISMzubAOLswmoSVx5OYkJxOYU
	MJa41XCFHaLGTKJraxcjhC0v0bx1NvMERr5ZSO6YhWTULCQts5C0LGBkWcUokplXlpuYmWOq
	V5ydUZmXWaGXnJ+7iREYS8tq/0zcwfjlsvshRgEORiUe3hOX3TKEWBPLiitzDzFKcDArifCu
	BAnxpiRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwJpgtvFar
	I/R5okZ1aItKpvvzp7ZaHEt3d+68HRAhKMhxJ+HlqatvP+mYvD9t1cV5MLON2ebGRdEFCd+c
	pZR0T84Mezzto1n0mb0KfzZE7ZkX5lbZJmTw7nt34nOhnzfrlu5+c9FHhvvkRZFvvXabbu5T
	WZ+6038h+8rf/5bUBpSwCi+bu4WPRYmlOCPRUIu5qDgRAKYd8QihAgAA
X-CFilter-Loop: Reflected

Hi SeongJae and Simon,

On 5/31/2025 4:40 AM, SeongJae Park wrote:
> Hi Simon,
> 
> 
> Thank you for continuing this important discussion.
> 
> Before starting, though, seems your mail client is not setting 'In-Reply-To'
> field of your mails.  For people who uses 'In-Reply-To' field based threads
> displaying tools, ths thread could be difficult to read the whole contents.
> Please consider using tools that set the field correctly if possible.

Sorry for the late response, I also had some difficulty to find its original
patch and I just found it and replied at the following links.
https://lore.kernel.org/linux-mm/20250528111038.18378-3-wangchuanguo@inspur.com
https://lore.kernel.org/linux-mm/74a7db85-8fcc-4bd5-8656-0f4d0670f205@sk.com

> 
> You could get more information about available mailing tools from
> https://docs.kernel.org/process/email-clients.html
> 
> Btw, I use hkml
> (https://docs.kernel.org/process/email-clients.html#hackermail-tui) ;)
> 
> On Fri, 30 May 2025 08:04:42 +0000 Simon Wang (王传国) <wangchuanguo@inspur.com> wrote:
> 
> [...]
>> Your concern is that adding the bool use_nodes_of_tier variable and introducing
>> an additional parameter to multiple functions would cause ABI changes, correct?​​
> 
> You are correct.
> 
>>
>> ​​I propose avoiding the creation of the 'use_nodes_of_tier' sysfs
>> file. Instead, we can modify the __damon_pa_migrate_folio_list() function to
>> change the allowed_mask from NODE_MASK_NONE to the full node mask of the
>> entire tier where the target_nid resides.  This approach would be similar to
>> the implementation in commit 320080272892 ('mm/demotion: demote pages
>> according to allocation fallback order').
> 
> Then, this causes a behavior change, which we should not allow if it can be
> considered a regression.  In other words, we could do this if it is a clear
> improvement.

I agree this is a behavior change.

> So, let's think about if your proposed change is an improvement.  As the commit
> 320080272892 is nicely explaining, I think that it is an improved behavior for
> demotion.  Actually it seems good behavior for promotion, too.  But, the
> behavior we are discussing here is not for the demotion but general migration
> (specifically, DAMOS_MIGRATE_{HOT,COLD}).
> 
> In my opinion, DAMOS_MIGRATE_{HOT,COLD} behavior should be somewhat similar to
> that of move_pages() syscall, to make its behavior easy to expect.  So I think
> having commit 320080272892's behavior improvement to DAMOS_MIGRATE_{HOT,COLD}
> is not a right thing to do.
> 
> And this asks me a question.  Is current DAMOS_MIGRATE_{HOT,COLD} behavior
> similar to move_pages() syscall?  Not really, since do_move_pages_to_node(),
> which is called from move_pages() syscall and calls migrate_pages() is setting
> mtc->nmask as NULL, while DAMOS_MIGRATE_{HOT,COLD} set it as NODE_MASK_NONE.
 >
> Also, do_move_pages_to_node() uses alloc_migration_target() while
> DAMOS_MIGRATE_{HOT,COLD} uses alloc_migrate_folio().

I can see alloc_migrate_folio() also calls alloc_migration_target(), but do you
mean alloc_migrate_folio() setting mtc->nmask to NULL is the difference?

> 
> I overlooked this different behavior while reviewing this code, sorry.  And I
> don't think this difference is what we need to keep, unless there are good
> rasons that well documented.  Thank you for let us find this, Simon.
> 
> So I suggest to set mtc->nmask as NULL, and use alloc_migration_target() from
> __damon_pa_migrate_folio_list(), same to move_pages() system call.  To use
> alloc_migrate_folio() from __damon_pa_migrate_folio_list(), we renamed it from
> alloc_demote_folio(), and made it none-static.  If we use
> alloc_migration_target() from __damon_pa_migrate_folio_list(), there is no
> reason to keep the changes.  Let's revert those too.
> 
> Cc-ing Honggyu, who originally implemented the current behavior of
> __damon_pa_migrate().  Honggyu, could you please let us know if the above
> suggested changes are not ok for you?
> 
> If Honggyu has no problem at the suggested change, Simon, would you mind doing
> that?  I can also make the patches.  I don't really care who do that.  I just
> think someone should do that.  This shouldn't be urgent real issue, in my
> opinion, though.
> 
>>
>> I'd like to confirm two modification points with you:
>> ​​1.Regarding alloc_migrate_folio()​​:
>> Restoring the original nodemask and gfp_mask in this function is the correct approach, correct?

I also think restoring the both mtc->nmask and mtc->gfp_mask are needed.

> I think that's correct, but let's discuss about the patch on the patch's
> thread.
> 
>> ​​2.Regarding DAMON's migration logic​​:
>> The target scope should be expanded from a single specified node to the entire memory tier
>>   (where the target node resides), correct?
> 
> I don't think so, as abovely explained.

I also think this makes our use case unexpected and cannot prevent migration is
done beyond other side of socket.

> 
>> ​​Can we confirm these two points are agreed upon?​
> 
> I believe hope this is answered above.
> 
> 
> Thanks,
> SJ
> 
> [...]

Thanks,
Honggyu
