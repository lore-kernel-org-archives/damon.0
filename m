Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D051DF25F
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765277396; cv=none; b=Mk+W/bEOEDhlD+A2mNgQIx2qiA+/8n5WXBO16qMVJ9lzmbZ7wJPwct05GLpsdtUEO3i4Stx5eYbCZ/l0tv+mcFkqmhw38+7HDs3KGKtgLXpiYvWq/+SOymt9pgAvfGZbxzNogCxSslkHlN5WvrCZ3ihlNWADd7RYCWfrVTnxoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765277396; c=relaxed/simple;
	bh=5JSL8kPkVv0kostgrjkUlhoSwShzRt+ceXPrqvQIUSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih8sgCpavVATFB04M9rSNhSMDlBdSf3pn8ugNC8ekU2j4eddo+pIgzNPiuKDVm++razXqag0wZnxVaEVZh5lkKTFufGwgq4fFU/u7QN+wWDsGkQ15gqsEXIp7WDoPgpSbizF7snKZYuP+abDJ+holjC50D2y4drmcyukZbNLpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPvrCAz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPvrCAz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE21EC4CEF5;
	Tue,  9 Dec 2025 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765277396;
	bh=5JSL8kPkVv0kostgrjkUlhoSwShzRt+ceXPrqvQIUSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPvrCAz5ius3PvIltupEswBs5UZtH/0nmef6nzsW8CajXvksXVrEhJvlrEPpg8vRp
	 i69Bz2BfpcWbo3WqgEBxwJ14pxRB/lZ5SWkB1T0XQrlI4payRRTajELbnWLKLzdMcA
	 hc/5EexM4bzYCtmDnIT+cvNIMXxBt0WulCl1wd4KOqkwMPgsY46YnkCCBsnBvjvH1d
	 xe+yVzrXIpj63tHcI7yfwLiIzc6i9dru3PDaeyaTNk2UItPTkG9b1FRrriNCJU6WBP
	 Pyp6PcJlrtiflb1dv6hyDnuAicKlERHtgk5GnRVnUdaaPdHK3Dsw6/pKaUL5DdpwDX
	 dCv73HAtlgK3A==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: delete damon_target when detected invalid
Date: Tue,  9 Dec 2025 02:49:51 -0800
Message-ID: <20251209104952.43233-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87v7igm2hq.fsf@>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Dec 2025 17:24:49 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SJ,
> 
> On Mon, Dec 08 2025 at 11:21:45 PM -0800, SeongJae Park wrote:
> 
> > On Tue,  9 Dec 2025 13:57:13 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> >> Currently, DAMON does not proactively clean up invalid monitoring
> >> targets during its runtime.  When some monitored targets exit, DAMON
> >> still makes the following unnecessary function calls,
> >> 
> >>   --damon_for_each_target--
> >>   --damon_for_each_region--
> >>       damon_do_apply_schemes
> >>         damos_apply_scheme
> >>           damon_va_apply_scheme
> >>             damos_madvise
> >>               damon_get_mm
> >> 
> >> and it is only in the damon_get_mm() that it may finally discover that
> >> the monitoring target no longer exists.
[...]
> > So, from the beginning part of the patch description, I understand your concern
> > is the unnecessary function calls in kdamond_apply_schemes().  What about
> > checking the target validness using ctx->ops.target_valid() and avoid going
> > deeper if it is invalid?  Seems the damon_for_each_target() loop is a good
> > point to do this.
> >
> > What do you think?
> 
> Excellent suggestion!  Moving the validity check to the
> damon_for_each_target() loop via ctx->ops.target_valid() would indeed
> prevent all unnecessary function calls, which is more efficient and
> architecturally cleaner than my original approach. :)
> 
> I will implement this change shortly.
> 
> By the way, I'll add a "Suggested-by" tag to the commit message, if
> that's okay with you.

Surely that's okay and my honor :)


Thanks,
SJ

[...]
