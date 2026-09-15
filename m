Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C41FCF41;
	Tue, 15 Sep 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439204; cv=none; b=J/4iTvQShDLBOg/U+cZYcAgu/8Lc+ZDScMYbOowH8Oda5B4eqE/AGk0KHsnoKf6iXKmPluT3CQa2Q2wus0Ulj2JQEVv/reIzecampaONxLcK1UbeuS4ynxLxORa8BoNIFMmGdBRcYo59AOVipLbCyj+mjm7WxccJpVP6Y4pHw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439204; c=relaxed/simple;
	bh=Uoy/2lm94lDcRPww1wKFu6Ac8t3BeOpOj7v6Z2BflHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT6zsxiH13ICMhInhZCxhTsiG9KUt98D+j9yL3PPCSdv7tZ7aJ1bMhO5Jtw5b8R2mdUzk4hGkrfft2n5s6239EgDjw16GUs49WCHqanMypl/2jZPJfOh3G+j9rNO6qM/wzYUic1o18LmJKVBIZMULpXX/SuP9PAX5aXwnprNzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPLksAgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPLksAgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D561F000FF;
	Tue, 15 Sep 2026 02:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439202;
	bh=FF/hMzJEEBjVHj8tu5+0x29Q3pa1mk5zwrpdsL2Gbqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XPLksAgYffr0yle6lKJ6XByLq/4bc3FRUCodqnf4SrClABYzHbAlOrsZjitB0eoFM
	 rFkVa/PJlHlAg2Ran+D/zwQBrPw9NSVmsdQ+90da47gwcAt9fnNMHf/lqveBv1ydk7
	 W2Coiaw+m17khA9iK1rsB6UZp7xpk8hrVgSUreA6NQnsSf0woOVy5FhFt8NYn0X4AZ
	 xiQyesN0WbmdeGF5iOnybS/2YvZux6O/LOm9qDKkCtrGxH6kh5mSnYXOxfm8A9Q4Tr
	 wayNzZCNfrYd0BvA6va5cTa+uUq7QT7ObBguny0eiGOnr7f5zEKCGuBHN/XIi9Hk+8
	 A9QDivFwMiVnA==
From: SJ Park <sj@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lianux.mm@gmail.com
Subject: Re: [RFC PATCH 4/9] mm/damon/core: use damos_quota_is_set() in damos_adjust_quota()
Date: Mon, 14 Sep 2026 19:26:33 -0700
Message-ID: <20260915022635.103818-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAN_Opa8qSHcDNU8k=EWMywUADizJEhHPpuia3jMcZ13i5iYXgg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 10:19:43 +0800 KunWu Chan <kunwu.chan@gmail.com> wrote:

> On Mon, Sep 14, 2026 at 11:16 PM SJ Park <sj@kernel.org> wrote:
> >
> > On Mon, 14 Sep 2026 23:01:48 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:
> >
> > > On Sat, 12 Sep 2026 13:08:05 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> > So, if user sets only time quota, and then commits the quota to zero while the
> > esz is non-zero, esz is never reset to zero.  As a result, DAMOS keeps applying
> > the action with the esz forever.  Correct?
> 
> Yes, the stale esz path is confirmed.
> 
> One clarification, though: it does not keep applying the action
> forever. While charged_sz < stale_esz, damos_adjust_quota() still
> returns early, but damos_apply_target() continues to apply the
> scheme and damos_charge_quota() keeps increasing charged_sz.
> 
> Once charged_sz >= stale_esz, damos_quota_is_full() returns true,
> so damon_do_apply_schemes() skips the scheme. Since the early return
> also prevents the charge-window handling from running,
> charged_sz is never reset, and the scheme remains permanently
> inactive.
> 
> So clearing the quota can result in the scheme applying up to the
> stale esz, and then stopping permanently.

Thank you for detailed clarification, Kunwu!

> 
> >
> > If so, this may deserve Cc-ing stable@.  Kunwu, what do you think?
> 
> I think this is a functional bug in the existing code, and Cc'ing
> stable makes sense.

Agreed.  I will post this as a hotfix soon.


Thanks,
SJ

[...]
