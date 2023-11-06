Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8241D69B;
	Mon,  6 Nov 2023 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7I1gDjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25238C433C8;
	Mon,  6 Nov 2023 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699289527;
	bh=GH4rizvfiL8Skfe2XSF+3TdIIrRGXQVKbVpTQfYNGF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7I1gDjKT1fOKFyyxbggkwZSIm/KlVmyfYlhNV5MzLzR7TZd00U4Ex+OduMTGLFfm
	 blvUK+tjCzaGVoQsJnsMmUGM6WzNFIkD6BEnHlweFjMAu2cki1m16cvp+t6iioHOVY
	 KzSrZDADnV+wrI3H1+KK5G591fEH8Iy4gYrJ/KpHCtATkaJ9U01HxjVD6h1z0EfArX
	 JaTeT9Sl2jYYFOgMdGl+umJfSWbiI/OnAjYVOWus8WSa+dqMNUhw+o5FM+VFC6CXEf
	 SO885Y0XkOGB42S2RX97IGwqiVZC9fepj4f+DbHGlM0mWKWk9wdlcbq3XZfQnUgsHX
	 hyXhXLjYKp2bw==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: eliminate potential uninitialized variable warning
Date: Mon,  6 Nov 2023 16:52:05 +0000
Message-Id: <20231106165205.48264-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <18d2f41d-e442-4f73-89f1-50bf20cd85f2@kadam.mountain>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 6 Nov 2023 19:23:47 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Mon, Nov 06, 2023 at 06:41:37AM -0800, SeongJae Park wrote:
> > Hi Dan,
> > 
> > On Mon, 6 Nov 2023 17:07:40 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > > The "err" variable is not initialized if damon_target_has_pid(ctx) is
> > > false and sys_target->regions->nr is zero.
> > 
> > Thank you for fixing this.  I actually noticed this issue from Coverity Weekly
> > Scan of -next tree (CID 1570878), and was about to send very same fix, but you
> > were faster :)
> > 
> > > 
> > > Fixes: 0bcd216c4741 ("mm/damon/sysfs: update monitoring target regions for online input commit")
> > 
> > Cc stable?
> > 
> 
> The fixes tag is from last week so I assumed it wasn't in stable yet.

You're right.  But the broken commit is a fix for stable trees, so I was
thinking this fix should also be merged into the stable kernel together.  I
think stable maintainers would do that on their own, but I wanted to make sure
by explicitly Cc-ing them.

> 
> Also to be honest, I wasn't totally positive this bug could occur in
> real life.

Again, you're right.  The uninitialized value can be returned to the caller,
but the caller of the function is not checking the returned value, so no real
problem can occur here.

But I think the unhandling of the return value is a bug itself, that not making
system crash like things but might make user confused, so I was preparing a
followup fix for that, too.  So, though the problem the fixes will fix are not
significant, I'd prefer merging this and the followup fix to stable trees if
ok, since those are anyway bug fix, and should be simple to apply.  If
something conflicts, I will provide backports.


Thanks,
SJ

> 
> regards,
> dan carpenter
