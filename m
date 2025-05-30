Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E223D29C;
	Fri, 30 May 2025 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748634020; cv=none; b=CG8uuCqfzoagAquArHi9ntM4fNfSBt5yyb4FZmPxF7Q6jc8f4oahjSzdHbpY6Syl9ysuT0Mkjs0lz1CVOtCCNqpHZI26p2b37l3JYheWj0W+b66RGWECDQNtbkWuiXpR3ADQKnh/H1ynSrhTAXqcBUmRkw3ZG7yRBuzVxAQ6wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748634020; c=relaxed/simple;
	bh=itUA8ff8aTmvXv85lYwlzfad/BJsQ7E+Twj2YKbMDQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yktto8+md2bYlxD15P54uJcJevMYQ11RCmAlG0fIg7BH3dliZsVj0usp17J5MgxHOlA8t83nohOUv0OmsH/Gkdm2hI0ZASmds81nDex/d9XGo1N00kGHW9UTARgWCicjv2XD1yu9ezBGLElFAFdsxbMQyX1jgCZlh0pRMODyqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+AM3trI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+AM3trI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF82C4CEE9;
	Fri, 30 May 2025 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748634019;
	bh=itUA8ff8aTmvXv85lYwlzfad/BJsQ7E+Twj2YKbMDQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+AM3trI1qH0ill10tQoKzosuizcbVRdiHm9o0M805oDppMqBYjOnkxWaefmSU5V4
	 XWJHP+fHXambmXZ9odTbZF+qQJU0SH3f+xNd3UKD+d+lwgVRpzY5BrJiEAt7jMu3l+
	 1RdvpqOkhTp4pQh10pPbL6Fh8dxVuYa3/1tSVqX4nNiZrr/Bt134TTWnT9/Du6EiRF
	 2KWdzkQS1nFx6Hvc8pwCWrnk/Q6fdP64R/n7E/yXemb7jgyRt6H9rPIip1ZlHAHJXz
	 1p1etjkGIs2ue5mR13QVDRnzd7DMZPJzHYgokCudEfnuEtyFQaxjkDGv4Nc33NR2Br
	 80Lo6UYsQ6ytw==
From: SeongJae Park <sj@kernel.org>
To: Simon Wang <wangchuanguo@inspur.com>
Cc: SeongJae Park <sj@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"david@redhat.com" <david@redhat.com>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Fri, 30 May 2025 12:40:16 -0700
Message-Id: <20250530194016.51798-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d8e3000cfadb443681fabad65093b462@inspur.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Simon,


Thank you for continuing this important discussion.

Before starting, though, seems your mail client is not setting 'In-Reply-To'
field of your mails.  For people who uses 'In-Reply-To' field based threads
displaying tools, ths thread could be difficult to read the whole contents.
Please consider using tools that set the field correctly if possible.

You could get more information about available mailing tools from
https://docs.kernel.org/process/email-clients.html

Btw, I use hkml
(https://docs.kernel.org/process/email-clients.html#hackermail-tui) ;)

On Fri, 30 May 2025 08:04:42 +0000 Simon Wang (王传国) <wangchuanguo@inspur.com> wrote:

[...]
> Your concern is that adding the bool use_nodes_of_tier variable and introducing 
> an additional parameter to multiple functions would cause ABI changes, correct?​​

You are correct.

> 
> ​​I propose avoiding the creation of the 'use_nodes_of_tier' sysfs
> file. Instead, we can modify the __damon_pa_migrate_folio_list() function to
> change the allowed_mask from NODE_MASK_NONE to the full node mask of the
> entire tier where the target_nid resides.  This approach would be similar to
> the implementation in commit 320080272892 ('mm/demotion: demote pages
> according to allocation fallback order').

Then, this causes a behavior change, which we should not allow if it can be
considered a regression.  In other words, we could do this if it is a clear
improvement.

So, let's think about if your proposed change is an improvement.  As the commit
320080272892 is nicely explaining, I think that it is an improved behavior for
demotion.  Actually it seems good behavior for promotion, too.  But, the
behavior we are discussing here is not for the demotion but general migration
(specifically, DAMOS_MIGRATE_{HOT,COLD}).

In my opinion, DAMOS_MIGRATE_{HOT,COLD} behavior should be somewhat similar to
that of move_pages() syscall, to make its behavior easy to expect.  So I think
having commit 320080272892's behavior improvement to DAMOS_MIGRATE_{HOT,COLD}
is not a right thing to do.

And this asks me a question.  Is current DAMOS_MIGRATE_{HOT,COLD} behavior
similar to move_pages() syscall?  Not really, since do_move_pages_to_node(),
which is called from move_pages() syscall and calls migrate_pages() is setting
mtc->nmask as NULL, while DAMOS_MIGRATE_{HOT,COLD} set it as NODE_MASK_NONE.
Also, do_move_pages_to_node() uses alloc_migration_target() while
DAMOS_MIGRATE_{HOT,COLD} uses alloc_migrate_folio().

I overlooked this different behavior while reviewing this code, sorry.  And I
don't think this difference is what we need to keep, unless there are good
rasons that well documented.  Thank you for let us find this, Simon.

So I suggest to set mtc->nmask as NULL, and use alloc_migration_target() from
__damon_pa_migrate_folio_list(), same to move_pages() system call.  To use
alloc_migrate_folio() from __damon_pa_migrate_folio_list(), we renamed it from
alloc_demote_folio(), and made it none-static.  If we use
alloc_migration_target() from __damon_pa_migrate_folio_list(), there is no
reason to keep the changes.  Let's revert those too.

Cc-ing Honggyu, who originally implemented the current behavior of
__damon_pa_migrate().  Honggyu, could you please let us know if the above
suggested changes are not ok for you?

If Honggyu has no problem at the suggested change, Simon, would you mind doing
that?  I can also make the patches.  I don't really care who do that.  I just
think someone should do that.  This shouldn't be urgent real issue, in my
opinion, though.

> 
> I'd like to confirm two modification points with you:
> ​​1.Regarding alloc_migrate_folio()​​:
> Restoring the original nodemask and gfp_mask in this function is the correct approach, correct?

I think that's correct, but let's discuss about the patch on the patch's
thread.

> ​​2.Regarding DAMON's migration logic​​:
> The target scope should be expanded from a single specified node to the entire memory tier
>  (where the target node resides), correct?

I don't think so, as abovely explained.

> ​​Can we confirm these two points are agreed upon?​

I believe hope this is answered above.


Thanks,
SJ

[...]
