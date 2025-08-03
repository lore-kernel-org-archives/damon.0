Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0014A4DB
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754199031; cv=none; b=HxDyWmcNAIMVsmoL6ZhReDw29DwZfpsNixWohIsVtL1TSlQAVOacgGrh1gVk9hDFhQNVbVHJSCyHeRqTvjIk40dvhrIyfvmUDuQzNqUA5t9PvPJzYKufsi4i1E37ZRIUNZcOGfFgJ/57OakrXOaaGIHxJD/1A+gOCiOE9mWEJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754199031; c=relaxed/simple;
	bh=MkwO48Cyq60e/luJ0nQYGYvpsWKdgTiBB5C4p3DKei8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWGTMXWCnjx0fwX58PI/6KI4fKokK5EDXS6gJcVj9G4HgRaxy6xYoRbJl6iMJxXENFiu4ChnOAJ6UxJPZR1/Id0wVwjP0e1HrBisZn/O82IMyfBZWN/S1Io+NdeCmRUKvx++DRiaAsHxaIS0u0TFKkBF4nr/nmFVyxmfr2Nuzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivfNHzAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivfNHzAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7164C4CEEB;
	Sun,  3 Aug 2025 05:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754199030;
	bh=MkwO48Cyq60e/luJ0nQYGYvpsWKdgTiBB5C4p3DKei8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivfNHzAc1rwjUJFCGtPL8tApG/XuOXeS2VvqyWoOX//q5MUOo+SWhrMnBsDgpIZkD
	 uy+SD0aL/8W9qiL1cXrOG/G0Bp2Y92eGxfccKlHNi4HsMHT/tybAkCCzZKnU6BtkNf
	 ips0BPijRsoXaxnukiQ0AUiMqYrlZ5ZuG8RSy8WMm0y9zQkZtbeuY3RpRGN/UEqbKx
	 ZHBLFFk/QC+yd5M7JSLBON5JcnsIcnctvKWN+07NxmmTOx9OncMpwMeAu+aWUI/LqD
	 9ZF96LeXYL36a1Hp6yVXzOix5ANTubUdT+ogQPsqQ2H1IeNu1P1XDiHHbLxXcAFIrm
	 tUnAadYcYFokA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Date: Sat,  2 Aug 2025 22:30:27 -0700
Message-Id: <20250803053028.51309-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <68a36ae4-5dc0-4023-b850-2af0401d6d75@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 3 Aug 2025 13:43:03 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On 8/3/2025 1:22 PM, SeongJae Park wrote:
> > On Sun, 3 Aug 2025 11:03:12 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> >> Hi SeongJae and Sang-Heon,
> >>
> >> On 8/2/2025 1:50 AM, SeongJae Park wrote:
> >>> On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >>>
> >>>> Hi, Honggyu
> >>>>
> >>>> On Fri, Aug 1, 2025 at 8:35 PM Honggyu Kim <honggyu.kim@sk.com> wrote:
> >>>>>
> >>>>> Hi Sang-Heon and SeongJae,
> >>>>>
> >>>>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
> >>>>>> Hello Sang-Heon,
> >>>>>>
> >>>>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >>>>>>
> >>>>>>> Nowadays, damos operation actions support more various operation set.
> >>>>>>> But comments(also, generated documentation) doesn't updated.
> >>>>>>> So, fix the comments with current support status.
> >>> [...]
> >>>>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >>> [...]
> >>>>>>>      * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
> >>>>>>>      * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
> >>>>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
> >>>>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
> >>>>>>
> >>>>>> Nice!
> >>>>>
> >>>>> But doesn't it make confusion about whether this pages out to disk or does
> >>>>> demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
> >>>>> demotion, but it looks "reclaim" includes pageout and demotion together in my
> >>>>> understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.
> >>>
> >>> To my understanding, DAMOS_PAGEOUT can also do demotion when demotion_enabled
> >>> is set.  Am I missing something?
> >>
> >> Actually no, please see below.
> > 
> > I'm unsure to what point you are saying "no".  Are you saying DAMOS_PAGEOUT can
> > also do demotion when demotion_enabled is set?  Or not?  Could you please
> > clarify, and add more explanations about why you think so?
> 
> I checked it again and found I pointed out in the wrong place. Please see below.
> 
> > 
> >>
> >> do_demote_pass in shrink_folio_list()
> >> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122
> >>
> >> The do_demote_pass is used here.
> >> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L1302
> >>
> >> can_demote() implementation returns false when demotion_enabled is on.
> >> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L351
> > 
> > I'm again get confused.  Isn't it opposite?
> 
> The thing is that DAMOS_PAGEOUT call sequence is as follows.
> 
>    DAMOS_PAGEOUT
>    -> damon_pa_pageout
>    -> reclaim_pages
>    -> reclaim_folio_list
> 
> In reclaim_folio_list(), it sets "no_demotion = 1" in scan_control, then invokes
> shrink_folio_list().

Thank you, this clarifies.  DAMOS_PAGEOUT doesn't demote pages even if
demotion_enabled is set.  Thank you for enlightening me.

So, "reclaim" means "reclaim".  shrink_folio_list() can do demotions when
demotion_enabled is set.  I hence still don't think this patch is saying
something very wrong, and how it could be improved.  Do you have more specific
change suggestions for this patch for an improvment?


Thanks,
SJ
