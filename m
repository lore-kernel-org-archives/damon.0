Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58E1A9F93;
	Tue, 17 Mar 2026 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707535; cv=none; b=qmEXoBfIucVIaQjHA4IgBYOBUWCpqUw5JNjmjJvuXbXQNWpnC8VbRMu6ccsra5cx4hq5BLfVWkVDci2p7hwbeHGsI82HwgGap2b9HIc2sQUeRL+if3zGkr77micd6XLhaMx3wfcxqx2IJsiA2CAEL2BIY/W8VpVf+KDX8dWVefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707535; c=relaxed/simple;
	bh=SxztNyjsBWFQa6rSjGITiRSfE6ka6QEjlqxvt3CSyEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmpZkuTHDMAS3eS3dFqWrqjqixBGTL34/EeDVZhnQL2TTen8JJcueh3eWAtZLAxzT83l4RjA8pU2gLJ2A9qhCTUi6FuGEhFgJ/A4a/a2dBt4L6XBUwQbc+3pvLJLxAr9SPhth0/9ZT5iLyon8qfpcPf+xl0yxpAb6YrXoOArEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzhKXsyn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzhKXsyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CFAC19421;
	Tue, 17 Mar 2026 00:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773707535;
	bh=SxztNyjsBWFQa6rSjGITiRSfE6ka6QEjlqxvt3CSyEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzhKXsyn1mncyjXxEA3xKr3mJtet7x5eO/3Q1n1ufQQ5KMSCpzjlIe++T4iQ9+lN0
	 lT2c8CUJq/5Ip4nkn64NRQBoCRe6CNs9+4epjtSt+VCtOQYPEQ03XmlvQY9rVIhpjU
	 5+FDmvPkcQWbLijhEfOx6JmmAxx84SWlML1MzNNnTKaXaIsCkqwHyKHxrupQ4Dkl/r
	 jYS2GrVsAsS8W8Mu7CLG1M8YP4VqRhNaHiuupLC9hSHsAv44m4UbZ+gO1RnJZRAv6p
	 nzyqRKBqpgWuf1gZKWlvYPoOEA01VJ1+XGsjqAhK3vnBWrVBukfE0b5g3cSp0+mQ5d
	 xcENaeB0rhncQ==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
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
Date: Mon, 16 Mar 2026 17:32:05 -0700
Message-ID: <20260317003206.89342-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316183805.2090297-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Mon, 16 Mar 2026 18:38:05 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch set introces a new action: DAMOS_COLLAPSE.
> 
> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> working, since it relies on hugepage_madvise to add a new slot. This
> slot should be picked up by khugepaged and eventually collapse (or
> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> enabled, khugepaged will not be working, and therefore no collapse
> will happen.
> 
> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
> the address range synchronously.
> 
> This new action may be required to support autotuning with hugepage as
> a goal.

Above all makes sense.  Thank you for posting this patch.

Do you have some test results that you can also share together?  It would be
nice if it can demonstrate the benefit of DAMOS_COLLAPSE over DAMOS_HUGEPAGE.

> 
> [1] https://lore.kernel.org/lkml/20260314165156.86647-1-sj@kernel.org/

Seems the above link is just added by a mistake?  If not, please clarify.

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/design.rst | 4 ++++
>  include/linux/damon.h             | 1 +
>  mm/damon/sysfs-schemes.c          | 4 ++++
>  mm/damon/vaddr.c                  | 3 +++
>  4 files changed, 12 insertions(+)
[...]
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3a441fbca170..6720dc70c487 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -140,6 +140,7 @@ enum damos_action {
>  	DAMOS_PAGEOUT,
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
> +	DAMOS_COLLAPSE,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,

sashiko.dev adds [1] below comments.  Let me also add my comments in line.

: This isn't a bug, but should a kernel-doc entry for @DAMOS_COLLAPSE be added
: to the comment block above this enum?

Makes sense.  'make htmldocs' may complain otherwise.  Asier, could you please
add the kernel-doc comment for DAMOS_COLLAPSE in the next spin?

: 
: Also, does inserting DAMOS_COLLAPSE here shift the integer values of the
: subsequent enum entries like DAMOS_STAT?
: 
: The DAMON sysfs selftest script (tools/testing/selftests/damon/sysfs.py) uses
: a hardcoded dictionary action_val to map string names to their integer enum
: values.
: 
: If the enum values shift, the test's assertion:
: 
: assert_true(dump['action'] == action_val[scheme.action])
: 
: might fail when checking the struct memory via drgn. Could the python test
: dictionary be updated to reflect the new values, or could the new action be
: added at the end of the enum list?

There is no test that uses DAMOS actions that defined after DAMOS_NOHUGEPAGE,
so no real test will break.  But this is a good point.  It would be better to
update the hard-coded value together.  Asier, could you also update the
'action_val' dict of assert_scheme_committed() function in
tools/testing/selftets/damon/sysfs.py for the updated enum value in the next
version?

[1] https://sashiko.dev/#/patchset/20260316183805.2090297-1-gutierrez.asier@huawei-partners.com


Thanks,
SJ

[...]
