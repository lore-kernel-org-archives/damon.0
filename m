Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90C313293
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774721190; cv=none; b=f1ZBl9fnKHLzHIg3177QG8bKW5XkxRgTB7UPjXA8Mmo2d3Ucp4XWXWQdtcLlNzu/TsnR31lGXVbyyse0XV+2OTKZ9XHt4XIB+pcDeBKti4+rCPYipgZDmEiH5FvvoQkSx2n3+CzY5DwF84rBJShcBjAZADayriM7eZMw8H1R1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774721190; c=relaxed/simple;
	bh=bPs9tke7nQbYZIsrIsj71vZ4XdK66k9kLYeKFKb62Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0N5T8gmhIOXH5cgkJ3J4jX+PA5zV8+X3XhX3MdCYnrxPnirD3S871VcMzpQWjwjuwWT0NIpd5iUBRRlbw1W+JC+Vbjsc5A0b0fDIFkokMsPttgBnmae4SODDEADOYz5IsS2KeKxGoZur/RtaISo6CsdliAzMU/0znBClITs6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKkYEKue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKkYEKue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741D6C4CEF7;
	Sat, 28 Mar 2026 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774721190;
	bh=bPs9tke7nQbYZIsrIsj71vZ4XdK66k9kLYeKFKb62Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKkYEKueqRXbP8h9DprgeUd+Y2/fbNYkGdLCRPoTjbI0Up69C+1TzXboKuvQ3Lc+n
	 Bpia6Ytj16VUednqyWu2sBUut0MSPwd/ZSXFQji9OCOHo7w/ta+qA31ZSQFmw28Sga
	 9A9uLCWMamzTA5UMGt02B/24Zmt3/1aHwLSBdrwjh/SUJEO7TDpuI9+lqHVV/YWvdP
	 77lg+Dxhc0P8Pb5Uj6pI4RPv6PHJO8mcSgdUq72H5g7D3vqxuwj6eApEifwNxGHOEm
	 BwI/VM691arleKuiOfOzLeXKeTVQh0TavScAAJsqkPw4fXJx7T/VlR2eXEGV7fSCrO
	 rQo5ko1+W4xHw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sat, 28 Mar 2026 11:06:28 -0700
Message-ID: <20260328180629.55498-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328174409.6786-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Mar 2026 01:44:09 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat, 28 Mar 2026 07:13:23 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > > On Sat, 28 Mar 2026 10:26:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > >
> > > > [...]
> > > > - Would a lightweight fix be acceptable? For example, performing
> > > >   validation at the very beginning of damon_commit_ctx(), and returning
> > > >   -EINVAL before setting 'maybe_corrupted' to true. Since no
> > > >   modifications to 'dst' would have occurred, kdamond could safely
> > > >   continue with its old configuration.
> > > 
> > > I suggested you to try something similar to what DAMON_SYSFS is doing.  But I
> > > didn't get your response to the idea yet.  Could you please let me know what do
> > > you think about the approach?
> > 
> > I was thinking this one more time.  So you want to ensure DAMON_RECLAIM and
> > DAMON_LRU_SORT not passing wrong addr_unit to damon_commit_ctx(), right?  And
> > that's required because exisitng inputs validations of DAMON_RECLAIM and
> > DAMON_LRU_SORT are not checking that.  Why don't you add the just one more
> > check there?
> 
> Apologize for the confusion in my previous explanation. To clarify, my
> proposal was indeed focused on implementing a lightweight fix directly
> within damon_commit_ctx(), rather than adding separate checks in
> DAMON_RECLAIM and DAMON_LRU_SORT.
> 
> The goal is to safely handle the context state transition. Specifically,
> I want to validate inputs before marking the context as potentially
> corrupted. Here are two approaches to achieve this:
> 
> Option 1 - Using a label for cleanup:
> 
>     damon_commit_ctx(...)
>     {
>         err = 0;
> 
>         dst->maybe_corrupted = true;
>         if (...) {
>             err = -EINVAL;
>             goto out_reset;
>         }
> 
>         ... other code ...
> 
>     out_reset:
>         dst->maybe_corrupted = false;
>         return err;
>     }
> 
> Option 2 - Deferring the 'maybe_corrupted' assignment:
> 
>     damon_commit_ctx(...)
>     {
>         err = 0;
> 
>         if (...)
>             return -EINVAL;
> 
>         /*
>          * Only mark as pontentially corrupted once
>          * we start modifying dst.
>          */
>         dst->maybe_corrupted = true;
> 
>         ... other code ...
>     }
> 
> I think Option 2 is cleaner as it avoids unnecessary state flipping.

Liew, I suggeted two options before.  But you are skipping providing your
opinion to those, and adding yet more options.  That makes me difficult to
follow the conversation.  Could you please answer to my suggestions and make a
consensus about those, first?


Thanks,
SJ

[...]
