Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB843CEC3
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524895; cv=pass; b=XG7sGnpmWTHt0ZCn86uzRp0RGaIpqfadGA6vj9rRtqBTs2j26Zn6JFRap3U2QwXAtH0T69qd4YzjAZICo0FmHsZ7Ko7ESAJAfrtI66RlZs7DJCR4KD2xtB93Q1mt4UzKv5RuYspMHonG24kJScojphvjiGlt63OBQeQ8qiwi+80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524895; c=relaxed/simple;
	bh=xgUe0AQGXjeGjvTj0ecs5Nu+F+iIOfUesQJXMInIf7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgy0zMBlNYAuTDsKCAiDMDndWlcvQTlhP3KyrC3e3mgdBxs0OSPgBrwaYb1Gjsr2n7/elly4EKjwRELyoPxwVuQ6CQdb+z5OJNW+IqFIrJ6v794rmRkbp91dYwvGeRSrPotWq9HhgrTAVgn0l6IRe4S5TZUotUb++LryvTWoCis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvhAOS96; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvhAOS96"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9158643e538so8301085a.1
        for <damon@lists.linux.dev>; Wed, 03 Jun 2026 15:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780524892; cv=none;
        d=google.com; s=arc-20240605;
        b=OlCIKmYBwBazx8dIt/8+FYGK4+/i1KF8ORPs+6wMZLCcKC9IdY8kSW8F2zkbeiv9Ce
         WkPG9TqLE9lXRBe8UPtbV2uDLPlCLFVw63hWN5UpVEQ6oYJcQySgnUVxJetiJFiRCeKQ
         p3nu/+oTJlxriYhIxScxEoVvqP7NCBtdmoTBfwHaZG2hxSj34UNS5xHVrwXXFSv+viKB
         1BfG3JyxQveB2W39KMvcnzjQQZrSruYBLaXeZTdlYWNiqgfeNc8VMWgItOelNdUrBTXQ
         OjJjsgQF9Z3b8zZmtTwxDxd8EmGgQ37RhM2qja/n93rBeNSQYgspr9oStrBenWybCfI2
         V77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmzDsup0sFlBNWhGg0+0FS+tEwpLPYz+Yh+3amtQtVM=;
        fh=A6xUB/bzLWEeHOV6o5yilcwBDWKxFzd8M2DBTxpKe6o=;
        b=hTOadLKix4VbGLDH1ZG3hipJY+GRwtvhzuW4CKldgkGf+nMCMvDgu6iMIhZNv+yhCc
         iWS9NXLq2w4SCG5MInK/nbHlX052qOMU4FcDt+3M0afqzQPdNy7AwSoF5M1ClaCsLmje
         54WyFYD3ml7t32+x3KAkPNx//3aSbGROKV88YPI3b1oIItyunIOROp+ZBFKt+BVzWJ8v
         t4dNUvOuvD3FUGMc2SVbsEKmafqaj9gWUcJwvEMcQkxL9B7XbB9LRk0UCu16kMVv/rv2
         uDbnEWmTUutsu4d+eoEGlVyw4rw66NdPcgxCyUTMLD9fUCE9qzKzhj9+IcnHDWbbdYYF
         TvNQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780524892; x=1781129692; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmzDsup0sFlBNWhGg0+0FS+tEwpLPYz+Yh+3amtQtVM=;
        b=pvhAOS96NaaJHFPLvuWj4de6rpYYLtXTHfoKH/2m+BXXwcPuWpP52Z4/JAKBc2NQxP
         G8FBMPu7BuLD9WfKFIWguL/+TXXYqk+cwxlpYtJlseU+qVhQXuhOXhR8vT0Fgl5cLBLM
         mXKVgW/hbyta38zuiZeOPqzAx5tVSoQukDDNl1x97kEpwsPASkoHAHcQsaHVgllOW5hG
         xOKQnD7i1uiJKk4QlV1/u9kbpZtHD4B7vDUrTCKRbZA+2PbPlZKrBKRSESb2OLUmVaHm
         p0cXoZ5LTDFgn2xFqQTpMusiF+34vDOF33llD0CG/r+vjqBJ5at0+o+jnCyqcDEvoKU4
         aMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780524892; x=1781129692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmzDsup0sFlBNWhGg0+0FS+tEwpLPYz+Yh+3amtQtVM=;
        b=NCXJRcNghpfltF0cKI9KEImNf9QkkP36Q5iIZ11m3F7fiaHX/aNpHSLO9Fbu3Lohvr
         Ic6qk4tIexKORcCEkk/ZbVJ8SZu14PDveEePvgwCwuAjaBnPrsLo0pvXb/laDGyss2GN
         yX8OCFtl8ZO89JzsgCK4Qa1pr+x/MhPnyUlkFQ8bh+KwKkSX1+UcFRvLV5O/nqW3Zci5
         xLiWNx34l9kLlYAbueapajqkI/z2uTPnyxSZ24KUaPw/kO32BvTt7dxFa3PnNSGMGs5z
         cJlZVoLXPPY3Fs26H/4UOw3HcRX19EmqOPxysbroYe3cbiwRtwpUIhsX1MYeBubW+tWG
         049Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Z/xNCetlvgREypht2OQ+qfLBJeRCJCMcsY3n/pph6/tvxZ2cK84rhuSgHRtU3w0Be3pj8OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeDcy7YB3WJwEbFL+bHHHXGxP/3JRcley8sa91iD+2THCrh2Tu
	c6qIQD9W7yBsWdB98Tiwzk1HXhmZg8vEkubTrybV1gmTUvYX1458HPma0cXyUsJBcSZzYYBwpvW
	TkYw4+daBgkhgSjBXhsHML5atcLOM0ok=
X-Gm-Gg: Acq92OGLjYFCmjcUQ0kshiSHEyeYsjAr0P9xpiomqP+wAR7lFEn+vHyndhElJdlRBUM
	fctl0v0iWk8iElQVveQVFwwWIMfyYRpoN31KKY7POBvV5bMkFNEAK3slHSXZF83ndRNysEhjW53
	DweXyMkxxLCqbj18lkzlVw1IcYoNkZFb88AftbsetrhqeUY/4QfB+C1KYQZ3Enf8du5R7GyOy7O
	POVz3j5xyxsHxha3mEwkdQ2XQxibqQqcNLGJRe5ht+fWGVwVkEaKDPgrhOpaNMLFMXhp8Gyh0/x
	Wc5XHLV1n23RgIJUFZ/2N4f/M0BUvAiiU3QSSwOudUBpUUZK
X-Received: by 2002:a05:620a:40c4:b0:915:9c4b:fdb4 with SMTP id
 af79cd13be357-9159c4c0fccmr119218285a.22.1780524891016; Wed, 03 Jun 2026
 15:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
In-Reply-To: <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 4 Jun 2026 06:14:39 +0800
X-Gm-Features: AVHnY4LRywF8yijh3uWS4ASgIO-DqQ0mxyZBegdnnjWwYExKtCPyz-v6JopNV6g
Message-ID: <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: tao <tao.wangtao@honor.com>, catalin.marinas@arm.com, will@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, ljs@kernel.org, hpa@zytor.com, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	jack@suse.cz, riel@surriel.com, harry@kernel.org, jannh@google.com, 
	jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, lance.yang@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, nao.horiguchi@gmail.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	pfalcato@suse.de, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, 
	ryncsn@gmail.com, jparsana@google.com, dvander@google.com, zhangji1@honor.com, 
	wangzicheng@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:25=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
[...]
> >
> >  arch/arm64/Kconfig         |   1 +
> >  arch/x86/Kconfig           |   1 +
> >  fs/proc/page.c             |   6 +-
> >  include/linux/mm.h         |  38 ++
> >  include/linux/mm_types.h   |   9 +-
> >  include/linux/page-flags.h |  34 +-
> >  include/linux/pagemap.h    |   2 +-
> >  include/linux/rmap.h       | 165 ++++++++-
> >  mm/Kconfig                 |  22 ++
> >  mm/damon/ops-common.c      |   4 +-
> >  mm/debug.c                 |   2 +-
> >  mm/debug_vm_pgtable.c      |   2 +-
> >  mm/gup.c                   |   6 +-
> >  mm/huge_memory.c           |  16 +-
> >  mm/internal.h              | 171 +++++++++
> >  mm/khugepaged.c            |  13 +-
> >  mm/ksm.c                   |  43 ++-
> >  mm/memory-failure.c        |  11 +-
> >  mm/memory.c                |  19 +-
> >  mm/migrate.c               | 126 ++++---
> >  mm/mmap.c                  |  15 +-
> >  mm/mremap.c                |   4 +-
> >  mm/page_idle.c             |   2 +-
> >  mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
> >  mm/vma.c                   |  76 ++--
> >  mm/vma.h                   |   4 +-
> >  mm/vma_exec.c              |   2 +-
> >  mm/vma_init.c              |   1 +
> >  28 files changed, 1279 insertions(+), 206 deletions(-)
>
> Hi!
>
> When I saw the diffsat I was concerned. Going through the patches made me=
 ...
> more concerned :)
>
> This is a lot of complexity. On top of something that is already so compl=
icated
> that I fail to grasp most details without regularly taking a look at the =
nice
> figures Lorenzo created recently.
>
> For example, I read above "since child VMAs do not need to allocate anon_=
vma"
> and wondered how that could be part of something that is just done lazily=
. Then
> I had to learn in the patches that there is some additional "Child VMAs
> are created as ANON_VMA_TREE_PARENT and do not allocate anon_vma" -- excu=
se me,
> what? :)

Yes, that part is quite complicated here. There are two cases here:
1. A forks B, and B inherits a VMA from A. In this case,
B's VMA gets ANON_VMA_TREE_PARENT.

2. A forks B, and B later creates a new VMA via mmap().
If a page fault occurs in this new VMA, it gets
ANON_VMA_TREE_VMA.

In both cases, we need to upgrade B to a regular anon_vma
when B becomes a parent and performs a fork().

This may be a bit off-topic, but I'm also considering
whether there is a chance to work with Suren to support
case 2 via a GKI hook in the Android kernel before
Lorenzo's work is ready.

Even then, the optimization would apply only to the case
where B never forks, allowing us to skip the anon_vma
"upgrade" entirely. That assumption holds for most
applications, although there are a few cases where it does
not.

I'm actually hoping Android could eventually disable
forking for UI applications altogether. From what I've
heard, some applications use fork() primarily to evade
LMKD (the Android low-memory killer daemon). For
example, a child process may monitor the main process,
and if the main process is killed, detect that event and
request a relaunch. This is one way some applications
attempt to keep themselves alive indefinitely.

But even if we limit the optimization to the subset of
case 2 where B never forks, we still need to handle
mremap(), VMA merges, VMA splits, and similar cases.
That starts to become quite a headache.

So please just ignore my rambling if it turns out to be
nonsense :-)

>
> Reading about VMA refcounts made me shiver. Reading "Holding only
> folio_lock(folio) cannot guarantee that the split
> operation completes atomically." confused me. Learning that we have to in=
vent
> interesting ways to make page migration mutually exclusive to free_pgtabl=
es()
> concerned me. Figuring out that there are arch-specific config options an=
d
> runtime toggles is a clear warning sign.
>
> Seeing test_folio_unmapped() was funny, though (why?! :)).
>
> I think this patch set has a noble goal of reducing anon_vma overhead whe=
n anon
> pages are not shared during fork. However, using anon_vma for them actual=
ly
> makes the overall implementation (e.g., rmap walks, locking) more consist=
ent and
> simpler.
>
> Even if we could be convinced that most of this here is correct, how shou=
ld we
> reasonably maintain this increasing level of complexity here?
>
> I won't echo what has already been said in this thread (and I didn't mana=
ge to
> read all, unfortunately), but for such big and invasive work it's often b=
est to
> get in touch with the community earlier. Otherwise, you might end up wast=
ing
> your time.
>
> Ok, arguably, someone who writes that code learns a lot on the way. And i=
f this
> code really was written by one developer only, I tip my hat! I'd be curio=
us if
> that code already ran somewhere on some Android kernel out there?

I heard from Zicheng that they have been running this for
months and it seems reasonably stable. Please correct me if
I'm wrong, Zicheng :-). This really should have been
discussed with the community earlier.

>
> But adding more complexity on top of something that's already extremely
> complicated to save some memory looks like the wrong direction, really.
>
> I was excited when Lorenzo started working on a completely new approach t=
hat
> would focus on improving the common cases while trying to reduce the over=
all
> complexity. Because I think most of us really dislike anon_vma. It's stil=
l work
> in progress, and I am sure there are some rough edges.
>
> But fundamentally, I think we want to find a new design that is just natu=
rally
> simpler.
>

+1

> Lorenzo has been hard at work exploring various design options (and I'm a=
fraid
> he might be one of the 3 people on this planet that understand anon_vma i=
n full
> detail), so I suggest we wait for a redesign proposal from him and see if=
 that
> is doable?
>

Thanks
Barry
