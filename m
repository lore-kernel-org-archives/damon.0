Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A863FAE0C;
	Mon, 29 Jun 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725875; cv=none; b=RusnoHniZQ2mzL6fs7CKvavJLdA1aFQUzJ/ysvfJNid/QHRr1ZUSm616B1whQN+fLqiYg5ot7ChmlPfC64Rq3CY0wDQxBtI7vx/kpn/I7YOuw0MhybT5XquQZSiNrkw8zPQ7GdAhAI2k/keAe4Vex3qjtCTb7az++ILW9rVNkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725875; c=relaxed/simple;
	bh=J8WsQBKvHb7mQ+WLW9nY84R20on5j0e62osMSg5XY+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuHxvWgrfiNa9CNP0GHTuZwPD47whc2cXaQDPYcIgNcnaNMsSzHCDkauaKVDzBGPGfPt1oJQxGxw3K70ZiuJfTib3luIlYdEe1JvtZtSQoezTAa+o+BKatY+BhPIdXBtFpKjUnWBNyt2+sw69WRGxyOZwVZwlbsBxJu99vVPY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkDD6PeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkDD6PeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5001F000E9;
	Mon, 29 Jun 2026 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782725870;
	bh=2ykDqQthUIfZEJ7dIbtthe8frR9Jp1b202KOCImO0vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bkDD6PeJBe0Eiz6yk4EBHTxFLSR5KVzPauMT7cIQo/w8NK//QVEAr3DqMsXywZGNk
	 TwFeTDqwgMEYIbg5ULaaOX2gu+k7PAR8HEb+vTadn8bKdJGTWhDH8cEjvCiHyNwH5Q
	 KI8Mx/1EWTD1XzWut1Gww3uSF52+pWqdKaihQj4ePwFCm90bEXHBDAXe2lhz+YwNZY
	 ccCCHn4ZESIwb9hph1uKI1qlrtdQ2L9WTQIN7GZHeu7rAJxQw5fIDS7URx/Df3c8pS
	 YF42SlHCHqOukeANTh8vaKslqZdxtTuX7CqZb6s9QNw4nE+cehWl99n2yV9ZKIqYlU
	 U65ltqXwJXG0A==
Date: Mon, 29 Jun 2026 10:37:41 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
Message-ID: <akI8lkVb5CICUcWi@lucifer>
References: <20260627195630.24519-1-sj@kernel.org>
 <e29d1211-8bc3-433a-b1d7-d7fb44c2f0cd@kernel.org>
 <2vxzo6gtk89r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzo6gtk89r.fsf@kernel.org>

On Mon, Jun 29, 2026 at 11:25:52AM +0200, Pratyush Yadav wrote:
> On Mon, Jun 29 2026, David Hildenbrand (Arm) wrote:
>
> > On 6/27/26 21:56, SJ Park wrote:
> >> My legal name and preferred first names are SeongJae and SJ,
> >> respectively.  I was using the legal name for commits and tags, while
> >> using the preferred name for conversations.  It sometimes confuses
> >> people including myself.  Consistently use the preferred name.
> >>
> >> Signed-off-by: SJ Park <sj@kernel.org>
> >
> > [...]
> >
> >>  #include <linux/pid.h>
> >> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> >> index 1cfb8c176b873..fcf7c7fadb5fe 100644
> >> --- a/mm/damon/tests/core-kunit.h
> >> +++ b/mm/damon/tests/core-kunit.h
> >> @@ -1,10 +1,6 @@
> >>  /* SPDX-License-Identifier: GPL-2.0 */
> >>  /*
> >>   * Data Access Monitor Unit Tests
> >> - *
> >> - * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
> >> - *
> >> - * Author: SeongJae Park <sj@kernel.org>
> >
> > Just curious, why do you drop the author and copyright information? (can you
> > even drop the Amazon copyright note?)
>
> Off topic, but I am curious how these copyright notices are supposed to
> work in the first place. From what I have seen, the person who creates
> the file normally adds one for themselves/their employer. But then other
> contributors who make small/medium changes don't add theirs, even though
> they should hold the copyright for the code they added. Bigger refactors
> sometimes add a notice but that isn't done consistently either.
>
> So do these notices even hold any value? They certainly don't list all
> the entities who hold the copyright to the code in the file. Only git
> log can tell you that. Is there even any point in adding them?

It strikes me as a rather loose convention.

I am not a lawyer, but I would say that individual and corporate ownership of
code are implied by S-o-b, not by comments in files.

Certainly there's not been consistency on this!

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

Thanks, Lorenzo
