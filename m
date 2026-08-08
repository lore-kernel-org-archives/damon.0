Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAA27A907
	for <damon@lists.linux.dev>; Sat,  8 Aug 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786229463; cv=none; b=Z6bdx2t3jQyA77STdL46kSw5DQFOjzGRZTpftvPSKLnjeR7OQIxKlaMfEPbfPf2NF4CLprue9LorcKMQLhl/jh3kUoY6jWsDRjZ2ItOs9O0amFHBw+oB04oGynIes0KEh5yDwwQpJ82ONshFJvdNcX8tGWUWqZAa05QFnn5kiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786229463; c=relaxed/simple;
	bh=2AvT28+1mkqRqQsl1lZ0HnGUdF/dLc9q1c1Yz7ynq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQEmJITWV6VhLuk7bOMRqLC7KDVeAzscuqTus7jY9iHeUtHTkQPKg5hLUYde9JTsEqLUdh/YJHTHXImOkUQO8QcaJRtiI/XR/7VG/xuipZ3zNRiwr+/47WoHQaoDddiOk9ujiJOgkfNaMT5RKYRxx5cny9MIcnHuGe8lLffdJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPHVB+Rs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPHVB+Rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA7E1F000E9;
	Sat,  8 Aug 2026 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786229462;
	bh=KkFvMXuG7BcwFpCDdU5hIsGSAAXYTgJuEvWnM2X5PGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPHVB+RsV8E8ByYQeqKs4psTqgiGZJiFaUvXjDZL7W756Idf++GXwTy+3W8SIaJ6Z
	 u/baU/vgMOYHfRXSBKOmKjB0V13msSrC0CXt0D/42iHr7kQICeXkzbEJ1961TAbnID
	 jE1rtTqqbLe6cj9oGheVGP9DxxskWP8qAC9Zby1sq7/+s7XqLasthNJIJ7ge8I1jLo
	 VZQHd1Jqv+/uNTqgPCTT6qlYxG1bXOC+9Izg6XWI7Zgd83d6gF3lIZQR8zkM6qMfiU
	 u79ZMfCFqU0QiT6uAeci3EDxjdw3rfy7Gs5SbzorzCBKOsCtj/R65v3S/8wmo01ReX
	 vrqk1EvQAoe4A==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark checks and add fallback sleep
Date: Sat,  8 Aug 2026 15:50:53 -0700
Message-ID: <20260808225053.111143-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808215554.6045-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  9 Aug 2026 05:55:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> On Fri,  7 Aug 2026 07:07:39 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > This is an intended implementation.
> > 
> > When all schemes are deactivated by watermarks, DAMON stops monitoring.  It was
> > implemented in the way because we didn't want DAMON consumes system resource in
> > the case.  But, later it turned out DAMON's resource consumption is really
> > negligible.  Rather, it is turned out that it makes DAMON runs with stale
> > history when it is activated again.  Particularly, regions have 'age' and their
> > start/end addresses that was emerged before the deactivation.  Those are
> > meaningless and could even cause wrong DAMOS decisions.
> > 
> > We don't want that anymore.  For a case the user really want DAMON completely
> > stops, we introduced 'pause'.  For max_nr_snapshot-based deactivation, we don't
> > intend to completely stop DAMON.
> > 
> > Maybe the documentation can be updated to further clarify this.
> 
> Wait, according to the documentation and the code, DAMON will still stop
> monitoring when all schemes is deactivated.

That's correct.

[...]
> Should this be changed to monitoring will not stop?

No.  The change you mentioning will be unexpected behavioral change.

> 
> Also this patch (0002) add a new function named damos_is_deactivated(),
> it checks both wmarks.activated and max_nr_snapshot conditions, and I
> replace the wmarks.activated-only with this new function.

Let's distinguish watermarks based deactivation and max_nr_snapshots based
deactivation.  They are completely different things and have different
behaviors.  The current documentation may confused you.

> 
> I am sorry if my commit message has caused you any misunderstanding.

No worry.  The current poor documentation is the one to blame in my opinion.


Thanks,
SJ

[...]
