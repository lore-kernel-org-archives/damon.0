Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0B3403E4;
	Fri, 10 Jul 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692999; cv=none; b=km86ysj88mNlgRmqj+np6twMKkZeM5TKTjKhtWsSFlfOqxuFqM3yZL/Eucg1MePih39Awy45Qxr7r3Pul7+12Dn8vE8xNhHrNriYskymH6gIVivCaSVr09OkggRDZcqQ+gWqvF/K2TZljUr19PAWaDlkqUQTdMddlVO4qxgCM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692999; c=relaxed/simple;
	bh=ZdMIB1Jlm15iHZeVbTSHD+qNSv1SzX1FTEraIbk3b98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG4+YVYcbH/M7W9hLwMcVAwPTWNrVVhf9n9lFdymvSAmIXo1/vaYTjOVLIxh/TQ1PPYavuj6MNi/+7c8lY9Wp5BwO4KPMiGDDCKiRmB1mj5KtX/r6R0Pp2vzagYHHf/5qTAZqzAXivTRniuAk3pZGKcHOkvmK3Lk4FpO0pb8WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KahqDGrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KahqDGrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A81F00A3A;
	Fri, 10 Jul 2026 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692998;
	bh=QaIclYB8bbvFhsCZS8P52iBbwbOGPeVuy63rBC+62Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KahqDGrVB23ELbwXbfrA0bkp0js04Cm/Sd3I7TGV92lsdkdd7qyEbPwROUSAJSohT
	 NrueGXCoe7BiMBfiWG863Nt3bEJVBDn+o1o1baPQvxomFbSf9YoCp7N+OUBb2HxXK5
	 8dGhBMdmTWJAcsGjQK/7J/XN+8DJqg3e8Uot9jW9QZYxV+cntA9WGWqYgD416KLFSo
	 XSqHrta9v1gh1aCHEc5i/aHtnC//JoPtvqbfrI4bVlD1+X0MCOFR0axUKCHh8y73HL
	 u061aLt5n0t9FxLsZye2mR40+u8n4kgE7x50T/kNEP4WgdCzwielOjqAVRIbXi4Pj5
	 jd9IXI/6kzibQ==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] Docs/ABI/damon: sysfs ABI document fixes and additions
Date: Fri, 10 Jul 2026 07:16:30 -0700
Message-ID: <20260710141631.24657-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710044737.561102-1-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'hkml patch check' [1] says you forgot Cc-ing below people who are recommended
by get_maintainer.pl.  I Cc-ed them.  Please Cc all recipients who
get_maitnainer.pl is recommending, from the next time.  'hkml patch format' [2]
could also help you doing so.

- Andrew Morton <akpm@linux-foundation.org>
- David Hildenbrand <david@kernel.org>
- Lorenzo Stoakes <ljs@kernel.org>
- "Liam R. Howlett" <liam@infradead.org>
- Vlastimil Babka <vbabka@kernel.org>
- Mike Rapoport <rppt@kernel.org>
- Suren Baghdasaryan <surenb@google.com>
- Michal Hocko <mhocko@suse.com>

On Fri, 10 Jul 2026 12:47:33 +0800 Song Hu <husong@kylinos.cn> wrote:

> This series fixes typos and fills in missing entries in the DAMON
> sysfs ABI document (Documentation/ABI/testing/sysfs-kernel-mm-damon).
> 
> Patch 1 fixes a path typo, "intrvals_goal" -> "intervals_goal", in
> four What: entries; the documented path points to a non-existent
> directory, so it is Cc'ed to stable.
> 
> Patch 2 fixes two further typos ("WDate:", "manimum").
> 
> Patches 3 and 4 add ABI entries that exist in the kernel and are
> already described in usage.rst but are missing from the canonical ABI
> document: the 'update_tuned_intervals' state command (patch 3) and the
> 'tried_regions/<R>/probes/<P>/hits' file (patch 4).

Looks good overall.  Patch 3 looks unnecessary, though.  Let me add comments to
each patch.

> 
> Song Hu (4):
>   Docs/ABI/damon: fix typo in intervals_goal sysfs path
>   Docs/ABI/damon: fix typos
>   Docs/ABI/damon: document update_tuned_intervals state command
>   Docs/ABI/damon: document tried_regions probe hits
> 
>  .../ABI/testing/sysfs-kernel-mm-damon         | 29 ++++++++++++++-----
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> -- 
> 2.43.0

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#checking-patches
[2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches


Thanks,
SJ
