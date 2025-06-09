Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC5E20EB;
	Mon,  9 Jun 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496390; cv=none; b=X5uPAJy/NjHm7cqBTl0sQPbkv3l+jchmFjdcAHr3A1BV/Q60EmBlDSw2kNtVGQyx6tNNfOdb+ql4r2MWnBdsCHdOJhu4mCuQ4C7LMtGt1DSRfoH80VqoXF5QSS/G4wHnIoXYwULoEWwD9SFrft1hsMNIWGtDhxwaYyNGmKiP90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496390; c=relaxed/simple;
	bh=Tzl3zKxtmHRGQJHxphkU2ytN91LDRb+bSm3NymI6xuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBReeRB/8OEZSt5m5IEIi2VItohEOe2Ef0xIu6L5KGVzzU3KQMUMp0Oz4DRpd2uEbD0xyhFeqIZ3UH7/C3yNwJ2cy477Cxm5mX/IFa6k6uLd0F/FnRV8mrNZWi0XkLqDr2dJgu8XyCks2Ltq7EX2ap0I1c7th6owzhX9Jn+j744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp4DNqAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp4DNqAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DA4C4CEEB;
	Mon,  9 Jun 2025 19:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749496389;
	bh=Tzl3zKxtmHRGQJHxphkU2ytN91LDRb+bSm3NymI6xuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dp4DNqANAbWYuxWfs2byCyss9H/fTP9JtgR2OmFJA980SRLdWcoFhazp98jKAhEta
	 RROkvsUoH/p9PhdiKU+jDV2jit/LQmgrPhCOwWNXjw2bv/5MQQg+U/MbKJdUYynwaB
	 amk/PuH1jDarp6B7sd1sqJt+JlHgzzy3dmWUAEOPzbLiTYwEJ+s7ibKY/AeZ14KsFq
	 SXX9RjUj2LvSsR7li1DQ9AuWjUS/rbSjl2ACJj4V6X0CB0eCT6drRzgTe0O/fe42Ch
	 93uDKU0conzmxm11ltnsXm3dmderrwYNmRK0cRoynZZZBdz6yZ6QXEnl/26erYf+j0
	 5MPD+vAQZdnow==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Simon Wang <wangchuanguo@inspur.com>,
	kernel_team@skhynix.com,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"david@redhat.com" <david@redhat.com>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Mon,  9 Jun 2025 12:13:07 -0700
Message-Id: <20250609191307.47928-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c75e8237-1411-4ac6-8def-f20c255f7e06@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 9 Jun 2025 21:39:50 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae and Simon,
> 
> On 5/31/2025 4:40 AM, SeongJae Park wrote:
[...]
> > On Fri, 30 May 2025 08:04:42 +0000 Simon Wang (王传国) <wangchuanguo@inspur.com> wrote:
[...]
> > So, let's think about if your proposed change is an improvement.  As the commit
> > 320080272892 is nicely explaining, I think that it is an improved behavior for
> > demotion.  Actually it seems good behavior for promotion, too.  But, the
> > behavior we are discussing here is not for the demotion but general migration
> > (specifically, DAMOS_MIGRATE_{HOT,COLD}).
> > 
> > In my opinion, DAMOS_MIGRATE_{HOT,COLD} behavior should be somewhat similar to
> > that of move_pages() syscall, to make its behavior easy to expect.  So I think
> > having commit 320080272892's behavior improvement to DAMOS_MIGRATE_{HOT,COLD}
> > is not a right thing to do.
> > 
> > And this asks me a question.  Is current DAMOS_MIGRATE_{HOT,COLD} behavior
> > similar to move_pages() syscall?  Not really, since do_move_pages_to_node(),
> > which is called from move_pages() syscall and calls migrate_pages() is setting
> > mtc->nmask as NULL, while DAMOS_MIGRATE_{HOT,COLD} set it as NODE_MASK_NONE.
>  >
> > Also, do_move_pages_to_node() uses alloc_migration_target() while
> > DAMOS_MIGRATE_{HOT,COLD} uses alloc_migrate_folio().
> 
> I can see alloc_migrate_folio() also calls alloc_migration_target(), but do you
> mean alloc_migrate_folio() setting mtc->nmask to NULL is the difference?

Yes, and also alloc_migration_target()'s internal optimizations for demotion
use case.

Nonetheless, I'm saying about the differences between DAMOS_MIGRATE_{HOT,COLD}
and move_pages() behaviors in the bigger context.

> 
> > 
> > I overlooked this different behavior while reviewing this code, sorry.  And I
> > don't think this difference is what we need to keep, unless there are good
> > rasons that well documented.  Thank you for let us find this, Simon.
> > 
> > So I suggest to set mtc->nmask as NULL, and use alloc_migration_target() from
> > __damon_pa_migrate_folio_list(), same to move_pages() system call.  To use
> > alloc_migrate_folio() from __damon_pa_migrate_folio_list(), we renamed it from
> > alloc_demote_folio(), and made it none-static.  If we use
> > alloc_migration_target() from __damon_pa_migrate_folio_list(), there is no
> > reason to keep the changes.  Let's revert those too.
> > 
> > Cc-ing Honggyu, who originally implemented the current behavior of
> > __damon_pa_migrate().  Honggyu, could you please let us know if the above
> > suggested changes are not ok for you?
> > 
> > If Honggyu has no problem at the suggested change, Simon, would you mind doing
> > that?  I can also make the patches.  I don't really care who do that.  I just
> > think someone should do that.  This shouldn't be urgent real issue, in my
> > opinion, though.

I will send an RFC for this soon, to make discussions easier and unblocked.


Thanks,
SJ

[...]
