Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196493;
	b=YNLE4vsr0Dk72InRk/LoeQaJfIAyjPCPlrW7/FoTzNvkXYCvGJruZlHFwzsQON3ydwrn
	 COkNZDQ4LVXT0++bgVsC/tV8rAXTtm3KPJlxys+mgOVhcbvYkQgYHwPioxmWvgP7iDx73
	 losgo9Iu/YO+aKH/wTSRml9xu2SSNIWPzaRjfWj5Jr74WQilnV9XHnRIP9W0Wer2idI0E
	 5R5mRLgpp4I0lH3dBzHJXItNs/xD7lsBE0csJVK5KBe+8vYpIPfOvmXQjqEm0w5IWwvaz
	 T+LERgqyBiLQEQ6lAGTdOlrNoRxHElF/QZu1ozAEw6bH5YZtrgzAAFUjCGHdP0F6ORg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qRZx+uCzjDXnaggv9NA2GtraDXmEHwAiGFLHgafIj5E=;
	b=RAZiXWjNYrQCtBwt8p7xYJZ9EkZSWnTyVlOjcW2dV5zjTH/0ELd8R1uHnsEkNmmbqblF
	 +jPVAPNcJ7jPqPHiQFoHsAB4a4Uw8q4exAnNGWActI1S59fnGyFh7xwqIaXxBocB/w+0e
	 giQVVkpxAhDdsVtbKsv4Hy7sDoRHBcg2fSIUR9eGn6PDPc+7u2V+3uR6ekqH9MHaujZbK
	 0UxYcxpvlzAGOCr+hM0y1HeU/n3FgjEhB6aRrGDNioects89wDYUmdeN6lFNT5a+HAkc2
	 9OlccVhfapp9O7g+9S2O8nowh+ThHCyxoODKVhamwjSOGI0jiQOy0YF90tLXZngVMFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjrDrAWL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FC606A31A;
	Wed, 28 Oct 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjrDrAWL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E72C1F01825;
	Wed, 28 Oct 2026 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196492;
	bh=qRZx+uCzjDXnaggv9NA2GtraDXmEHwAiGFLHgafIj5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjrDrAWLTDPsAUrZN+XPbqZ7cfing5M98T3onac6DKid6Qut5cw1320CJkeX4nD0u
	 Ukbu5Ugwyx1bjDn0dOwA1Ev/LBOIW4TE6G48P/ZRhfHcx47w9Wg8NhhyQdAtClTw1/
	 dXiquSva30A28GxPycrfHJoY9YBvSHy4ObLysaizJdTgYa5VRICt83OZF9bIxisNkU
	 LH2lkfoFucpK6GUtB+0kkk+JB0T/e9v04zuEgNt9JxcDAfPQrFxQkpads/0BNR3fQx
	 K5HcZ+O0PfwyAkuRuGn3VgoaRWCZK1cqd0h3/Dq9zDyvaCYYchTRFqcUxdFr/EkL3I
	 2ysaDSNlGZltw==
From: SJ Park <sj@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/reclaim: document how to disable watermarks
Date: Wed, 28 Oct 2026 07:08:03 -0700
Message-ID: <20261028140805.159912-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b0fb80cc-4a0d-4612-beef-bf2fc398f06e@huawei.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 14:09:39 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> 
> 
> 在 2026/10/28 13:35, SJ Park 写道:
> > On Tue, 27 Oct 2026 22:24:24 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> >> Hello Jinjie,
> >>
> >> On Wed, 28 Oct 2026 10:36:28 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>
> >>> DAMON_RECLAIM runs its scheme only while the free memory rate is
> >>> between `wmarks_low` and `wmarks_mid`.
> >>>
> >>> But some users want to reclaim cold pages even while the system has
> >>> plenty of free memory, and it is not obvious that the existing
> >>> watermarks parameters can already do that. So Document the setup.
> >>
> >> Thank you for this patch!
> >>
> >>>
> >>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: SJ Park <sj@kernel.org>

> >>> ---
> >>>  Documentation/admin-guide/mm/damon/reclaim.rst | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> >>> index ec7e3e32b4ac..23fede7d1cdb 100644
> >>> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> >>> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> >>> @@ -193,6 +193,13 @@ DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
> >>>  watermarks.  In the case, the system falls back to the LRU-list based page
> >>>  granularity reclamation logic.
> >>>  
> >>> +To keep DAMON_RECLAIM always active regardless of the free memory rate, set
> >>> +``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
> >>> +``0``, respectively.  Then the reclamation is limited only by ``min_age`` and
> >>> +the quotas.  This is useful for reclaiming cold pages even while the system
> >>> +has plenty of free memory, e.g., right after an idle virtual machine is
> >>> +paused.
> >>> +
> >>
> >> I feel like above might be too detailed.  Particularly, the second sentence
> >> looks too detailed.  In a sense, it is not technically correct because of
> >> 'skip_anon' parameter.  We might later need to add more such controls, and I
> >> concern if this kind of detailed documentation will limit such extensions.
> >>
> >> What about keeping only the first sentence and dropping later two sentences?
> > 
> > If you don't mind, I could add this patch to damon/next after dropping the last
> > two sentences on my own.
> 
> Hi SJ,
> 
> It is fine with me, thanks. Please go ahead.

Thank you for accepting my suggestion.

I applied this patch to damon/next [1] with my suggested change.  I will repost
it for mm.git merge next week.  So, no action from your side is needed for now.
If it seems I also forgot doing that or you cannot wait for my action, please
feel free to ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
