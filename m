Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF4DDA9;
	Wed, 18 Mar 2026 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795148; cv=none; b=o774yOa9zr/mZ64k2AUt8Ji3ijsKypZSuur293RJd9PzOPRwo0T46qqsBdUs7ldIGBORlelA5rTqTVx3nWyWTSkpWVuzHMwP33Wz7HoWdL+LGgcyNt5S2Bzt9sUXHh51LnpsQEuGUIGFbbG77m/uwQJYmRqjcb48bgQGU0klPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795148; c=relaxed/simple;
	bh=EwAMtwt5gp44/cRaugvoB1jqQt36RleL4zmzMKF101c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB+GbehqriVx7OH73UOkvTaz0rvlX/K0BWrCLG4oBqP1ZUs02gjfTUxFfJWK7doVYJATmFfsjhiTaINLq298E/npGMkO8uBB/v1/43Juv287oFn6DTzANnSVaHMT28UM3uY7qQ/383LBrzRRLbjnBtWOV54t0CLEZuezkGSA1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAKqgwQC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAKqgwQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF577C4CEF7;
	Wed, 18 Mar 2026 00:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773795148;
	bh=EwAMtwt5gp44/cRaugvoB1jqQt36RleL4zmzMKF101c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAKqgwQCiql7vHn4tad5fLGdaN1AsZupyTJyl98S3O7o54/BKNCj+bQeYwiKWfcc/
	 gW32378aRxo0QxLNONKEbBLyceRXu9nyZqULTpo0AMeHkjwXVSZTD4+iZqU1o7Kx4N
	 NIONmUVo492qxWnaSwZOtGN2K7m4xFbmXjwPsJB5ltxvPkh6/UtLQfM7ruZoLOPgXJ
	 q10+Qd0pgPSMhJGsCk7UZAKlUJlz/hw89MTYH0whJ6hhZJz1p+lXSn1juA3/B78kBh
	 QS8q9QZLp6DPgweubphSZQEXgIt5yCi2pKmyltQDaVn1hunFlbeDGNjxeOoEd1kQlm
	 JG7g7O4q9Ovzg==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Tue, 17 Mar 2026 17:52:25 -0700
Message-ID: <20260318005226.132181-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <247cd41f-e703-4480-9de3-a8708bb3d9ee@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Mar 2026 09:52:09 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> First of all, I just noticed that this was sent as v2 RFC, while
> it should be v1. Bear in mind that the next series will also be
> v2.

No worry :)

> 
> On 3/17/2026 3:32 AM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > On Mon, 16 Mar 2026 18:38:05 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> This patch set introces a new action: DAMOS_COLLAPSE.
> >>
> >> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> >> working, since it relies on hugepage_madvise to add a new slot. This
> >> slot should be picked up by khugepaged and eventually collapse (or
> >> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> >> enabled, khugepaged will not be working, and therefore no collapse
> >> will happen.
> >>
> >> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
> >> the address range synchronously.
> >>
> >> This new action may be required to support autotuning with hugepage as
> >> a goal.
> > 
> > Above all makes sense.  Thank you for posting this patch.
> > 
> > Do you have some test results that you can also share together?  It would be
> > nice if it can demonstrate the benefit of DAMOS_COLLAPSE over DAMOS_HUGEPAGE.
> I will run some tests and benchmarks.

Looking forward to.

> > 
> >>
> >> [1] https://lore.kernel.org/lkml/20260314165156.86647-1-sj@kernel.org/
> > 
> > Seems the above link is just added by a mistake?  If not, please clarify.
> Yes, it looks like I copied the wrong link.
> >>
> >> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >> Reviewed-by: SeongJae Park <sj@kernel.org>
> >> ---
> >>  Documentation/mm/damon/design.rst | 4 ++++
> >>  include/linux/damon.h             | 1 +
> >>  mm/damon/sysfs-schemes.c          | 4 ++++
> >>  mm/damon/vaddr.c                  | 3 +++
> >>  4 files changed, 12 insertions(+)
> > [...]
> >> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >> index 3a441fbca170..6720dc70c487 100644
> >> --- a/include/linux/damon.h
> >> +++ b/include/linux/damon.h
> >> @@ -140,6 +140,7 @@ enum damos_action {
> >>  	DAMOS_PAGEOUT,
> >>  	DAMOS_HUGEPAGE,
> >>  	DAMOS_NOHUGEPAGE,
> >> +	DAMOS_COLLAPSE,
> >>  	DAMOS_LRU_PRIO,
> >>  	DAMOS_LRU_DEPRIO,
> >>  	DAMOS_MIGRATE_HOT,
> > 
> > sashiko.dev adds [1] below comments.  Let me also add my comments in line.
> > 
> > : This isn't a bug, but should a kernel-doc entry for @DAMOS_COLLAPSE be added
> > : to the comment block above this enum?
> > 
> > Makes sense.  'make htmldocs' may complain otherwise.  Asier, could you please
> > add the kernel-doc comment for DAMOS_COLLAPSE in the next spin?
> OK, I will split this patch into 2: one with the code and the other one with
> the documentation.

Does the 'documentation' mean the change for 'design.rst'?  Or, the kernel-doc
comment?  If that's the former case (separating 'design.rst' side change as
another patch), that's completely good for me.

If that's the latter case (separating kernel-doc comment addition as another
patch), that will make the commit trigger document build error, and the error
will be fixed only after the followup commit is applied.  Please ensure keeping
'damon.h' side changes as a single patch, and therefore no warning or breaks in
the middle of the patch series is introduced (and later fixed).

> > : 
> > : Also, does inserting DAMOS_COLLAPSE here shift the integer values of the
> > : subsequent enum entries like DAMOS_STAT?
> > : 
> > : The DAMON sysfs selftest script (tools/testing/selftests/damon/sysfs.py) uses
> > : a hardcoded dictionary action_val to map string names to their integer enum
> > : values.
> > : 
> > : If the enum values shift, the test's assertion:
> > : 
> > : assert_true(dump['action'] == action_val[scheme.action])
> > : 
> > : might fail when checking the struct memory via drgn. Could the python test
> > : dictionary be updated to reflect the new values, or could the new action be
> > : added at the end of the enum list?
> > 
> > There is no test that uses DAMOS actions that defined after DAMOS_NOHUGEPAGE,
> > so no real test will break.  But this is a good point.  It would be better to
> > update the hard-coded value together.  Asier, could you also update the
> > 'action_val' dict of assert_scheme_committed() function in
> > tools/testing/selftets/damon/sysfs.py for the updated enum value in the next
> > version?
> OK, I will do it.

Thank you :)

> > 
> > [1] https://sashiko.dev/#/patchset/20260316183805.2090297-1-gutierrez.asier@huawei-partners.com
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> Thanks for the feedback.

My pleasure.


Thanks,
SJ

[...]
