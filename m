Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40128690
	for <damon@lists.linux.dev>; Fri, 12 Dec 2025 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511176; cv=none; b=Q9MyQP5MCJBGEGR9gMNWoMWWpu10/2KHmsXrQau63wFrqileGYK633IWu9eHmbZrwXYY29wfNhsGcWjUm14z9KHGgIXz+9tdm1zlBH1qeEMiSek9io5+uQHtRKmaYM1W9bY4V+tH+8+frj2UMEu+K3BtHDdSXUtRqWAywWgNOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511176; c=relaxed/simple;
	bh=qWErqwHAXMoJbr0ah1yv8tAp2YJDlDct0fUARVDvVi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTNMzN7CdV76lhffT/J7QxkqQu0rbFzDR1dvIt43gRhV9dwQ4GAPuwu5UwB6efzRmVV1Unxz5lCNyhlNVDMXreXkDSk6ueBJXjlPyCwZFaeKqFiRa+V7G3+VTWo2PBRJYD8XbSuze4wsyHlX0v+qJABvNQm/iY5BGK+Gm9lQf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4QZX/JD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4QZX/JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F894C4CEF1;
	Fri, 12 Dec 2025 03:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765511176;
	bh=qWErqwHAXMoJbr0ah1yv8tAp2YJDlDct0fUARVDvVi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4QZX/JD1nZN7473nf5CYMKQ0CFajZXk8vZziiCmrLgU2wuvXn55tATlM/mJvmK1w
	 6CIFM0Yh/83i+ThQSdmg5FIsxBkfKvkHApjPaIRqZlOFDdKIt5xUvOWK1rLfW/5zty
	 eFtABNX2glTPZuwG7CVCEliHWQT7Zx+SMaPhWw7i3vq/qx8tVSzVaemxW0WSqc8xXQ
	 I30rOT8i4WFzx1/vZHX+cWQpXjrpqbK3C7nQoY/xfDzKbNOAajcnvEV36Bam4cbNIh
	 qSPA4pCkOjZUzEiLkyzGl0BHBizALqxRMCG0FVSv9MykJZpRUQZmvQZC78aZ4PNCmZ
	 cagh4AXKUb6nQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
Date: Thu, 11 Dec 2025 19:46:12 -0800
Message-ID: <20251212034613.41033-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6ixeLQeTJANkAvQhRviLyr7=xNBs-_jeKEo+qF6E3qAg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Dec 2025 17:13:09 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 11 Dec 2025 at 16:54, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 11 Dec 2025 16:38:46 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Thu, 11 Dec 2025 at 15:04, SeongJae Park <sj@kernel.org> wrote:
> > [...]
> > > > Sounds good.  Would you mind sending a patch for that?
> > >
> > > Would you like me to send you the patch with only the comments corrected?
> >
> > I was just asking your preferrence, and seems you have no strong one.  I will
> > do that on my own unless you mind.
> 
> I have been argued the following so far:
> "I proposed unifying them into kmalloc()/kfree() methods and
> removing the dealloc_on_cancel."

Based on your previous email [1], I understand you argue this patch is better
to be merged as-is, though you agree it has the pros and the cons.  And
therefore you are letting me to make the final decision.

I was implicitly saying I show the cons more than the pros, so don't want to
merge this as is.  Sorry if it was too implicit.  Hope now my opinion is
clearly reached out to you.

I also suggested making the comment better, and you agreed it but I understand
you are not interested in making that change.  I will do it.

So, all is well and no more action from your side is required.

> I apologize for not being able to respond promptly and smoothly
> this week due to a busy my external lecture schedule.

No worry, take your time.

[1] https://lore.kernel.org/CAHOvCC6bJLf=LuBpm90n5poz8Sqhz9wjXtk5ypbPwkvhb1ptag@mail.gmail.com


Thanks,
SJ

[...]
