Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2361A9F83;
	Tue, 30 Jun 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782781243; cv=none; b=uRZi5d0AMn/YDiDnwVq4VuVoScFX1GdMPx6IeUeuduIbdlWcUL/Qlad65svzWnKKCY4+CnthlutF/QIHOJ/7N9QsQAhS6WHpj3Z2TomHp4REqsOYBVwq9qzE8JqvAaf2xCoC+ay3sGN9NGVOSbJdDX+TPw5stobDTsoT398HJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782781243; c=relaxed/simple;
	bh=+0O19YP8kgTfN+PQbqrbvnh2QbxJ1jw2D9kPd11HFR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgTE7Mw4hdLC24intd1qRcRQ1z3r+s1Dui51XdKpzpdjujxhasoX2/T0DseT3jt4KQxOx/0UE2en7KHCKjzsP9owQ7xqjepxibGIfgS/c8wCHCCJsvnZ+iv0aFWwIG/POaal0F4zCYyEgC4d2NolR/DDbYAQLwXU14QSlOw0Y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMjCj8vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMjCj8vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC49D1F000E9;
	Tue, 30 Jun 2026 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782781242;
	bh=scNnJr0jcGc+I8Ey89cgibghmaTHBbkbZ3uJtZ4Ysls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMjCj8vmTGMiEd6DlOjN+Y2aaH5NimELhZqNChgYdwJgOvY4OgK/i2XMjYRetaipF
	 KmaJxhyyoZkkwBFBkYY0ymUjP6vUhPz5qEswXUI60vZzOMWPrzejeHotR5Sdi2NSm/
	 d7rmm5r8VhuBAjnXlfani90BT28mhqSDRRV6r7Y2puL53IYxDLo0fJ8iRzErtg4NCq
	 XyT+0pONtW8Iww5Gph6rKCE/+/QFk8xb12BhA9ITQcy55IUxTUlNkoMYYn0AYeclgb
	 27T2nK7TDHwrVjC1ORiWKmOWGESYOyKeHiM3nE3Yc/6pRMIJand7SRPhG5nFcuCYw/
	 xxFQ2FJ8uBIxg==
From: SJ Park <sj@kernel.org>
To: IgorpetinDev <igorpetindev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Mon, 29 Jun 2026 18:00:32 -0700
Message-ID: <20260630010032.141941-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629165349.4260-1-igorpetindev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 19:53:49 +0300 IgorpetinDev <igorpetindev@gmail.com> wrote:

> __damon_va_three_regions() is called only by damon_va_three_regions(),
> which already holds mmap_read_lock(). Since mmap_read_lock() is held,
> the maple tree and VMA list are protected from concurrent changes.
> Remove the unnecessary rcu_read_lock() and rcu_read_unlock() calls.
> 
> Signed-off-by: IgorpetinDev <igorpetindev@gmail.com>

We prefer using a real name.  I show you used 'Igor Putko' as your name before.
Any reason to change the name?

> ---
>  mm/damon/vaddr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index d27147603..345b89b5d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -84,7 +84,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
>  	 * If this is too slow, it can be optimised to examine the maple
>  	 * tree gaps.
>  	 */
> -	rcu_read_lock();
>  	for_each_vma(vmi, vma) {
>  		unsigned long gap;
>  
> @@ -105,7 +104,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
>  next:
>  		prev = vma;
>  	}
> -	rcu_read_unlock();

As Sashiko also commented, this may cause lockdep warning.  Actually this was
added to fix it.  Refer to the previous discussions [1] for more details.

How about moving rcu_read_[un]lock() to the caller test code?

[1] https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org


Thanks,
SJ

[...]
