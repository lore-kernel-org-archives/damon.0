Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5D224AF7;
	Sat, 13 Dec 2025 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765587403; cv=none; b=B8GjRo3YvGQVxkZT8wMWwyK0NtzSJIgCbmrIljTzasIM+TXYBjlltY9RjEV+oNlobzNtKT0e16M1eOwVYlkhh1qjH4b3aWBVEHgELEorWAP2Jt+Y4NsES74j69riDwFbR5GnSBxW1sM6191TtGRCMeixNDZTwV0v44YbKLfiJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765587403; c=relaxed/simple;
	bh=m+SdupAtr2vqe29kp74wQamP33BdMF7o5VgQEmyNoQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sirblgOqWaovSWJons8OQvk6FGWIoBQhTE/6UiKZc8j1AYogRVqEz4e8Fq5pNkm0+9GgRGFDJ9qd5tfxnQuMbQOGvo/4r+xp5fhSDOHUNZe2tYYtoQ7re/aBOrQZScetKgfyMj8lhcwTX3iKCenGhJwhfE+VkKbnfq19I2Fb7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzKI6gX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzKI6gX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3863C4CEF1;
	Sat, 13 Dec 2025 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765587402;
	bh=m+SdupAtr2vqe29kp74wQamP33BdMF7o5VgQEmyNoQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzKI6gX3rirffakNPg3du7BE+ljNl4bhyweBMmbgqY2zexkqxLpGa06jC34QcKhSY
	 dfGY+Apq1w5/rFbId9pQY9l9W40Qnocj1/64UPGev7ymTauVz3rzyKAgZwyFNayZ4S
	 U8dXDBnlYGw805vjA9kiCI4faU5dpktZ2Ip50GPi73f0gzrOcHV16pdYbggKR559lD
	 sQQbH3f1szvBEZ62D614PkCnCj0jE5mx2gFa89HJchUDRUdy0wSytWi4ngtAY4GZZ7
	 e7YLjcQaA7z7mJmQWeew/6k0LE3z/im33QQq/iE5ebdWpEWkNE9jAgKEYXFB5APDMx
	 vDQdMIr2aBYNA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 04/37] mm/damon/core: implement damon_report_page_fault()
Date: Fri, 12 Dec 2025 16:56:37 -0800
Message-ID: <20251213005639.50513-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4jUGpyezSNMChyOCio-vTA=kK3CYS3O1CzEXxEiMjPyg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 13 Dec 2025 09:31:22 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Sat, 13 Dec 2025 at 07:47, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 12 Dec 2025 21:46:03 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Mon, 8 Dec 2025 at 15:33, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Implement a DAMON core API for reporting page fault events to DAMON.  It
> > > > is a wrapper of damon_report_access().
> > > >
> > > > This is a temporal hack.  In future versions that will have no RFC tag,
> > > > only damon_report_access() may be used.
> > >
> > > It's a minor, but git am throws an error when applying the [RFC PATCH v3 04/37]
> > > patch file.
> >
> > Interesting.  I can do 'git am' this patch without error on mm-new branch.  Are
> > you using something other than mm-new as your baseline?
> >
> > > I am testing it by modifying it as follows.
> > > damon_report_access() is
> > > called by damon_report_page_fault(), so they depend on each other.
> > >
> > > #ifdef CONFIG_MMU
> > > void damon_report_access(struct damon_access_report *report);
> > > void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
> > > #else
> > > static inline void damon_report_access(struct damon_access_report *report)
> > > {
> > > }
> > > static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
> > > {
> > > }
> > > #endif
> >
> > Seems this is not for fixing a 'git am' error but build error...?  Can you
> > share what error exactly you are seeing?
> 
> You have been deploying RFC PATCH v1, v2, and v3 starting from 2025-06-29.
> I am currently working with the latest version v6.18.1 (as of 2025-12-13).
> 
> $ head Makefile
> # SPDX-License-Identifier: GPL-2.0
> VERSION = 6
> PATCHLEVEL = 18
> SUBLEVEL = 1
> EXTRAVERSION =
> NAME = Baby Opossum Posse
> 
> When applying RFC PATCH v1, v2, v3 with the above version, errors occur
> in several places in 'git am' as follows.
> 
> -------- [RFC PATCH v1] -------------------------------------------------
> 
> $ git am '[RFC PATCH 1/6]'
> Applying: mm/damon/core: introduce damon_report_access()
> 
> $ git am '[RFC PATCH 2/6]'
> Applying: mm/damon/core: add eliglble_report() ops callback
> 
> $ git am '[RFC PATCH 3/6]'
> Applying: mm/damon/core: check received access reports
> 
> $ git am '[RFC PATCH 4/6]'
> Applying: mm/damon/vaddr: impleement eligible_report() callback
> error: patch failed: mm/damon/vaddr.c:610
> error: mm/damon/vaddr.c: patch does not apply
> Patch failed at 0001 mm/damon/vaddr: impleement eligible_report() callback
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
[...]

Thank you for sharing these!  We are working on moving baseline, specifically
mm-new in most cases.  And we keep under-development patches on damon/next
tree.  Please refer to the document [1] for more details.

And a later version of the patch series is for replacing the old version.  If
you have no special reason to apply the old versions of the patches, I'd
suggest to use only the latest version.  And if you have no special reasons to
use only 6.18.1, I'd recommend to just play with the commits on damon/next
tree that was used to generate the patch files.

Nonetheless, if you have a strong reason to do work on only 6.18.1, please feel
free to ask help if needed.

> If I build the kernel with the above status, I get compilation errors
> as follows.
> 
> /home/arm64/projects/kernel/linux-stable/mm/damon/sysfs.c:758:25:
> error: ‘DAMON_FILTER_TYPE_WRITE’ undeclared here (not in a function);
> did you mean ‘DAMOS_FILTER_TYPE_TARGET’?
>   758 |                 .type = DAMON_FILTER_TYPE_WRITE,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~
>       |                         DAMOS_FILTER_TYPE_TARGET
[...]

Makes sense.  Again, I'd recommend using mm-new as your baseline or play with
the commits on damon/next, but if you need help, please feel free to reach out
:)

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
[2] 

Thanks,
SJ

[...]
