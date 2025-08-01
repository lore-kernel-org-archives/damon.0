Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663D19C556
	for <damon@lists.linux.dev>; Fri,  1 Aug 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067754; cv=none; b=RZy3v2Bv5WezpcY+2BYd1eqc6aVsVcVlwfI3OZCCAN+Tw2VSt81wv+M4sPaGBwrZBYp7FDeR3Kvk0XPVjozTrIjZfjYlYPxuzE43azgkSTbYF+AL/Yre+/ZRj6fwazN1YaTqKWydK2jZcHv9o4ezsIv3bZOpRYJMab50Gm0Bp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067754; c=relaxed/simple;
	bh=UcW2O+y87SzU13pq/hmDWWAZ/pxri1/7132KbeXpyMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRRwpu250QElG8B+g7OX4zP2AC1qd6XJy9MQst4D1MX8osRcoY95IgAh6gj4jAopQbN+4echHIOu48/Jqcq+LvdzEeBLemaiN40i0UfycO/LG8slPkGWfKUPnk4Vh4b2E2GWX7kg8EDdegZ6yaGuHG0RQ3cHI05og1ftt2zk3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/UTCOQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/UTCOQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1ECC4CEE7;
	Fri,  1 Aug 2025 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754067754;
	bh=UcW2O+y87SzU13pq/hmDWWAZ/pxri1/7132KbeXpyMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/UTCOQcXcyIQd1cFZ95Gx8uHlZCZT1BawtuiTbHHW9WrS0EyoVSe3HUUymBPEuIA
	 2XazgA7JBNBm4FktMi8wDjMTJXFo+MDyjqCMocOVgmptxPRQ3NM1hIMQHZerOML004
	 X66XVgljocps091k6fR/y2fgsnCbWPjTo+2SFwNuhq4h8bmY/vWK9KHgdcSuhHfDY3
	 wY5sBUJF764SpcFD9ySMNRcu76OcxsnrWXt/OHBGAQHZYJmyNHpnLUnf02Y7keuZxF
	 eirQXyUJ+FP7b2faz5aa0LMFhOAbnmRs7S5jN9WkO2kgXyJQPaD99dmDqraV33+9fh
	 QI7yu1HChdNdA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Date: Fri,  1 Aug 2025 10:02:31 -0700
Message-Id: <20250801170231.8532-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMGh7-vDgNzepJKtrhdOF40_U7=NT6Jvm85qtdwGpBZawg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 2 Aug 2025 00:34:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hi, SeongJae
> 
> On Fri, Aug 1, 2025 at 2:58 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello Sang-Heon,
> >
> > On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > Nowadays, damos operation actions support more various operation set.
> > > But comments(also, generated documentation) doesn't updated.
> > > So, fix the comments with current support status.
> >
> > Thank you for catching this and fixing!
> 
> :)
> 
> > >
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > ---
> > > I also found below patch(https://lore.kernel.org/damon/20250730200239.60984-1-sj@kernel.org/T/#t)
> > > So, Is it means that DAMOS_STAT is only supported by paddr now?
> >
> > No.  'vaddr' supports DAMOS_STAT.  The patch is not adding DAMOS_STAT support
> > on vaddr, but extending the support for DAMOS filters.
> >
> > Thank you for checking the thread and asking this question, though.  I see this
> > as an important signal of another rooms to improve on the documentation.
> 
> Thanks for your kind review. I really don't want to bother you
> anymore. But I would like to check my understanding.

No worry, questions about DAMON never bother me.

> 
> So the basic operation of stat is covered by outside of
> `damon_pa_apply_scheme` and `damon_va_apply_scheme`.
> If it's not too much trouble, could you point me to where they are?

It is covered by damos_update_stat() in core.c file.

> 
> And some extension stat (maybe it only renewed that filter exists) is
> covered inside of upper functions. Is it also right point?

Depending on what you mean with "upper functions".

damos_apply_scheme() in DAMON core layer calls
damon_operationss->apply_scheme() callback of the current operations set.  The
callback may handle DAMOS filters or not.  The callback of paddr.c handles the
filters for DAMOS_STAT.  The callback of vaddr.c does not, and Pan is extending
it to handle filters.

[...]
> So, I think that I need to send v2 patch, If that's right, which way
> would you prefer?
> reply to this thread or make a new thread?

I prefer making a new thread :)


Thanks,
SJ

[...]
