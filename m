Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E53FEC;
	Wed,  4 Jan 2023 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA33C433F0;
	Wed,  4 Jan 2023 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672857345;
	bh=GHoH25BDojkBu8zk+In6e6fb+FOzetOV9W36hZoxaC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvsvtpHt0gDjsnijtLvAuSIUYHj8CxhsusxzYQ5zbTGgLLUvS65MT5K7aknJ4OZjK
	 FQdoQBkVjqrfGt/j4wJuNLE1u19IdyPXtdO9cwIiv7qURj9kBiHT/3bkUDIgVflH2t
	 Hfpx7MFzFL0kO7Zf3jUnkVj7yCXjKKpNsXTN4WecmFfDBS6O6qnAMtZpGSAyNl3hh5
	 24ktlzd3m8AhYnFNj1mpZOyIJxMtOo5ifLsYSrIHLqnQJYNI1fPso+aejLeaKX9XUr
	 QXTi/t9SzRJsv/m0m8rgMbe7EkWPKmhGUjarzvxAKXkBcxCqEFUnkZduw/bMh0y0ZF
	 ddSMtbhpzff/A==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <oliver.sang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-lkp@lists.linux.dev,
	lkp@intel.com,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable <stable@kernel.org>,
	devel@driverdev.osuosl.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [driver-core:debugfs_lookup_fix] [mm/damon/dbgfs]  ff25f87cfc: kernel_BUG_at_lib/list_debug.c
Date: Wed,  4 Jan 2023 18:35:39 +0000
Message-Id: <20230104183539.1509-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202301031611.c49a0c74-oliver.sang@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 3 Jan 2023 21:16:09 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 7528 bytes --]
> 
> 
> Greeting,
> 
> FYI, we noticed kernel_BUG_at_lib/list_debug.c due to commit (built with gcc-11):

Thank you for the report!

> 
> commit: ff25f87cfcfc34ebe652987f2a7beb184762785b ("mm/damon/dbgfs: fix memory leak when using debugfs_lookup()")
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git debugfs_lookup_fix

The commit is for fixing a memory leak due to missed dput() call.  The patch
has posted originally by Greg and revised my I[1].  The revised version has
merged in mainline during v6.0 stabilization period (1552fd3ef7db).

The problematic tree (driver-core/debugfs_lookup_fix) is based on v6.2-rc2, so
the revised patch is already applied.  But the first version of the patch is
applied again on the tree[2], probably by mistake, and caused double 'dput()'.

So I think the commit seems needs to be reverted.

If there is anything I missed or wrong, please let me know.

[1] https://lore.kernel.org/damon/20220902191149.112434-1-sj@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=debugfs_lookup_fix&id=5167d3e8149e332204274910da1057e8f907d7d2


Thanks,
SJ
