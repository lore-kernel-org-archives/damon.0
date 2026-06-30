Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11B346795;
	Tue, 30 Jun 2026 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852342; cv=none; b=J+0x/8nZulPoyY5u8vwP7NzVuSoaEUOJl0LPI1YiJFSoIPeXRx85vGv6c4kBzq8kG0ig/Pd8YcZqrCxBB2U4/DSjMI4MQhw3N9fD1Csz8ckzVXvAvxHAeSoV3njUf0kMNAxDBizK49H/GZvIFgt1jiLbRDNGt3CGNo2wq8fajWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852342; c=relaxed/simple;
	bh=7AoBDHeosJxTTCkqPf1/iY4gME1XDvN52OlikcFna7w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fergZrAqf/H3+QBtHddveja0CBoN5AOS+NZ2cHak67supg9p1V6C1mRNQKZBaOq3Xh/b2jypXemmm8aP8AQkQwB4Ofp7LZtruJE0CVl67gUDD5mtI/2GDuul2zQuw+vo0NXqBKnqoVf/HJEa/3/FzMg1eN/aBvYhF9JQkNtSmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EMEdtcEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMEdtcEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0971F000E9;
	Tue, 30 Jun 2026 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782852341;
	bh=UjRiWzaf+3IXUGXwj4iWCLtx4c/HoCgAd+zOl3G+fYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EMEdtcEN80YUQ8EI2alDygIXdqQUbtvrCZEAfj9XCv0A0Y+RaQoEOVlTpRMRTq482
	 n3KjmDtTHqfmgrRLGDajhAwYs8VP0dOgxDOVRoPIanXzMEArowCb1Cewhc1uNQiAUw
	 DiHmL+aeJEFcMQ93LV3umNIP9yHtO430GFiMo6iI=
Date: Tue, 30 Jun 2026 13:45:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "SeongJae Park" <sj@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Ravi Jonnalagadda"
 <ravis.opensrc@gmail.com>, "Quanmin Yan" <yanquanmin1@huawei.com>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: reduce kernel stack usage
Message-Id: <20260630134540.550e55ba610ea956111d1e6f@linux-foundation.org>
In-Reply-To: <0c57d639-259c-4498-9b7f-3ac46d669935@app.fastmail.com>
References: <20260611125704.3386176-1-arnd@kernel.org>
	<20260611135608.66888-1-sj@kernel.org>
	<20260627223405.3533412b4010b6ce658da01f@linux-foundation.org>
	<0c57d639-259c-4498-9b7f-3ac46d669935@app.fastmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:29:03 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:

> This is clearly an
> uphill battle, but kernel stack overflows are a real and build testing
> with a reasonably small limit is only one line of defense against these.

It's a worthy battle.

Reducing the default CONFIG_FRAME_WARN on various architectures will
help.  It's kinda trollish, but we should clamp down on this stuff and
having Arnd plugging away on his own isn't a good way!
