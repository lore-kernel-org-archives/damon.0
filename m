Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01B1FC110;
	Sun,  7 Dec 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765083186; cv=none; b=Gjcm/3ZAjGVSigcZf8bPPG8fzoUbCTzrZ45nnV30LRBcFWE8D2K13IlvnTP363gGp0U++ElDkUrqzOTb6nv3+E33Eq7nrlkmTAeHE+LtNvnFlocH01q6ZinogpLLVX17o2WFKOYfNPbj2sgBzmXT7Swr6eVwO0diBzpk0y75V0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765083186; c=relaxed/simple;
	bh=uD6Uc/3bMvUszXx059Ty5URnVwOwfY870xF8hpY9UA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8fgJaOim0Z96klT+oKhVSgIWsM4ICxG5tMtZ6y5sNVTsXys0BOiKMcZhTWpjRGDCIL7WEH/VVXyXM3Bkk6CCrfZwud6LmsnIlydEf+I7T/KWJwdi9UQrKDD8cK5rzfBAJfpmEWPSlynxjW3mCN8cA2G/QrZ043+0b+yXmy3BoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5ABxrJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5ABxrJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE5DC4CEFB;
	Sun,  7 Dec 2025 04:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765083183;
	bh=uD6Uc/3bMvUszXx059Ty5URnVwOwfY870xF8hpY9UA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5ABxrJK6aeoV2cSXcVd1GjxBrWYc40GGZveh0jSrdS94NP5jhngC3352vlrruZXv
	 PBnRxh7dnynlsNsYnn5aMeZx83m38mK2bx5k/uJQN3zQ84IYufT5b/tda/WeCcJHhY
	 XNhV/UR+Mfi0PQpcbGDA60jDAyJCfUKerPwUeeGllYdCMuPKWc8eoPtb1rDUWo+R+i
	 WHG6KIUwwwwPE/ZR38p0qk/d+EaKSMRTmHwF0YSDYzX6HKqcpz9edz6p9u68VXgrCE
	 GGORiQtB1y97wFWO3C02wfXJfij64kkoeA5RUEelwlUrTVCXjqe2ejIWQ7yKltPcyn
	 CYhkXNSeTHosw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC v2 0/7] mm/damon: extend for page faults reporting based access monitoring
Date: Sat,  6 Dec 2025 20:52:56 -0800
Message-ID: <20251207045257.47035-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 27 Jul 2025 13:18:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR: Extend DAMON interface between core and operation sets for
> operation set driven report-based monitoring such as per-CPU and
> write-only access monitoring.  Further introduce an example physical
> address space monitoring operation set that uses page faults as the
> source of the information.
[...]
> Core Layer Changes for Reporting-based Monitoring
> -------------------------------------------------
> 
> Optimize such possible duplicated efforts, by updating DAMON core layer
> to support real time access reporting.  The updated interface allows
> operations set implementations to report (or, push) their information to
> the core layer, on their preferred schedule.  DAMON core layer will
> handle the reports by managing meta data and updating the final
> monitoring results (DAMON regions) accordingly.
> 
> Also add another operations set callback to determine if a given access
> report is eligible to be used for a given operations set.  For example,
> if the operations set implementation is for monitoring only specific CPU
> or writes, the operations set could ask the core layer to ignore
> reported accesses that were made by other CPUs, or were made for reads.
> 
> paddr_fault: Page Faults-based Physical Address Space Access Monitoring
> -----------------------------------------------------------------------
> 
> Using the core layer changes, implement a new DAMON operation set,
> namely paddr_fault.  It is the same as the page table Accessed bits
> based physical address space monitoring, but uses page faults as the
> source of the access information.
> 
> Specifically, it installs PAGE_NONE protection to access sampling pages
> on damon_operations->prepare_access_checks() callback.  Then, it
> captures the following access to the page in the page fault handling
> context, and directly reports the findings to DAMON, using
> damon_report_access().

I was going in this direction because obviously the protection installing is
obviously what operation set layer should do.  But, damon_report_access()
handling is on the core layer.  For followup extension for
per-CPUs/threads/read/write monitoring, we need to filtr in/out the page fault
information, but that's not only for page fault but general access check
sampling results.  And therefore it makes more sense to be done in core layer.

Also this approach is unnecessarily increasing the number of operation set.  It
is also restricting such advanced monitoring to specific operation set.

So I changed my mind to add a control data structure on the core layer.  It
will let API callers specify what access check primitives (or, sources) should
be used, and what access information should be filtered in/out.


Thanks,
SJ

[...]
