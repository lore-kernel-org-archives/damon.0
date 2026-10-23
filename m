Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714827;
	b=PSc6BdaMRTu6Q0X5t41flSc+MCstpxjNfhwfvZo6HkxnGSVaOzBmJFHGKQzRBhYO9Kx8
	 2p9Sta4JduySn02ESbNXAi71DciSYZBI3YuVPcxC4HmVUutZRdFwDAsHqJTdXijtI7U3A
	 VG4KO7uaXfiragenRqlajT41sE7wHDnzSX5OlSDZB5oLaaB094hAKQLxAxPP1HSxrsSRu
	 /e50kJdTLNfceoeeiQcbDFJ5Tea2gHFtPK2+FsZIytK8VXTYqqG9m693rPZFi8JnUM1x5
	 /HxdXrd3nT5PgNUcltxnFOxunBuStChzNOmTXHiNdDbz+MB9QmkFvXK0CjVU9miSLhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2Mka4FJTWospogWieZvcESfWOWskKq6CXHFagjEX/04=;
	b=QKMQTbi26UZtsp7LLSA9HGACYmGF1sXOrWPX38Q3UWjx5mSNJbOillDOWwEayprsf69l
	 vZn1VkECsZ3nRAHPz+t7e/j8NYAVU1tRYqP+a0AaltWki5OS5VmRO8/gGzFfwEa5r4Q1S
	 Kw4zaOtOOTNipabsOCXStAR9YCsWK3Gp2Y4Twj7vf5gGltf3/rVQaEzBIbk3pLh630weE
	 tBkU2FQI7PHsbdLzglDiIVnGDqdTk3WcPN+JrC3ksNFiHQgVwHZuF8/yaF87qb5Df+cA7
	 XT6k2ohVOvD36duVCtMh5zqXA3w/mMsPU+x9gBjvue6NDgE92ooWja7Sb+EEsimG3BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAv6N4Jl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2536606A319;
	Fri, 23 Oct 2026 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAv6N4Jl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6521F01825;
	Fri, 23 Oct 2026 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792714826;
	bh=2Mka4FJTWospogWieZvcESfWOWskKq6CXHFagjEX/04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bAv6N4Jls47eUd+FtgHxBHbbtejWHerLskLx7/lOaw2DPB3dm4hyKaLLHl/ILiOMB
	 k8sUkkbwQyxWOaKalKneL2hPpcsx5nW6TqUjebP4TdaJ07z5iO3UIWbHFgc/byVPOb
	 CpqhudB+SWrvc4ryM0nDgcBTO1eVypQJ0Q6zakeSbI9OY4dzW7hCnhehys7PQlBnoV
	 99lBqYevUHVghak2+8QZQsQ9s+KIU2sKPPsjVucJzBdKG4o14vfZGnmej9MhALx8al
	 tNRWi/eZNv4efnx83cCGasmpO2eixfnQv03QfFlDJVOeCD8cpt7ExUxZtO/LEhq811
	 vFmbLKMOe78oQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm/damon: align MMU notifier range when clearing PMD young bit
Date: Thu, 22 Oct 2026 17:20:17 -0700
Message-ID: <20261023002018.102560-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To:  <179267916870.2.5637290691657871645.damon-pmd-align-draft@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Aveline,


'hkml patch check' [1] says you forgot Cc-ing below people who are recommended
by get_maintainer.pl.  I Cc-ed them.  Please Cc all recipients who
get_maitnainer.pl is recommending, from the next time.  'hkml patch format' [2]
could also help you doing so.

- Fernand Sieber <sieberf@amazon.com>
- Leonard Foerster <foersleo@amazon.de>
- SeongJae Park <sjpark@amazon.de>
- Shakeel Butt <shakeel.butt@linux.dev>

On Thu, 22 Oct 2026 22:26:08 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> damon_pmdp_mkold() clears the young bit of a PMD but notifies
> [addr, addr + HPAGE_PMD_SIZE), where addr can be an unaligned sampling
> address. This can miss part of the sampled huge page and age secondary
> mappings in the next one.
> 
> Align addr to HPAGE_PMD_MASK so both operations cover the same huge page.

Looks good to me.  Thank you for fixing.

> 
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")

This is an improvement of monitoring accuracy that DAMON provide only best
effort.  So not Cc-ing stable@ makes sense to me.

> Link: https://lore.kernel.org/r/20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org/

The is a link to Shubhang's pte_mkold() patch.  When you add Link: to your
patch, please add a context on the commit message, from the next time.

I assume you added this link because you mentioned you will send this patch on
the thread, with your nice review of the patch.  However, I think this patch
explains its context very well, and therefore this link is not needed.

> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

I applied this patch to damon/next [3] tree after dropping the Link: tag.  We
are now in the middle of the merge window.  It may be better to give mm.git
maintainer (Andrew Morton) time to work on pull request, rather than adding
more changes that are not really urgent.  I understand this series is not
really urgent.  Hence, Andrew might not add this patch until next -rc1 release.
In the case, I will request adding this to mm.git after next -rc1 release.  Let
me know if you think this is really urgent or the Link: tag should be kept.  If
not, no action from your side is needed for now.

> ---
> Tested both aligned and unaligned addresses on 2 MiB THPs in an x86-64 KVM
> guest with a recording MMU notifier; all ranges matched the sampled PMD.

Thank you for doing the test and sharing the results.  Were you also able to
confirm the expected wrong behavior (missing part of the sampled huge page and
age secondary mapping), too?

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#checking-patches
[2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches
[3] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
