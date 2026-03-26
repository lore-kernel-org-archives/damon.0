Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26517239594;
	Thu, 26 Mar 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529446; cv=none; b=j1PQ9rw05KqhxCHkopGi/6+i6lOKwjeYmmdtQ2uTDNRMd990WNrhTExvE0MxlInWASMWs/s7paBwCLprFjMI/CiGuM//i2264npBG3KyGrB+9/8qn+meUcKD8b5nwUOJffwpZ3sc73HPujlozZRsIpkrw3eSVvnfS86Z+WNcVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529446; c=relaxed/simple;
	bh=fwAwjr3dXkS6nTcvpSDPT+VLAsOlThgKRLjNtbS1y6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh25mZBSWNIgqk5v/DDZcuMX7bzuz1/i2q7Rt2Qp6ypLOAzawu8VItEF3/xkagSgymnLfNG+nzD2PB2RZqVBsNzN0hsApnQy8HuYC3CyHcrUfmNa6Bv5aKJZCDmAHHNH1VQkULttPJsp1w9TtlL0eavMHnv69Ulxj8eYTOGNRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWlmJ3NV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWlmJ3NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDAAC116C6;
	Thu, 26 Mar 2026 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774529445;
	bh=fwAwjr3dXkS6nTcvpSDPT+VLAsOlThgKRLjNtbS1y6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWlmJ3NVBYQN1DmR0SAmoowJKAPNPmktqBf6kIJYCdRCbtX3MfX1k7QXj22OQ/HJk
	 vVzblWh/h3n7xlVJ6p2mbbKC6dbkQgGeF/DPTYul8tv7bktrv5NwzHH70T10OZr10a
	 ub0W1yKFdXJN8JQKISAIsfVcZJQQ6rAiPDoglXx9qf9yUojaQbPifpPFTAKYKIKBfA
	 W7NOzfqJKi15oT/HGhj+0vAVAuDwjg1Nm2EHiYLbfYqXh0mutwktoXyrN0TEIWzJ7m
	 h354zUlFK2sVrxEzq/r2hmksfDzRBnQtKnb/nvb4cx0UMvHll7RdxI+JLMhr3pUbAH
	 7/NSKUjmVmbHA==
Date: Thu, 26 Mar 2026 12:50:40 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Josh Law <hlcj1234567@gmail.com>, 
	SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Message-ID: <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local>
References: <20260326072737.341964-1-objecting@objecting.org>
 <cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local>
 <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org>
 <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local>
 <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org>

On Thu, Mar 26, 2026 at 01:40:19PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2026 13:29, Lorenzo Stoakes (Oracle) wrote:
> >>
> >> Answering to reviewers with whatever confirmation they look for is also
> >> a warning sign of non-trustworthy behavior. Or rather behavior trying to
> >> get trust.
> >>
> >> [1]
> >> https://lore.kernel.org/all/D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org/
> >>
> >> [2]
> >> https://lore.kernel.org/all/2F84DD09-2880-45E0-AA98-204F10848F85@objecting.org/
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Yeah this is really adding up to somebody abusing the kernel process. I think
> > 'Josh Law' or any other pseudonym that can be traced back to whoever's behind
> > this should be banned from the mailing list altogether.
> >
> > Also, as per Christian ([3]), it seems this guy was using the pseudonym
> > "techyguyperplexable".
>
> Yes, repos on that Github carry commits like:
>
> commit c04af501bacbef54cf97cdfb904ddf295f8327c1
> Author:     techyguyperplexable <objecting@objecting.org>
> AuthorDate: Sun Jan 11 04:21:53 2026 +0530
> Commit:     techyguyperplexable <objecting@objecting.org>
> CommitDate: Sun Jan 11 04:21:53 2026 +0530
>
>     ANDROID: sched/rt: reduce lock hold time in update_curr_rt
>
>     Move resched_curr and do_start_rt_bandwidth outside the spinlock
>     critical section to reduce lock contention
>
>     Change-Id: I8dfb4e33460ae4eeb0bb854cc2cb084ab5edf7e4
>     Signed-off-by: techyguyperplexable <objecting@objecting.org>
>

Thanks, it looks pretty clear cut then that 'Josh Law' is an openclaw bot.

To think he was scheduled to be added as a reviewer for literally all of lib/
recently (5) until various of us pushed back on it :/

[5]: https://lore.kernel.org/all/20260308202425.C9EE4C116C6@smtp.kernel.org/

Is it really that easy to game the system?...

I hate the asymmetry of this - we have to jump on these every time and they can
send WAY more mail than we can reasonably reply to.

I think we need a clear 'yeeting' mechanism to block these people on everything
once discovered.

Sadly the kernel has been historically very poor on getting rid of problem
people (The CoC is essentially a swear monitor at this stage).

In the face of this new kind of threat we probably need to do a lot better.

> >
> > There's a github with the same name ([4]), and that same user made a comment on an
> > openclaw issue relating to linking it to gemini ([5]).
> >
> > So it seems likely he/she is likely using openclaw to fully automate this 'Josh
> > Law' user and we're speaking to a bot here.
> >
> > (Screenshots have been taken for the (possibly inevitable) deleting that will
> > happen later.)
> >
> > [3]:https://lore.kernel.org/all/20260313-halskette-annahme-94e782eb4ae4@brauner/
> > [4]:https://github.com/techyguyperplexable
> > [5]:https://github.com/openclaw/openclaw/issues/44134#issuecomment-4106247302
>
>
>
> Best regards,
> Krzysztof

Thanks, Lorenzo
