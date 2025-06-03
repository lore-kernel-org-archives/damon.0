Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BB27468
	for <damon@lists.linux.dev>; Tue,  3 Jun 2025 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748919958; cv=none; b=OCNLCPnXwRIyINGtejMYPVGLBKfneJ65RIADbFdwsZjUXL3JDUFKiert7ns0s5R9iXIKj5PFYnZ1qmFh9LACFoQgth/Og9xsXG9Vannv130M88QvGewBS4I5Mh28U1q6EAlBcHBIjkFKyOnhD4s5LVO9dYyeMCpTbyb8JiUNFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748919958; c=relaxed/simple;
	bh=yeFtExa5Fm4q1yI48fnH0xtAV9xyBoXlCKwVAfvwmFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOC0uWu9nDyMnm0cC0vSC8zQYcU5sP79p293Yjj0bzRj0x7bxtVee1lOCQQaKtpnMZimghAS3BU1fw3UbBSntI7EHezraKQmK0/QsMkh7iE8yCrNVAZPKCAXBm9u8qelgEJ4crJepIo46L+6+K901PSFxGbfZNGbI9dZK8nomy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201611.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506031105436355;
        Tue, 03 Jun 2025 11:05:43 +0800
Received: from localhost.localdomain (120.224.42.190) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.39; Tue, 3 Jun 2025 11:05:41 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <wangchuanguo@inspur.com>, SeongJae Park <sj@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "david@redhat.com"
	<david@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "damon@lists.linux.dev"
	<damon@lists.linux.dev>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Tue, 3 Jun 2025 11:05:30 +0800
Message-ID: <20250603030530.365142-1-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250530194016.51798-1-sj@kernel.org>
References:
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
tUid: 202560311054333279b5fbf90c656ed691958386266a2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

On Fri, 30 May 2025 12:40:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Simon,
> 
> 
> Thank you for continuing this important discussion.
> 
> Before starting, though, seems your mail client is not setting 'In-Reply-To'
> field of your mails.  For people who uses 'In-Reply-To' field based threads
> displaying tools, ths thread could be difficult to read the whole contents.
> Please consider using tools that set the field correctly if possible.
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
> > Your concern is that adding the bool use_nodes_of_tier variable and introducing 
> > an additional parameter to multiple functions would cause ABI changes, correct?​​
> 
> You are correct.
> 
> > 
> > ​​I propose avoiding the creation of the 'use_nodes_of_tier' sysfs
> > file. Instead, we can modify the __damon_pa_migrate_folio_list() function to
> > change the allowed_mask from NODE_MASK_NONE to the full node mask of the
> > entire tier where the target_nid resides.  This approach would be similar to
> > the implementation in commit 320080272892 ('mm/demotion: demote pages
> > according to allocation fallback order').
> 
> Then, this causes a behavior change, which we should not allow if it can be
> considered a regression.  In other words, we could do this if it is a clear
> improvement.
> 
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
> Also, do_move_pages_to_node() uses alloc_migration_target() while
> DAMOS_MIGRATE_{HOT,COLD} uses alloc_migrate_folio().
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
> > 
> > I'd like to confirm two modification points with you:
> > ​​1.Regarding alloc_migrate_folio()​​:
> > Restoring the original nodemask and gfp_mask in this function is the correct approach, correct?
> 
> I think that's correct, but let's discuss about the patch on the patch's
> thread.
> 
> > ​​2.Regarding DAMON's migration logic​​:
> > The target scope should be expanded from a single specified node to the entire memory tier
> >  (where the target node resides), correct?
> 
> I don't think so, as abovely explained.
> 
> > ​​Can we confirm these two points are agreed upon?​
> 
> I believe hope this is answered above.
> 
> 
> Thanks,
> SJ
> 
> [...]

Sent using hkml (https://github.com/sjp38/hackermail)
