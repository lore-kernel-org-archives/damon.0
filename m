Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE811185
	for <damon@lists.linux.dev>; Tue, 18 Jul 2023 16:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0562C433C8;
	Tue, 18 Jul 2023 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689697175;
	bh=o6/z++iAsfxtC4ue21DXnPDGcjMDSp5m+OtMQDwMI+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMAFV3ptIcg8KmlYOr5yFD5yYC0pYLFymRyLCv81KtSWLVQ5kqJLQH9IRQ0DJ41Fl
	 9z2pxXwKnxXwaKcR4xYaxowByK6fkzYTAJyXavdvJEXRyQ0/mB/RG/yPMtw5GSToyQ
	 fDd+3eKOmJHLkL/YqTFRSsf1/FGf5OxMspPNw4nTJYILEDqKLWOf7SR4oKSBHC3YzI
	 f309AscsqKYbSBp5H8sXwEhKE2Or8RvZ14jGGMC3euDZZyXTx9fY2s6HYby6Dn6T6n
	 aMhTGCP25yFGuIqKkUlEu9Cb0nFzgV4OvvM9S+9XCz44yiHq8x1Z/XueyBQfSKQnrS
	 KpNg0fVUSwWYw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core-test: Initialise context before test in damon_test_set_attrs()
Date: Tue, 18 Jul 2023 16:19:33 +0000
Message-Id: <20230718161933.78949-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718161656.78877-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, please note that it would be very helpful if you could Cc
damon@lists.linux.dev for all DAMON-related patches from the next time.  I'm
cc-ing the list.


Thanks,
SJ

On Tue, 18 Jul 2023 16:16:56 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Feng Tang,
> 
> On Tue, 18 Jul 2023 13:28:11 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > Running kunit test for 6.5-rc1 hits one bug:
> > 
> >         ok 10 damon_test_update_monitoring_result
> >     general protection fault, probably for non-canonical address 0x1bffa5c419cfb81: 0000 [#1] PREEMPT SMP NOPTI
> >     CPU: 1 PID: 110 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc2 #15
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >     RIP: 0010:damon_set_attrs+0xb9/0x120
> >     Code: f8 00 00 00 4c 8d 58 e0 48 39 c3 74 ba 41 ba 59 17 b7 d1 49 8b 43 10 4d
> >     8d 4b 10 48 8d 70 e0 49 39 c1 74 50 49 8b 40 08 31 d2 <69> 4e 18 10 27 00 00
> >     49 f7 30 31 d2 48 89 c5 89 c8 f7 f5 31 d2 89
> >     RSP: 0000:ffffc900005bfd40 EFLAGS: 00010246
> >     RAX: ffffffff81159fc0 RBX: ffffc900005bfeb8 RCX: 0000000000000000
> >     RDX: 0000000000000000 RSI: 01bffa5c419cfb69 RDI: ffffc900005bfd70
> >     RBP: ffffc90000013c10 R08: ffffc900005bfdc0 R09: ffffffff81ff10ed
> >     R10: 00000000d1b71759 R11: ffffffff81ff10dd R12: ffffc90000013a78
> >     R13: ffff88810eb78180 R14: ffffffff818297c0 R15: ffffc90000013c28
> >     FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000000000000000 CR3: 0000000002a1c001 CR4: 0000000000370ee0
> >     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >     Call Trace:
> >      <TASK>
> >      damon_test_set_attrs+0x63/0x1f0
> >      kunit_generic_run_threadfn_adapter+0x17/0x30
> >      kthread+0xfd/0x130
> 
> Great.  But it would be even greater if you could this kind of output after
> decoding the addreses using 'scripts/decode_stacktrace.sh` or
> 'scripts/faddr2line' from next time if possible.
> 
> > 
> > The problem seems to be related with the damon_ctx was used without
> > being initialized. Fix it by adding the initialization.
> 
> Somehow the test always passed on my test machine, but maybe that's due to some
> different behavior of my compiler.  I agree that could be the root cause
> because 'damon_set_attrs()' calls 'damon_update_monitoring_results()', which
> accesses the context's fields including the targets list.  Since the list is
> not initialized in this test code, it would cause such error.
> 
> > 
> > Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
