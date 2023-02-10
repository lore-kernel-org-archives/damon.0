Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CA7E2
	for <damon@lists.linux.dev>; Fri, 10 Feb 2023 04:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D543C433D2;
	Fri, 10 Feb 2023 04:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676003070;
	bh=Q5Xp2O+5KYdWZ+voh/i9lBg3FJpd9FO9qvnfklGAX88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trmk8kLhEhUXQaQJXTL8scTpoBaC4E65qqOaiVT7Oh96Ecgs4hDO+KDGboNRIpbeG
	 e4IE+Ju/2kmhEAUy5nhFXp19hrRLjap73WBXCmG03itDOnUM4nj6jBukAH3C0IBPZW
	 WphWtnopyfqEQKCMGLOWneKZH4PSZFGgwAYJtNrZO6kfPisKAyun2MPexJXdr6Mg/e
	 ptVncQjM34byojaOZgqUGIawktuikHLhHrfAYl7P7sAvCfMaYR9l4VJ2FNgO/eC5VP
	 fYs/Pg4LQLb/nZPslkSonJ95eOkgCUEITAYtJ7U1k1jYDctSHN4nxlz+UPZyuH6Jev
	 TefpMnU4VTH9g==
From: SeongJae Park <sj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/damon/dbgfs: print DAMON debugfs interface deprecation message
Date: Fri, 10 Feb 2023 04:24:28 +0000
Message-Id: <20230210042428.55864-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fe4103e4-5a2f-1659-8b4a-23dae807dad5@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Randy,

On Thu, 9 Feb 2023 19:26:43 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 2/9/23 11:20, SeongJae Park wrote:
> > DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
> > kernel is released.  And, v6.1.y has announced to be an LTS[1].
> > 
> > Though the announcement was there for a while, some people might not
> > noticed that so far.  Also, some users could depend on it and have
> > problems at  movng to the alternative (DAMON sysfs interface).
> > 
> > For such cases, warn DAMON debugfs interface deprecation with contacts
> > to ask helps when any DAMON debugfs interface file is opened.
> > 
> > [1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/dbgfs.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> > index b3f454a5c682..e551a20b35e3 100644
> > --- a/mm/damon/dbgfs.c
> > +++ b/mm/damon/dbgfs.c
> > @@ -20,6 +20,11 @@ static int dbgfs_nr_ctxs;
> >  static struct dentry **dbgfs_dirs;
> >  static DEFINE_MUTEX(damon_dbgfs_lock);
> >  
> > +static void damon_dbgfs_warn_deprecation(void)
> > +{
> > +	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).  If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
> > +}
> 
> Line length of 234 is a bit over the limit.
> I think it would be OK to split it at the end of the first sentence, like:
> 
> 	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).\n");
> 	pr_warn_once("If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
> 
> or would that [2 pr_warn_once() calls] not work for some reason?
> 
> Or even:
> 
> 	pr_warn_once(
> "DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).\n");
> 	pr_warn_once(
> "If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
> 
> although some people might gag at that one.

Thank you for your opinion.

I considered that, but I was worrying if some other messages come between those
two separated messages.

What do you think about breaking the string like below?  I first tried to do so
like memcg hierarchy[1], but ended up to this version because of checkpatch.pl
outputs[2].  However, if others doesn't care, I think this is ok.

	pr_warn_once("DAMON debugfs interface is deprecated, "
		     "so users should move DAMON_SYSFS. If you depend on this "
		     "and cannot move, please report your usecase to "
		     "damon@lists.linux.dev and linux-mm@kvack.org.\n");

If breaking user-visible string is not ok, maybe we could make it as short as
your above example.

 	pr_warn_once("DAMON_DBGFS is deprecated; please contact to damon@lists.linux.dev and linux-mm@kvack.org if you depend on it.\n");

May I ask your opinion?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memcontrol.c?h=v6.1#n3643
[2] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings


Thanks,
SJ

> 
> 
> -- 
> ~Randy
