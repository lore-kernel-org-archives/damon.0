Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE0221F2D;
	Tue, 16 Sep 2025 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994745; cv=none; b=fcakGjdCuzKZBOyGDBgTBUeflw5VOecs6R2RxIuKAwFWc5wGs9A8JI+atia7zhVM5hWQ+hT5zdlFM2ITuzDGvFBPJA+tdHrsz4VjEhA6ousavBbuw7V66JGlsj75H/VlAyGxNiPmIE4vtdiFD369YfcOroqR1Lm0eeEc439qmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994745; c=relaxed/simple;
	bh=U6JxDMkVHB3XlX/9cQ/I2sPNKBRRoZiFmbtNoTrXKa4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OfodFccp4eIade1ve5dSMuJqewwFq4NPfdOYHlQStSMnELE3x1g+ROAwuFLZrotUn0YbIXb9GL0o+jluuEzVLx3LifGMuzgKhxkRMsMVMk7feY8Gv9048kXfO8DefBYXHBNztC2vNOKWAxu222jkbHjEULuAX1J2vKq1pBcHb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OsQN2Jzt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OsQN2Jzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0802AC4CEEB;
	Tue, 16 Sep 2025 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757994745;
	bh=U6JxDMkVHB3XlX/9cQ/I2sPNKBRRoZiFmbtNoTrXKa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OsQN2JztTjwkSYM58ujeukp87a4ECEkelesp8ge0DINPmvZSy5h/p1xe4h9mURfSv
	 FQiqDNxLHR4XatBx12+aIJ0QPxbZlpILve6PDnMXpemSMLwq91AIpoPya0owAU45WA
	 b9ZaFNFNdB7wMxMhO0pbZYH7WY269Sbd9PMrOpEA=
Date: Mon, 15 Sep 2025 20:52:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/6] mm/damon/core: reset age if nr_accesses changes
 between non-zero and zero
Message-Id: <20250915205224.aa2de8de6dad1bb4c048cec8@linux-foundation.org>
In-Reply-To: <20250915182652.110173-1-sj@kernel.org>
References: <20250915145158.1425390-1-joshua.hahnjy@gmail.com>
	<20250915182652.110173-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 11:26:51 -0700 SeongJae Park <sj@kernel.org> wrote:

> > Thank you for the patch, I think the goal of the patch makes sesne to me.
> > I have a small nit / idea which I think makes the code a bit clearer, at least
> > for me. It seems that we basically want to XOR the two values's zero-ness, so
> > maybe something like 
> > 
> > (!!r->nr_accesses) ^ (!!r->last_nr_access) or
> > (r->nr_accesses == 0) ^ (r->last_nr_access == 0)
> > 
> > Can achieve the goal?
> 
> Thank you for the idea, this makes sense!
> 
> > I know bitwise operations are sometimes harder to
> > understand, so I am just throwing the idea out there : -) 
> 
> To be honest I'm one of people who are not familiar with XOR.  I had to spend a
> minute to understand the above.  Maybe we can replace '^' with '!=', and it is
> easier to read for me.  If you don't mind, I will use below in the next
> version:
> 
>    else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> 
> Please let me know if I'm missing something or you have other opinions.

I have to say, using xor as a shorthand for what-was-really-intended
always bursts my brain.  I have to stop, think about it and mentally
turn the implementation back into what-was-really-intended.  Maybe
that's just me.

Ditto less-than-utterly-trivial :?  expressions.  Perhaps it's because
if-then-else best suits how our minds work.

