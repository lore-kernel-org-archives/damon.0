Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F91B808;
	Thu,  3 Sep 2026 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394939; cv=none; b=plQXZKqLrMMJkUpQFoohkBNSPhVZm+e95eD63BtSS1IebftlcNMPfUDQRuq0WaZIBW+iF0XK97Qxa10pLHDogVAxAZ3kNJUgldMxFzkVPHoqS48kn/S6Up8OJVyGyOz3+FM751vjI+lJD+4S7X+ASyUCY/mbj+mG4MkGM5b34Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394939; c=relaxed/simple;
	bh=anklsa+KWiLfDaC+mvn0P/pKqpHnh8IBJFc4mqJ3qMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJtWeW2iaoNPL8wDij52RSoPLdNgY8r8tVBHl6te7S8i8DG5DRoEU5+czEe+Gkur6Yg5DfyMDvKUF7VMHm4be7fxCz9xsC+APHueEYLM6o+Q+zQJ8lfj5+UOZyxn5PrEghZAP6ZwKj/9OjHqItb1LgX9d44JvWGd59R44YH54g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gECNSOex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gECNSOex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFAC1F000E9;
	Thu,  3 Sep 2026 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788394938;
	bh=OxWQhFCQXWh0+Se6BwEJfMpRHGQJ8OFKAgPc6CcdDiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gECNSOex0hFA1rBKedGbmsFe8VUlJD1ARTyVupBjBwFJbckercbOnGGwi5aIOKJ6V
	 Uz8QrhzIvz6xyIDqKBW0v8oQJgzeCpQ5b8/NntQ6Ln6BFoiQXxZVQaY66JdrgmIUgH
	 r3h4an1LVt0/z1V78SKEumy3h/xubCLXsd41CxsvtR0jZ3fuYrtGhN9fy/GBHXO92o
	 kurITRekpi0dlFEwjXqOqRccoCz59rhiFMQIbUayizVUdM4fgIWXAP6Gf9cEFH7Ry5
	 4AvQF3wcI80RgAZSFpAI1HpWTM9Gg/RSeP1BSYXeEZmSgyOe6QSipbi2gS1Gy/90Kd
	 mB8S0W1I23X5g==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Wed,  2 Sep 2026 17:22:09 -0700
Message-ID: <20260903002210.46269-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902154944.4035059-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 23:49:42 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Wed,  2 Sep 2026 08:19:54 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed,  2 Sep 2026 23:08:41 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:
> > 
> > > On Tue,  1 Sep 2026 22:47:42 -0700 SJ Park <sj@kernel.org> wrote:
> > [...]
> > > Both `sample_interval` and `aggr_interval` are zero here.  Since
> > > `sample_interval` is the denominator in `damon_nr_samples_per_aggr()`,
> > > would it be better to keep `aggr_interval` non-zero when testing the
> > > zero `sample_interval` case?
> > > 
> > > This would make the test explicitly cover the divide-by-zero protection.
> > > If the `aggr_interval == 0` behavior is also worth covering, perhaps it
> > > could be tested separately.
> > 
> > Thank you for your review and question, Kunwu!
> > 
> > Yes, that kind of additional test case would be nice.  Please feel free to post
> > a patch if you'd like to! :)  And no pressure, no rush.  I will also consider
> > doing it myself if it seems you are not interested.
> 
> Thanks for the feedback, SJ!
> 
> I will prepare a small follow-up patch for this test
> clarity improvement.

Looking forward to!

> 
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thank you!  Also appreciate your R-b: for other patches!


Thanks,
SJ

[...]
