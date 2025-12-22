Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FC277CBF
	for <damon@lists.linux.dev>; Mon, 22 Dec 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766439225; cv=none; b=aXdef7URxt4uuYjl/vKl3OII7qbBzF80iGY2a/O4HTU7zjj/vUXyXD0vwkm8wy5uMxDTaJvbcJqVa5kNZQyBX1eS4wd1D1t5ReJwNGpOVri4SBci6g30WcmpU8iqwQAlvfPjK9h+UczOHbwHhcDZG7NGRM1vLIK96thfq2CFcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766439225; c=relaxed/simple;
	bh=0r26v+vgZ7y2B5fP+hL/CfC1LxsSYQaGQALoSUVLma8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsHy9/l3OJrlHvmP9QnqoJXy5URAgQhPMK1aliWESGOife5Btm5XzyMfifexpyUQxLQ06KGq5fELxmjThRq1fJaQblSFVX2q3p7PVsOdHEMdkpsnsvXUEYZtjNr1FGISpeaCBHDA7tQYtHKOeGnThGCfc0D3+3XoWNjj6JaT3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOD3u4tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOD3u4tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5CCC4CEF1;
	Mon, 22 Dec 2025 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766439225;
	bh=0r26v+vgZ7y2B5fP+hL/CfC1LxsSYQaGQALoSUVLma8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOD3u4tqwmNzqI4c/1BKxggeRudS6Iou54JHJvqcWLOzHaEW/EKf0d/O+cTcfSka6
	 5KWyLlbWWNX4iOAYgUiXISlAcIN+icxrL5G/HmNLKsJ60T6pE/r18FbYJXKdtXBNyH
	 029BBUHq/UN+hpy9eFNAcUreDxYi3lPKm4pyFGzt1Fk719nBbO7haka/GvV5bVz8Aq
	 hY4rVHy2orsflqWD6XU+85M6pHk6WLNpYZpAJgJI0iOBc+CtqCBo1tUIR0vaJLykN0
	 dG8kIJVbsbkpP2IlbtwwdWMYDRrqqrLkV8YsXO2TXQuBZvRHGWVowecd5MEVm2jRsT
	 /3Da4VbMWdYww==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Mon, 22 Dec 2025 13:33:40 -0800
Message-ID: <20251222213341.3687-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6wQ5h5j42iTaepRnSkA6mqeY-ExpHA4Qc6K+-xb6T0eQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Dec 2025 05:57:55 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Mon, 22 Dec 2025 at 04:27, SeongJae Park <sj@kernel.org> wrote:
> > On Sun, 21 Dec 2025 20:04:23 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
[...]
> > > So far in my view, I have analyzed DAMON as follows:
> > >
> > > DAMON core  <---------> kernel module   <------> damo(user-space)
> > > mm/damon/core.c         mm/damon/lru_sort.c
> > > mm/damon/vaddr.c        mm/damon/reclaim.c
> > > mm/damon/paddr.c        samples/damon/*.c
> > > mm/damon/sysfs.c
> > >
> > > Above, lru_sort and reclaim are DAMON core characteristics, but they have
> > > a kernel module structure because they are executed with module_init().
> > > I personally think this is inappropriate.
> >
> > Could you please further clarify why you think it is inappropriate?
> >
> > > Additionally, currently, DAMON is
> > > executed only once at a time according to the exclusive=true condition
> > > when damon_start() is called.  In this structure, I believe that the meaning
> > > of "kernel loadable module"  is non-existent.
> >
> > I have to say I still don't get your points.  More elaboration would be nice.
> 
> To summarize the Damon I have analyzed so far,
> 
> DAMON core  <---------------> DAMON kernel module
> | mm/damon/core.c               + mm/damon/lru_sort.c (schemes setting)
> | mm/damon/vaddr.c              + mm/damon/reclaim.c (quota, filter)
> | mm/damon/paddr.c              + samples/damon/*.c (using samples)
> | mm/damon/sysfs.c
>             |
>         /sys/kernel/mm/damon/admin
>             |
>             +--------------------------> open/read(get)/write(set)/close
>                                                (user-space system call)

Nice analysis.  Please consider further referring to the 'overall
architectures' section of the design doc [1].

> 
> The DAMON kernel module above is a sample that sets some parameters of
> DAMON.  I think it's better to use damon/sysfs since all of this can be
> done in damon/sysfs.

I agree using DAMON sysfs only can be better for some use cases.  But nothing
fits all.  Hence we intentionally provide both general purpose user interface
module (DAMON sysfs interface) and special-purpose modules.  Please refer to
the 'modules' section of the design doc [1] for more details.

> I am continuing to analyze this.  If any
> improvements are found, I'll send you a patch.

Looking forward!

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html


Thanks,
SJ

[...]
