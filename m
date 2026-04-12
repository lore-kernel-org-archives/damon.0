Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B528504F
	for <damon@lists.linux.dev>; Sun, 12 Apr 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020693; cv=none; b=jjDlnrt9T8Jj8qd+0zqxkFtc/cmmyLwzwUpiHQ0Z92IJgzOkMmjtM2ZqZaKUZQ75+m3GchCbQwYLacfJlbPHmU0vtD+NZGJyhWHidm+ljqhihn8n60Ru9gspjzjMM1ZSnByZiXMKgXoqeySDz7VQUIT8hvEwgkDlVkhizULovz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020693; c=relaxed/simple;
	bh=nZH2iK8e8ZPuHCez+zJ67JSDmPIDpL2Z+MnvOnc0RLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMtP7p9W0X73O1aoOVI/nLf+TznnKLUofndjNpdJjuEtEQwTjoEgQlA5970nDUCjUiJEozcIYtgmfG7qQz5xhRheccPITzaGNsVe3rTX92d9s8B8SRPhqj6aygyev50r5MoHgOnfdPZHmnIiqZn6wLT2iV4njg2T7giDVStsCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHTdJ6fq; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHTdJ6fq"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso1492794a12.2
        for <damon@lists.linux.dev>; Sun, 12 Apr 2026 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776020691; x=1776625491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xxA5sfGEOPcW6uW3CKulYm8b89rPouT75E/m8n6d44=;
        b=XHTdJ6fqspxmrhtal9LVj6KqfMf0/oLh5zHKrCU/XPTWk2nPVRylf3NXBdBWRZaQd0
         aNia4fB9VQ86WbSBNHc4YK9007lQGWrEUnC55Ywyqs7jLyv+fYI9fjO+rmnJjNr896J4
         QZDXLesWeap/u1zjKOvBvTvtR0MCaKyRaIqeZBxG/OUYsetNk7ETMQQRB6t3jTJ1FQzE
         Dpuy1VOMnRXGEhR1vsDLN3nLPMKDufy6XZTMoVaP2EZVKL1kvkBv6BAZnPZoXVooRi6S
         Dqg3Ogyej3m4NtU6UVJBYHYdkt8lOn4GLDcWmGCxreNgNTzyjs4HkS41hkV+5DIkVyOh
         T+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776020691; x=1776625491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xxA5sfGEOPcW6uW3CKulYm8b89rPouT75E/m8n6d44=;
        b=qnJU2NKvEth9YSsDlAFI5hpQ8gFo+iFZvE7KRZcJ51ce6rtCMVe7FwiZtVHj3grY3f
         692w+lBpx5BBIncawjBd4t6OA15bzG1QGlSM/W9oDJYVkUlauhxgzuHkUWzbEZcNsDpb
         xyCwnhLwSJG0ms+rzi5v6slPaxOIJLQkxyfBoev2kRd+3r6z6EUud0LtHdM1AYt91pat
         XBGV7eeC3HhtOeRw54q6vHYcoyyLPbFm9FJOMnB8MJsKAntBFHApB9nXO0CDfP0WPETC
         GFQzrvZx3uYMzEzrrGpoyahDQntG35UUBJmo8R/FgaflogcvfKbvl9ZwyiHEbaZjuK7/
         CYfA==
X-Forwarded-Encrypted: i=1; AFNElJ8aAgmPWamtFAHRyVlHQCulrlxu5jWqAi2dvj2M7wuD8SjA+AHNgl/jq0RKHRK18g+W81JWqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX+ifm/SPw4rvkRMz2TFS/bP6Ixzgbm5h7aTkdfvplAC9CgDFt
	GgC7tDT3fBin48TWr2erJj2iwcFUT9EpOu7gVeMnnMcSCZtYpp8LZJ2G
X-Gm-Gg: AeBDiet2aVLGIDNJZQ8ukJpoqUVaY9vOjWVFxAezpUTeVBwuEALArukS4L1jPmXgmXy
	MWBE8hDWbCz9OI+TbG+15H67BdlLpZ2waUA11YNN4Wci7g2qfo/Jb5Xz7KZHVJBZ39L8RuDqHW4
	FYrf1KorGMY45RIP5ZuOBHX8NsQN9yEHlHx+dpFzZLA+f77nKJ5ftka2RWCTAI9XQWgjoVSnM1o
	wsKkc3dr/7sQ7NFdLyvjwXIqEVEXO+Ka3j+X0A6u7lkEvLbn+neec2PBgOqOQYu/iMmOLsfWug+
	befZrDgflAGDPhW2GvWBKhi8DIpGUtlvX7glpilXixqQhQHXdXgALJhgcaaxZL8LntF7TLCsSnC
	zRXp7y/GKbNLo4Cw5TO8IvbirqPeol0SZwobv6eZQKnU636JsAEj7WNVd+DjYp2LGdyGU99h7+7
	I7uiRElW8ipgHjfpNloQKGkJPhim4=
X-Received: by 2002:a17:90b:2fce:b0:35e:599f:aef0 with SMTP id 98e67ed59e1d1-35e599fb177mr3237144a91.11.1776020690790;
        Sun, 12 Apr 2026 12:04:50 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm9924144a91.3.2026.04.12.12.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:04:50 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Mon, 13 Apr 2026 03:04:55 +0800
Message-ID: <20260412190455.6685-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411153821.95491-1-sj@kernel.org>
References: <20260411153821.95491-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

Thank you for your detailed explanation and for being patient with me. I
sincerely apologize for the confusion and the extra workload my unclear
communication has caused you. It was never my intention to hide context
or game the system; I simply misjudged the priorities and failed to
provide the full picture.

I want to continue contributing to DAMON. I truly enjoy working on it,
and I'm grateful for the opportunity.

On Sat, 11 Apr 2026 08:38:21 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> Thank you for sharing these.  But seems even this context is incomplete from my
> perspective...
> 
> The Real Context
> ----------------
> 
> The real start of the context is probably the question [1] that you asked on
> 2026-03-18.  At that time, we found committing wrong parameters stops DAMON
> without an user-visible error.  We agreed DAMON being killed is no problem but
> the absence of user-visible error is a minor user experience problem that
> better to be improved.  So you planned to make the user experience improvement.

You're right - that question was the real starting point. Back then, I
hadn't yet realized that an unexpectedly terminated kdamond cannot be
restarted. After that discussion, I started working on synchronous
commit patch [1].

> 
> Apparently series A is the followup of that.  The first version was posted on
> 2026-03-26, according to the changelog of this patch series.  I can show I was
> saying the patch was confusing on the thread.

Series A came from a Sashiko review [2] that appeared while I was
working on that synchronous commit patch. It [3] was a new, separate
issue.

> 
> While the review of the confusing series A was ongoing, you posted [3] the RFC
> of series B on 2026-03-31.  This patch reported one important finding: the
> silent DAMON stop is not just a minor user experience issue but a serious bug
> because it cannot be started again.

I discovered the "kdamond cannot restart" problem by accident while
testing other things. That's why I treated it as a separate issue from
Series A, not as something directly related.

> 
> And this made things much more confusing. There are multiple ways to trigger
> the issue.  Wrong addr_unit commit is just one of the ways.  We discussed the
> way to fix the real issue.  So, by looking back this, I think you should
> prioritized series B from the point, or make suer series A is only for the
> minor user experience improvement.  Or asked me what to prioritize.  You didn't
> and I missed the fact that you are also working on series A.

Here's what happened in my head, and I'm sorry I didn't say it loud at
the time:
After you advised me to slow down [4], I thought you preferred me to focus
on one series at a time. Since Series A looked closer to merge, I
decided to finish it first, then move to Series B. I should have asked
you what to prioritize instead of assuming. That was my mistake.

> 
> But you just continued posting new versions of series A.  I was wrongly
> thinking that is still the minor user experience improvement.  I still think
> the patches were implicitly saying so.  I'm not sure if it was intentional or
> not.  But definitely it was confusing me.  On 2026-04-02, I started feeling I'm
> missing some of the contexts, and asked you more clarification of user impacts
> [4] and full history [5].  You posted v3 [6] right after I asked the question,
> even without answering the question.  Only from this point it became clear
> sereis A is not just a minor user experience improvement but a critical bug
> fix.  Now I think you should clarify this can also fix one trigger point of the
> critical bug but the real fix is work in progress, and this is till only a
> minor user experience improvement.  But because you didn't, and my poor memory
> is volatile, at this point I was thinking this all the work you are doing for
> the series B-exposed bug.

Regarding your "[4][5]":
When you asked about Cc:stable@, I got excited and focused on figuring
out the Fixes tag and stable rules. When you asked if I had other
patches, I thought you meant the older "addr_unit power-of-2 validation"
patch [3] from before Series A. I didn't realize you were asking about
all my in-progress work. I'm sorry for the confusion.

> 
> In the response to the sashiko review on this thread, therefore, I was thinking
> you are thinking the wrong addr_unit commit is the only way to trigger the bug.
> I didn't want to ask you to work from the beginning to fix the entire bug, so I
> was saying fixing the real bug for all exploit points is out of the scope of
> this bug.
> 
> But now it is turned out that you were aware of the other ways to trigger the
> bug, and didn't transparentl and explicitly exposing that.

To be honest, I only knew about the 'addr_unit' trigger. I was vaguely
aware that memory allocation failures could also cause termination, but
I never reproduced them or investigated further. I should have told you
this earlier.

> 
> So I withdraw what I told on the reply to the sashiko review.  And appreciate
> sashiko developers again for giving us a chance to finding this.
> 
> Next Steps
> ----------
> 
> So, what to do?  Please prioritize series B, if you still willing to do.  It is
> ok to keep doing series A, but only as the minor user experience improvement.
> Clearly explain the whole context you are aware of.  Don't Cc stable@ for
> series A, as it is only an incomplete fix of it.  The fix of the one trigger
> point is just a side effect.

Yes, I absolutely want to continue contributing to DAMON.

I realize most of this confusion came from me misinterpreting your words
or making assumptions without asking. So this time, I want to be
explicit:
1. I will remove the Cc stable@
2. Since you suggested prioritizing Series B, would you prefer me to
   send a revised v5 of Series A now, or should I wait until Series B is
   settled to avoid more noise in your inbox?
3. I will focus on Series B starting now.

> 
> And For Future Contributions
> ----------------------------
> 
> Liew, I really appreciate your contributions.  You found and shared important
> DAMON bugs.  But apparently your communication has many rooms to improve, at
> least for poort DAMON maintainer who have to work with only limited resources
> including the poort and volatile memory.  I find I was asking clarifications to
> your mails multiple times.  I have to say it was even frustrating sometimes and
> definitely took quite amount of my resource.  Meanwhile, from my uncautiously
> biased perspective, you were only adding more traffic and confusions.

I'm very sorry for the trouble I caused. Moving forward, I will ask
before assuming, and I will make sure my intentions are clear.

> 
> This makes me disappointed and even suspect your intention...  I really hate
> myself suspecting someone.  But we are in the world of bad actors that now
> gained the power of AI.  We actually had a suspicious case from DAMON
> contributors recently, do you remember?

Yes, I remember the Josh Law case. I am not a bot. I have no intention
of gaming contributions or harming DAMON. I just want to do real work.

> 
> I want to still believe you, so I will do so.  Please feel free to keep
> contributing to DAMON as long as that's what you want to do.  But, please aware
> of the fact that DAMON maintainer has poor volatile memory and working with
> limited resource, and try to make every conversation super clear and
> transparent, from next time.

Thank you for your honesty, and for still trusting me. I will continue
contributing to DAMON. I will work hard to make my emails clear and
transparent, and I will ask questions whenever something is ambiguous,
so we can stay aligned.

> 
> [1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> [2] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com
> [3] https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com
> [4] https://lore.kernel.org/20260402140314.74600-1-sj@kernel.org
> [5] https://lore.kernel.org/20260402152915.75294-1-sj@kernel.org
> [6] https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com

[1] https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com
[2] https://lore.kernel.org/20260325025317.86571-1-sj@kernel.org
[3] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com
[4] https://lore.kernel.org/20260403161906.65008-1-sj@kernel.org

Best regards,
Rui Yan
