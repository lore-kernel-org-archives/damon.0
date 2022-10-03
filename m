Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F717E9
	for <damon@lists.linux.dev>; Mon,  3 Oct 2022 16:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A76C433D6;
	Mon,  3 Oct 2022 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664815727;
	bh=9JFN+E5oxZqG7ORNDXu24NQo6HsvVcbWgfnQ+6L3bU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3+ANmaVq3Gg+3IOiAi9tYuQtkv+4FesqzoH7/J+AnZFgk845eKe4GvW462pfCnrf
	 BCR7rs2KoiA6oVRH4K24GNqFILrTa3tWWuMYwbsXM23zJcQpyPQ5k2D0lp5LNZ5Ewe
	 jegdNdVmk7n2HSuX8QvMq0I+2TEir0iQDhrRXq8W4dmytUaje0WIfOWBPxoivEHyL+
	 q3oYaDvq67xU/BNVLBTg4LXnHTEUgT7+ig22e0elq1oGLraHIB/c/Ns/IlY6KE6MTv
	 1DufbFp0Dbn38zxgHZM+VAFjYlHnSM04uq3B8flBQdQNg1Fnoa3GlJ2mN3GtsITi1f
	 S9wteIs9jsgFQ==
From: SeongJae Park <sj@kernel.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev
Subject: Re: DAMON KUNIT test failure in latest mm-everything
Date: Mon,  3 Oct 2022 16:48:45 +0000
Message-Id: <20221003164845.52332-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YzqDHs56va/NgHFy@hyeyoo>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 3 Oct 2022 15:37:18 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Sun, Oct 02, 2022 at 07:36:56PM +0000, SeongJae Park wrote:
> > Hi Hyeonggon,
> > 
> > On Sun, 2 Oct 2022 16:24:29 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > 
> > > On Sun, Oct 02, 2022 at 01:24:23PM +0900, Hyeonggon Yoo wrote:
> > > > Hi guys, yesterday I just built and booted latest mm-everything,
> > > > and I got following report from KUNIT test.
> > > > 
> > > > Environment:
> > > > - x86_64, gcc 11.2.0
> > > > - mm-everything (tag: mm-everything-2022-10-01-01-55)
> > > > - config attached
> > > > 
> > > > Report (stacktrace decoded):
> > > 
> > > FYI, below is the bad commit from git bisection ;)
> > > 
> > > Thanks!
> > > 
> > > 065530b966a42d63f214ba40427dc8d00345f573 is the first bad commit
> > > commit 065530b966a42d63f214ba40427dc8d00345f573
> > > Author: SeongJae Park <sj@kernel.org>
> > > Date:   Fri Sep 9 20:28:57 2022 +0000
> > > 
> > > mm/damon/core-test: test damon_set_regions
> > > 
> > > Preceding commit fixes a bug in 'damon_set_regions()', which allows holes
> > > in the new monitoring target ranges.  This commit adds a kunit test case
> > > for the problem to avoid any regression.
> > 
> > Thank you so much for this kind report!  I just sent a patch[1] for this.  It
> > should fix this issue.
> 
> You're welcome! Thank you for quickly fixing this.

No problem, all owing to your grateful report!

> 
> > BTW, please note that the real issue was there even
> > before the kunit commit, but the kunit commit was the first commit that
> > triggers the issue.
> 
> Yeah, makes sense.
> Hmm.. Do you think it would be worth to backport to -stable?

IMHO, this is not stronly required for -stable, as the kunit test is the only
one case that could trigger the issue, to my understanding.  If there is any
code that could trigger the issue in stable, of course it would be need to be
backported.


Thanks,
SJ

> 
> > [1] https://lore.kernel.org/damon/20221002193130.8227-1-sj@kernel.org/
> > 
> -- 
> Thanks,
> Hyeonggon
