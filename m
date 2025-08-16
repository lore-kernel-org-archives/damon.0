Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA017A318
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360175; cv=none; b=IBgAXUrIz2SDJtyxabUdaoNBllUjh/o9JdIxg9HUKXNL7jnEZbOMeDai9puqtaw5Ypnw0m6JvaH3OtVxYENCv7xDh8tlnbwfb4cnHDk83NWnXnS95J+0VYwJ6J3rKqUouivLF/MYb6+iDlxiRDjeuxkJhpwT0No6VmnDHg0B1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360175; c=relaxed/simple;
	bh=ktZjid3+BpzR8rOMcJIPTq3guGfZitnWVvcU1eZzbFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pa0fXlsmqkF87hWGk38VZWn7ebd/nRt/KcoetD0guCF5QF7oSRB5OLP0ENqGqDIAW0GI5lpELl94C0Z8zC0Y37DyquFEypi9o68rxKmcPax6kMNWZDzxNfKoOZXg/Gkg7E84mSuAIxw8Gztf0Ty8BXgeNstxQ+Ns+byU9dJyZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwMC0D2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwMC0D2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AE9C4CEEF;
	Sat, 16 Aug 2025 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755360174;
	bh=ktZjid3+BpzR8rOMcJIPTq3guGfZitnWVvcU1eZzbFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwMC0D2/2yQnF9vzZbqBk8XQjcx825f6bAT18NQKmIEjhUvEAJKC8YGaR7wsLrnYT
	 kKGigUhIwO6ZiJwCiiLsRZsFwJn8yDBG5OHKBCKxZlDvI7d+0KwoNw8GPJTXk2S7mF
	 HawKjKG17hQEtoeNgbvDbDQMVnmKoKOqv0gci8+LtqULDjIickRY4vrrcJZxcHj/8v
	 lv02uAMwrHy6V/eWYjPYN8OZzFBQQKC+S5x3awpNZGpbfKsWl9304Xf9dV53UxPRWM
	 BXyoGTqFT6RVIe65iTcB8VwDGN/6VKa0HGt4+a0Ps/CXtrI8mQCFE1aRPZg8yTLT8O
	 hn60Eq0gmRMCw==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stablee@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_commit_filter not changing allow
Date: Sat, 16 Aug 2025 09:02:51 -0700
Message-Id: <20250816160251.63436-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMG2Mr+zO6i7a2_J5S5j7+4etiQYFur=0a+U3oNOS8TMMA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 Aug 2025 10:18:13 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hi SeongJae
> 
> On Sat, Aug 16, 2025 at 2:25 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 15 Aug 2025 18:40:59 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > Current damos_commit_filter() not persist allow value of filter. As a
> > > result, changing allow value of filter and commit doesn't change
> > > allow value.
> > >
> > > Add the missing allow value update, so commit filter now persist changing
> > > allow value well.
> >
> > Thank you for finding and fixing this!
> >
> > >
> > > Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
> >
> > At the time of the commit, damos_filter->allow didn't exist.  I think below is
> > more correct.
> >
> > Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")
> 
> I found a wrong commit, I'll fix them.
> 
> > Also,
> >
> > Cc: stablee@vger.kernel.org # 6.14.x
> 
> I'll also add them.
> 
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > ---
> > > While fixing kselftest, I found another bug and succeeded in
> > > reproducing. I think this patch is similar with previeous patch [1].
> > > Also instead of sending patch with test, should we check which is better:
> > > a seperate patch or patchset?
> >
> > Separate patches are better for me.
> >
> > I'm not sure how you will make the test, but I'd usggest making the test as a
> > kunit test.
> > Please refer to mm/damon/tets/core-kunit.h file.
> 
> I made kselftest with drgn, but I think that kunit could be a solution as well.

Thank you :)  I prefer kunit here, since the test should be for the specific
core function that can easily be tested using kunit.  Writing it as a drgn
based selftest seems too much to me.

> Honestly, I haven't used kunit test before, so i need to look into of
> that. Please just wait a little bit.

No worry, take your time and fun :)

FYI, you can run DAMON kunit test as below:

    $ ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests

And the document is available at
https://docs.kernel.org/dev-tools/kunit/index.html


Thanks,
SJ

[...]
