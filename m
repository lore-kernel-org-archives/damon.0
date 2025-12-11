Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B779FC0A
	for <damon@lists.linux.dev>; Thu, 11 Dec 2025 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433057; cv=none; b=c9Skk33/CQdaTZ2uf/BefW2v0UgF8ThTpMWs8Z38GbY2/yyNwKh/bqLyBMvVa9pJFK4+b8lxYItarsQf9VxSzd1ExMiqJlrQTyfI9WBMYp/p1TFDaFI0eQEOHjKEGqMqRd1TTyCHsAoHrBUSPAslpKQl/jBFAgttGZCfYCbxgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433057; c=relaxed/simple;
	bh=BVPTFvay2BavFmovTX+OOoOefFkQfN54jZGSLeoCJNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOJhe2KZse+3hHTAekat30BLOdZ/azzkl1w5qogHh1qR5uJoQUlHwOI0aLQV3ZfAu7NfsCJoAP0U4HIAwfEy6eWJgFtYdikzbVDAtdSQyu52xpn+fudBellMqSjq5zzubVau97oCb0HEyGyvUzsQk/jd3uGdgEhS5Rvjl5MbgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBQBsdtH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBQBsdtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E092C4CEFB;
	Thu, 11 Dec 2025 06:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765433056;
	bh=BVPTFvay2BavFmovTX+OOoOefFkQfN54jZGSLeoCJNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBQBsdtHO+uingZR4s55C823rSHJT9TLEELvdy5RwB4zRpzx0SA7f6PkpdZBY5Tms
	 zcaD/Nwr/kqJPi8YaDr2BuTs7Tern92Ss0DF0K7kcPrfounpN8ZxRifQH6K4yoJO6t
	 ljlvYOZPvFML62jA98n0pGFwRnYHfAGEcMu/BkbHdoFDvDZYncMm/iUJ4swiqgPuLs
	 hwH8zgzPosSVoZ5rhadruP7j5804gxIQlUEFZgfbj8ok/5mXlTBtcIw5EDui/bd4Go
	 J5R0zOuyjlolByr7jhLq6EmgtdeKsjrUdIIcWff6jYnZ13FB7Ae52jgIBZGnqvuPZo
	 7oV6d7PDdJyJQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
Date: Wed, 10 Dec 2025 22:04:12 -0800
Message-ID: <20251211060413.60534-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6bJLf=LuBpm90n5poz8Sqhz9wjXtk5ypbPwkvhb1ptag@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Dec 2025 12:29:59 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Wed, 10 Dec 2025 at 11:54, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue, 9 Dec 2025 21:20:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
[...]
> I suggested removing the dealloc_on_cancel condition from the patch.
> When using the damon_call_control structure, if you only use kmalloc()/kfree()
> when canceled without dealloc_on_cancel.  However, currently, in other modules,
> since it is static struct damon_call_control { ... }, kfree() is not allowed,
> so dealloc_on_cancel condition is additionally required.
> Because kmalloc()/kfree() and static are mixed together,
> dealloc_on_cancel condition is required.
> As you pointed out in the previous email, kmalloc()/kfree() has the burden of
> memory allocation and deallocation, and static has the disadvantage of
> increasing
> the code size.  Both have their pros and cons.
> Among these, I proposed unifying them into kmalloc()/kfree() methods and
> removing the dealloc_on_cancel

Thank you for kindly clarifying this, JeaJoon!

> 
> >
> > Meanwhile I find the feature might look complicated, or not well documented.
> > Specifically, dealloc_on_cancel should be set on only dynamic-allocated
> > damon_call_control object, but that is not well documented on the kernel-doc
> > comments.  Are you saying removing it is an advantage because it makes reading
> > code easier?  If that's the case, how about improving the documentation?
> >
> 
> dealloc_on_cancel is only used in mm/damon/sysfs.c.  Here, since kmalloc
> the damon_call_control structure, the dealloc_on_cancel=true condition is
> required.  If you want to keep the current code as is and only change the
> comment, it would be clearer to comment it out like this:
> 
> De-allocate when canceled.
> --> To perform kfree() if allocated with kmalloc() when canceled.

Sounds good.  Would you mind sending a patch for that?


Thanks,
SJ

[...]
