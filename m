Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B11FBEBC;
	Tue, 21 Apr 2026 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734631; cv=none; b=tLbwx3vtOBQVMm29w4lI5i3VoOQ0Bj4G5H33GT18G8k9FbrtEnqx3AJGHlOoMtXc2adViOEonePXb7z2le4EWU1G5Ls3v90Ja8W2DLZeCzxzrHpLlHuNHc0YTlBTD7sC3O+6pQOZGCjRSB4iu95VsCQIButGaB/15r+a+mWs3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734631; c=relaxed/simple;
	bh=XkZKTo3VZh3AYgCplCQOoxro1b6UUyXleYklHwpf71g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSKakr7rXcjwtgC6gzN3is3e+iE9+YRaCt79370bSPABXEkxt0WbDoGDbyRi7pOM3mw9ofRUaz2KxiL2iG9ES16XNBl1FGODe4wunJ391Y58CGAH/OUsDuGagXu/E/NLrUUI9SxQwfejLISygPyZrZTn26cnqCZV8CNDWPwWOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4QKkzyS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4QKkzyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2796CC19425;
	Tue, 21 Apr 2026 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776734631;
	bh=XkZKTo3VZh3AYgCplCQOoxro1b6UUyXleYklHwpf71g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4QKkzySJTVFWSG6qXBEtMZA1cpdyGlOQbuhbGRDIL24YZvl9tChkDN0Ocz0zP97n
	 P8NCc+OM3xopArrqeOrHdAnRV8mju919uSsNztfhtEuSqZtVC6BfAyElhgRdQBnxTf
	 dl6gh4rxFfZaH+cQjlR4nd6ZOqzl5WxoXh864DmlDgD1UjYe8uvWflK4+YZFMZB6LS
	 SWi3zaoJycfpTUD5ISRvY9sEYuesfo9fRjT5YMhqETwG0ytt8ZURC9+gcTfoteYAMz
	 hjMY8HjQXsmUQTqjAD2MxIWYFQZxSiYJEOnXh3K6+84vhPGbdhDkfeCVcgsaeBkgHw
	 0tgVka4Nxej3Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Junxi Qian <qjx1298677004@gmail.com>,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path
Date: Mon, 20 Apr 2026 18:23:46 -0700
Message-ID: <20260421012346.67274-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421012028.67143-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Apr 2026 18:20:27 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello Junxi,
> 
> 
> When you send a new version of a patch, please send it as a new mail with
> changes log [1], rather than as a reply to the old version.

Also, please share your revision plan first, and wait for possible others'
comments for about a day before posting a new version.


Thanks,
SJ

> 
> On Mon, 20 Apr 2026 20:54:05 +0800 Junxi Qian <qjx1298677004@gmail.com> wrote:
> 
> > memcg_path_store() and path_store() free and replace their respective
> > string pointers without holding damon_sysfs_lock. This creates a race
> > with the kdamond thread, which reads these pointers in
> > damon_sysfs_add_scheme_filters() and damos_sysfs_add_quota_score()
> > via damon_call() during a "commit" operation.
> > 
> > The race window is as follows:
> >   Thread A (commit):  holds damon_sysfs_lock, triggers damon_call()
> >   kdamond thread:     reads sysfs_filter->memcg_path in
> >                       damon_sysfs_memcg_path_to_id()
> >   Thread B (sysfs):   calls memcg_path_store() WITHOUT lock,
> >                       kfree(filter->memcg_path), replaces pointer
> > 
> > Since Thread B does not hold damon_sysfs_lock, the kdamond thread can
> > observe a freed pointer, resulting in a use-after-free when
> > damon_sysfs_memcg_path_eq() dereferences it for string comparison.
> 
> Thank you for finding and sharing this bug!
> > 
> > Similarly, memcg_path_show() and path_show() read the string pointers
> > without holding the lock, so a concurrent store can free the string
> > just before sysfs_emit() dereferences it, causing a use-after-free.
> 
> Is this correct?  Isn't sysfs prohibiting such concurrent read/write using
> kernfs_open_file->mutex?  Were you able to trigger this?
> 
> > 
> > KASAN reports the following on v7.0.0-rc5 with CONFIG_KASAN=y:
> > 
> >   ==================================================================
> >   BUG: KASAN: double-free in memcg_path_store+0x6e/0xc0
> > 
> >   Free of addr ffff888100a086c0 by task exp/149
> > 
> >   CPU: 1 UID: 0 PID: 149 Comm: exp Not tainted 7.0.0-rc5-gd38efd7c139a #18 PREEMPT(lazy)
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x55/0x70
> >    print_report+0xcb/0x5d0
> >    kasan_report_invalid_free+0x94/0xc0
> >    check_slab_allocation+0xde/0x110
> >    kfree+0x114/0x3b0
> >    memcg_path_store+0x6e/0xc0
> >    kernfs_fop_write_iter+0x2fc/0x490
> >    vfs_write+0x8e1/0xcc0
> >    ksys_write+0xee/0x1c0
> >    do_syscall_64+0xfc/0x580
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> > 
> >   Allocated by task 147 on cpu 0 at 12.364295s:
> >    kasan_save_stack+0x24/0x50
> >    kasan_save_track+0x17/0x60
> >    __kasan_kmalloc+0x7f/0x90
> >    __kmalloc_noprof+0x191/0x490
> >    memcg_path_store+0x32/0xc0
> >    kernfs_fop_write_iter+0x2fc/0x490
> >    vfs_write+0x8e1/0xcc0
> >    ksys_write+0xee/0x1c0
> > 
> >   Freed by task 150 on cpu 0 at 13.373810s:
> >    kasan_save_stack+0x24/0x50
> >    kasan_save_track+0x17/0x60
> >    kasan_save_free_info+0x3b/0x60
> >    __kasan_slab_free+0x43/0x70
> >    kfree+0x137/0x3b0
> >    memcg_path_store+0x6e/0xc0
> >    kernfs_fop_write_iter+0x2fc/0x490
> >    vfs_write+0x8e1/0xcc0
> >    ksys_write+0xee/0x1c0
> > 
> >   The buggy address belongs to the object at ffff888100a086c0
> >    which belongs to the cache kmalloc-8 of size 8
> >   ==================================================================
> > 
> > Fix this by holding damon_sysfs_lock while swapping the path pointer
> > in both memcg_path_store() and path_store(),
> 
> I'd like to avoid use of the lock in long term.  But this sounds good and
> simple for hotfixes.
> 
> > and while reading the
> > path pointer in memcg_path_show() and path_show().
> 
> As I commented above, I'm not sure if this is really needed.
> 
> > The actual kfree()
> > is moved outside the lock since the old pointer is no longer reachable
> > once replaced.
> > 
> > Fixes: 490a43d07f16 ("mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write")
> 
> I think this deserves Cc-ing stable@.
> 
> Also, this patch is fixing two bugs.  For making backport of the fixes easy,
> could we split this patch into two patches, one for memcg_path_{show,store}(),
> and the other one for path_{show,store}()?
> 
> > Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
> > 
> > ---
> > Changes in v2:
> > - Also protect memcg_path_show() and path_show() with damon_sysfs_lock,
> >   since sysfs show and store callbacks can run concurrently and a
> >   lockless read in show can race with the kfree in store. (Sashiko AI)
> 
> As I abovely commented, I'm not sure that Sashiko comment is correct.
> 
> > 
> >  mm/damon/sysfs-schemes.c | 36 ++++++++++++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 5186966da..1a890e2a4 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -533,9 +533,14 @@ static ssize_t memcg_path_show(struct kobject *kobj,
> >  {
> >  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> >  			struct damon_sysfs_scheme_filter, kobj);
> > +	ssize_t len;
> >  
> > -	return sysfs_emit(buf, "%s\n",
> > +	mutex_lock(&damon_sysfs_lock);
> 
> I read Sashiko is commenting [2] about possible ABBA deadlock, and suggesting
> mutex_trylock().  I think that makes sense.  damon_sysfs_lock is always only
> mutex_trylock()-ed for the reason.
> 
> > +	len = sysfs_emit(buf, "%s\n",
> >  			filter->memcg_path ? filter->memcg_path : "");
> > +	mutex_unlock(&damon_sysfs_lock);
> > +
> > +	return len;
> >  }
> 
> And I'm unsure if this change for memcg_path_show() is really needed.
> 
> >  
> >  static ssize_t memcg_path_store(struct kobject *kobj,
> > @@ -543,15 +548,20 @@ static ssize_t memcg_path_store(struct kobject *kobj,
> >  {
> >  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> >  			struct damon_sysfs_scheme_filter, kobj);
> > -	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> > -				   GFP_KERNEL);
> > +	char *path, *old;
> >  
> > +	path = kmalloc_array(size_add(count, 1), sizeof(*path), GFP_KERNEL);
> >  	if (!path)
> >  		return -ENOMEM;
> >  
> >  	strscpy(path, buf, count + 1);
> > -	kfree(filter->memcg_path);
> > +
> > +	mutex_lock(&damon_sysfs_lock);
> 
> Let's use mutex_trylock().
> 
> > +	old = filter->memcg_path;
> >  	filter->memcg_path = path;
> > +	mutex_unlock(&damon_sysfs_lock);
> > +
> > +	kfree(old);
> >  	return count;
> >  }
> 
> Same comments for path_show() and path_store() changes.
> 
> [1] https://docs.kernel.org/process/submitting-patches.html#commentary
> [2] https://lore.kernel.org/20260420183146.0DA7AC2BCB0@smtp.kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Sent using hkml (https://github.com/sjp38/hackermail)
