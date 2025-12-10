Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD879F2;
	Wed, 10 Dec 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379375; cv=none; b=m//RWvZoUSDhhWeeGNJ6EJvrQ+Qg9xsctn5rC8iFwVZGiBcccUsg50RX8g7O3BAjeHr4MggWGuQOwEnvJmRa1ydUUk5FukRcWD6F5Y2iDAc5DKbUxlBMQycDjGwJ5kkEzshR6OHz5ox7icf9GFE/qRbmMRRNvfYiY8Fi0j6cpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379375; c=relaxed/simple;
	bh=RNmnMRCESvvHPFXhuXOJd3zbdNDnT+Lv6azVvJPG2UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHJHJ1piWjLtqG7h5bLB4v8P12f0L0W3f5aVb2dVbEIREjERFxa6Wvh9nOUFWb3fcQBeKCYVTmZ34yvsLKqy25CjssiKfBDtuJX+c1aBn3elLpz6BX1Wf51Z4f2/jLTf8GKCB9ys7h9VbwB57/Zhwu4kiH5MRWx1XZKhjvKRSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzY+YMpn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzY+YMpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B604C4CEF1;
	Wed, 10 Dec 2025 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765379374;
	bh=RNmnMRCESvvHPFXhuXOJd3zbdNDnT+Lv6azVvJPG2UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzY+YMpnkL8T8+6BMETspq6d93c5ln9SEAyW+/EtA/UfdcxDc7MhLz8KhjGcSMb/A
	 ITPaTW92f0vl1ze5oJ28cNk++oEn62ZQU1wCXI2efEUgzwkUVB4q9bJ+TWSok5h6De
	 e8y19U+jU2WogiOYUQvAKa5W6L/+GvB781OKQqPdGJ8jI7MAnjpXLQ9tU7RcabHNl1
	 hVoWcOKjcBx90H1OxPaWR1jT/RXbCAK/o6DJTkGFZHS/vpojXUsemeqHEIK8M+ItvI
	 wHi5lQiJwcNz+H4pdyU4vsYFRMDM+V8WjOnlfbetvCH3BeXIzSSv+hbQgsKMrrFK5O
	 H/aeQRzK234uQ==
From: SeongJae Park <sj@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list),
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] mm/damon/sysfs: check for online node in target_nid_store
Date: Wed, 10 Dec 2025 07:09:30 -0800
Message-ID: <20251210150930.57679-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210111708.46959-1-swarajgaikwad1925@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Swaraj,

On Wed, 10 Dec 2025 11:17:07 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> The 'target_nid_store' function previously accepted any integer value
> written to the 'target_nid' sysfs file without validation. This allowed
> users to set invalid Node IDs (e.g., -1 or 9999).

Nice catch!  Actually this was even able to trigger kernel BUG, as commit
7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
explains.  And the commit fixed the issue by avoiding only the kernel BUG,
while still allowing the invalid input.  The intention was to make the
interface as simple as possible unless it causes real issues.  It is for both
maiking the maintenance easy and allowing flexible usages of the interface.  It
is a king of consistent deisgn philosophy of the DAMON sysfs interface.  For
this particular case, the current behavior allows flexible usages regardless of
possible hot [un]plug of NUMA nodes.  IOW, I'd argue this is not a bug but an
intended behavior.

Maybe the commit message should have more clearly explained the intention.  As
the author of the commit, I apology for not making the intention clear.

> 
> This patch adds a check using 'node_online(nid)' to ensure the input
> is a valid, online node. If the node is invalid, it returns
> -EINVAL.

I'm sadly have to say that I'm not very convinced with this change because it
makes a behavioral change.  Making behavioral changes is ok as long as the
changes are obvious improvements.  I don't feel this change is an obvious
improvement for following reasons.  After all, it is making the interface bit
more complicated, in terms of its maintenance.  Seond, and more importantly, it
makes it less flexible in case of possible hot [un]plugging of NUMA nodes.
Suppose the user knows they will hot-plug a NUMA node and wants to set the
target NUMA node before doing the hotplug.

> This change also resolves the TODO comment "error handling
> for target_nid range".

Thank you for mentioning this!  Seems the comment was intended to be addressed
before the code be upstreamed, and I missed it, sorry.  That's also why I'm
saying thank you :)  I think we should just remove the comment.

So, I'd suggest you to send a new version of this patch for such comment
removal only.  Of course, further documentation improvements woudl be nice,
though I wouldn't insist you should do that as a part of the next version of
this patch.  What do you think?

Please let me know if I'm missing something.


Thank,
SJ

[...]
