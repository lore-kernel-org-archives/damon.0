Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9B33508E
	for <damon@lists.linux.dev>; Thu, 14 May 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775395; cv=none; b=TVc5t7JZvf3u3EoCHqy/+acTzWlsjwjwS58CVjOUUJJWKcZ5XYxmNoaFwOKeRpB5n8Onry09ZKM4UK9OlcL10bSuoW9v1sdBYfYRNM0jDySaX/LqKK6zRmGuT2zdIhqQIFgneLbUl/4JXyGO4GJZOi/F+nGEMxxyzXHa9InjO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775395; c=relaxed/simple;
	bh=vPZytYVcITmzGo0US1ov+HlfGbo1AmCL7iCHd1B5f9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag6LIQwArb7Bi0gozj8Ew7soP8VHgEdIE2+aR/Qy84ljd0ibL3BZMi5ze6aUv6ke099A+BiTWKgmcwRdLrISPY14pAycU/Cj6ate50j4ybobhbbYm1r2FzRDzAipPaxp62Rj6pzu+/C3peIIGKvATX+PhnNiV/LUarlREDEzIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=I1DFGUpg; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="I1DFGUpg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778775353;
	bh=vPZytYVcITmzGo0US1ov+HlfGbo1AmCL7iCHd1B5f9M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=I1DFGUpguoC/ELgW9YTjAucqIJ2l8m4mGLTA7ZwamWBgWaI5bf5gyPEJScG4Y9JL6
	 emCayLrB31yvcjMGm9censcdCWa/gdUhBUSF8ix8Uyffm3v39eCTcdv6HqYeaOQ1VH
	 rjMq4L3u5j4s6qDgyUOZ4QILxYbwGeqbAU1Vrwbk=
X-QQ-mid: esmtpsz17t1778775343t6ca3eb4f
X-QQ-Originating-IP: vrWW6BuSRxD9TSZH8skV7QWrQbN1BOvy3B87NDGtOOY=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 May 2026 00:15:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15235211266130383440
EX-QQ-RecipientCnt: 7
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	kernel@uniontech.com
Subject: Re: [PATCH] mm/damon/core: recalculate intervals tuning deadline on attrs update
Date: Fri, 15 May 2026 00:15:11 +0800
Message-ID: <B5D4AFF20A1D18D9+20260514161511.3391771-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260514144102.120203-1-sj@kernel.org>
References: <7946CE4E0773AEF7+20260514074846.3258908-1-niecheng1@uniontech.com> <20260514144102.120203-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OJP+M+4ND1xCNlU6XS5SFqp7/1oRyKDql50I3o6oIcT/itS6sOQhmsG/
	FYyAvK+MBVAc5wn3iUBmIVn0epHl5Ot+S5WA2lle5oSCyKTjLjRU3GMwAs8UiGyrJ2UOzcA
	iQfl+rpi0V4SPQbKLFHy4ZUhm8a0AxvR7FH8rNKziDj37kDOTviG3nRxW8oPCCCM9QC8p6Z
	ka+WecUHJjU9WPzMjMLdbSohVLAjCKRI4X+Q1sLi1noT6UEOHxS8Taues9C00xWO1xuQ6+j
	Xns6D/QlWMhOTgniOJC7llBckbrkKzSeWty/ZIy2I2iwgNvlLqf+ojgrrh07++yDe/hlwrS
	v/O7PAwPLPj82jykYkdp3klrHOWcrMDdO7jgilaU+laEEW9Vj0Bz3A5oFl9aSNcNrfe8aQ8
	veF1+kU7vw5xOPNimd3Ge4jOSjAW9tqXNrNQ6YvWKH/KcKmMSnLAt3HhwCZBSVuMMtXS5V5
	lM3NZZjXvMzmynSnXXTqR8eK/UosDF0ZijnDWg9T3/bSZc2UZPaV8MWJ75yFdDmGRX830AB
	LwHS6pduocBm/24sWTkhW4zXIT+FD6pkxeq9jiOwIqy8gtUo1m0ybAYRnIJ++6K/bV2SbGP
	BvqqpgyeEImksKqjS/hFavfso+Vu31hDDsB7fUQvwjYiovsdZIdz3YO+USBm2+WGfD++Wfr
	GFnPH8g6u7Mx+jo4HHpxb31Vd26JDGRsIPnWDMq8tf9RNncyYLOYYzTOIiUrK783a+OY14z
	Jh2k9NApKi2h3GC0Ox5gdnzFuzqH4N6KBrIvmpi1uCX9YZHVC+uDFLSHeKgMve3OCLhjq9b
	7DN44s8fVI3su2ca2VdL8hgMoxkMy64oVzfVLqXikaNvzp1qY8xDXZ/d7/X5ddgeSkmdQ1u
	cIbnCbDL1MHBOfcWmlxjhWoBf8tNu5Q6i0bsS4AliGaCFzB9Yz+2g7un75Wc7mlsv8r1Zrh
	g/uKiPupPFt7pfeSKST4mqwSCknSXbK6LMWVaU+j2ibQcZ4oN6OKKLQ90CoZzTlVvPIo=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Hi SJ,

You are right.

I rechecked kdamond_fn(), and what I observed is a one-shot earlier
intervals tuning after the online update, rather than a persistent
stale-deadline bug.

So I will drop my previous patch and send a small follow-up comment
patch for this subtle behavior.

Thanks,
Niecheng
