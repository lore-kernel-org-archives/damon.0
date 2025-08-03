Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C5537E9
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754194943; cv=none; b=oGtizOElntcClAVPcW/jfTboWqMMB+zhOTyHR6KSGHVpE0uhBVA6DbZu1ZDno4cb0rE3bU9Xfkzx86WKy/3huKAcmMTTTn3NUsZaKG77O/GWPZFzK4yIy7rU7+41qEt4Vr16CGkNwdvDrpBtPZhMt+7IuRXGjay3MNAWo2mliDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754194943; c=relaxed/simple;
	bh=rU2/nZhmKJhBBZeJC/j9jwGy8NEdWAZKnIzen89p4qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgV+XALeC7BYRLkBQ7g+iDZwJMla3OJ7C+l1sm+KueAyP3KyyV8pEi63aD59N9E9BH96BE/rQvNqnoup9r86c8JkTBxlYCoViCJIPM8jUSid4+z8dH26mPIclvs1oeOMjAbpHjVtiyjTf9ygaCFRXeL0gc3IVJJXlkIq7jKEFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCcG1A2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCcG1A2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49502C4CEEB;
	Sun,  3 Aug 2025 04:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754194941;
	bh=rU2/nZhmKJhBBZeJC/j9jwGy8NEdWAZKnIzen89p4qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCcG1A2IgXQrRkvTkY6jGec0AtgxPb/A4jhksq+t+uP7H/taHWvhMazC0LS0gF48l
	 HzUZOXqpfkisEiTkmH9Vd0opWkEd40Ngh/9IEWaZDk0RZjfuYckeUlKnEcwVoP1j/w
	 rPLYgp1+i24M4KDdrZWAk8MHujXNfhHwW9U/O63sWhJiaRsh2nLVq3RRP/pYA5smDL
	 CTI/xcZZ07R0v89rAWVQOMLvtmAxfKu9SxMe+taeduYGa9elwdwSvMtyMDwVCTwlcu
	 RoeAwLqZqCmrWFzgAdoM5lUu3OHuPOKXeWq7smETG+l8Qfxcqc83Uk5bm0V/UpZGI/
	 GsjtmUI1FrHTA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Date: Sat,  2 Aug 2025 21:22:08 -0700
Message-Id: <20250803042208.50634-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <a31c84fc-71ac-4aa2-9bfb-123868a91cd3@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 3 Aug 2025 11:03:12 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae and Sang-Heon,
> 
> On 8/2/2025 1:50 AM, SeongJae Park wrote:
> > On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> > 
> >> Hi, Honggyu
> >>
> >> On Fri, Aug 1, 2025 at 8:35 PM Honggyu Kim <honggyu.kim@sk.com> wrote:
> >>>
> >>> Hi Sang-Heon and SeongJae,
> >>>
> >>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
> >>>> Hello Sang-Heon,
> >>>>
> >>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >>>>
> >>>>> Nowadays, damos operation actions support more various operation set.
> >>>>> But comments(also, generated documentation) doesn't updated.
> >>>>> So, fix the comments with current support status.
> > [...]
> >>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
> > [...]
> >>>>>     * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
> >>>>>     * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
> >>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
> >>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
> >>>>
> >>>> Nice!
> >>>
> >>> But doesn't it make confusion about whether this pages out to disk or does
> >>> demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
> >>> demotion, but it looks "reclaim" includes pageout and demotion together in my
> >>> understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.
> > 
> > To my understanding, DAMOS_PAGEOUT can also do demotion when demotion_enabled
> > is set.  Am I missing something?
> 
> Actually no, please see below.

I'm unsure to what point you are saying "no".  Are you saying DAMOS_PAGEOUT can
also do demotion when demotion_enabled is set?  Or not?  Could you please
clarify, and add more explanations about why you think so?

> 
> do_demote_pass in shrink_folio_list()
> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122
> 
> The do_demote_pass is used here.
> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L1302
> 
> can_demote() implementation returns false when demotion_enabled is on.
> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L351

I'm again get confused.  Isn't it opposite?

```
static bool can_demote(int nid, struct scan_control *sc,
		       struct mem_cgroup *memcg)
{
	int demotion_nid;

	if (!numa_demotion_enabled)
		return false;
```

It returns "false" when demotion_enabled is "off" (unset).  Am I reading
something wrong...?

> 
> The replated commit is as follows.
> mm/migrate: add sysfs interface to enable reclaim migration
> https://github.com/torvalds/linux/commit/20b51af15e014cac63b58a4f8b8b323ac35bccce
> 
> > 
> >>
> >> My intention was just to synchronize with the Design documentation.
> >>
> >> So how about changing the description to `Page out the region`, Would
> >> this be also confusing?
> >> I feel like it would be clearer than using word "reclaim"
> 
> I don't have a good idea but it looks like recusive explanation.
> 
> > 
> > In my opinion, "reclaim" is good.
> 
> I wish there could be better term that distinguishes between swap out and
> demotion.  In my understanding "reclaim" includes both swap out and demotion.

"Reclaim" also includes writeback operations.

I agree we have many rooms to improve in terms of terminologies.  But, I'd
argue we don't need to have only 1:1 mapping terminologies.  Othrwise, maybe we
don't need any documentation at all but just code.  "Reclaim" is a good general
terminology for describing an effort to get free pages on a memory domain (NUMA
node, zone, etc), in my opinion.

To be honest, btw, I'm not a fan of "promote/demote", and that was one of the
reasons I insisted "DAMOS_MIGRATE_{HOT,COLD}" instead of
"DAMOS_{PROMOTE,DEMOTE}".

> 
> I also found that man page explanation about MADV_PAGEOUT is "reclaim these 
> pages".  If this is correct, then maybe demotion isn't included in "reclaim".

I interpret the term "reclaim" on the man page with a flexibility including my
above definition, and hence I don't think this is contradicting in a very bad
way against what I'm understanding.  That is, I interpret the documentation
says MADV_PAGEOUT can also do demote pages under certain conditions.

I didn't write the documentation, so I may be completely wrong.  I also
frustratingly lost my resource to validate the main question of this discussion
(whether DAMOS_PAGEOUT can also do demotion or not), for now.  I'd like to
continue this discussion based on code rather than a documentation that _might_
be right or wrong, and preferrably based on real tests if you or I have a good
testing setup.


Thanks,
SJ

[...]
