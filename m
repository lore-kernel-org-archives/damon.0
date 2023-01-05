Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A18EB03;
	Thu,  5 Jan 2023 16:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B1C433D2;
	Thu,  5 Jan 2023 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672937665;
	bh=n2kMHDliaAZWCMeqSunat1mUVNB+pE0uEb3Yf7pq5UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueRSNc0HAV9M3m/AOphjY+CVwANJuketclXLKQ7wfqTHXQ20tcNRf8N6PmgoPqizq
	 49G6ZE2C9QbaVTz/ZqxxGBI+wRh4Z9MVPGo4gw56dkEALok/7RWrRYca3R3pjZWZBV
	 HNKI8Yvzr9wfiIfX2KN5xIHyslq9uvfG7zqTX9lCeo9+VE2Zvt9vHllCOVIATkpV2I
	 Bi9tnwyg6ygv9rntn6HbDB1pbzuxRxZFC3I6fyKJezZa1SitXvJC/unlyMGdaXa6Ba
	 OyV4TVir3bQNyv/oayJN3rCQ9x9CoyUfXMiuIQ1ElElyqM6quNL7RNKTvnlj1TxwYY
	 QvTZBoPLcRYEg==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	devel@driverdev.osuosl.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	oe-lkp@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	stable <stable@kernel.org>
Subject: Re: [driver-core:debugfs_lookup_fix] [mm/damon/dbgfs] ff25f87cfc: kernel_BUG_at_lib/list_debug.c
Date: Thu,  5 Jan 2023 16:54:23 +0000
Message-Id: <20230105165423.3221-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y7aeNRf3TyTufC8L@kroah.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 5 Jan 2023 10:53:57 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 04, 2023 at 06:35:39PM +0000, SeongJae Park wrote:
> > Hello,
> > 
> > On Tue, 3 Jan 2023 21:16:09 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> > 
> > > [-- Attachment #1: Type: text/plain, Size: 7528 bytes --]
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed kernel_BUG_at_lib/list_debug.c due to commit (built with gcc-11):
> > 
> > Thank you for the report!
> > 
> > > 
> > > commit: ff25f87cfcfc34ebe652987f2a7beb184762785b ("mm/damon/dbgfs: fix memory leak when using debugfs_lookup()")
> > > https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git debugfs_lookup_fix
> > 
> > The commit is for fixing a memory leak due to missed dput() call.  The patch
> > has posted originally by Greg and revised my I[1].  The revised version has
> > merged in mainline during v6.0 stabilization period (1552fd3ef7db).
> > 
> > The problematic tree (driver-core/debugfs_lookup_fix) is based on v6.2-rc2, so
> > the revised patch is already applied.  But the first version of the patch is
> > applied again on the tree[2], probably by mistake, and caused double 'dput()'.
> > 
> > So I think the commit seems needs to be reverted.
> > 
> > If there is anything I missed or wrong, please let me know.
> > 
> > [1] https://lore.kernel.org/damon/20220902191149.112434-1-sj@kernel.org/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=debugfs_lookup_fix&id=5167d3e8149e332204274910da1057e8f907d7d2
> 
> Yeah, this is my fault, sorry.  That branch/tree has not been looked at
> carefully in a while, I need to refresh it properly and verify it all is
> correct.  I'll drop this change as part of that work as well, sorry for
> the noise.

No problem, I'm glad to help! :)


Thanks,
SJ

> 
> greg k-h
> 
