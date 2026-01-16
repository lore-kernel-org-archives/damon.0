Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B430C631;
	Fri, 16 Jan 2026 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533523; cv=none; b=bZgvieJOXIkyKTWiu34msXsEdqBZpNUwz5Ssz4bmZUEFsCxB+ioLq1dL41LInpev880SrhwPmeoL0AAqpi8aZLqtp+OyZl1WXnm5scv0vOmMo34HLBkhJzzbSUdnnlOkvVfkJ/uKI2OXbC17Ezqk3kmT69CZnNKYd2m2SBAD6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533523; c=relaxed/simple;
	bh=KEsxUSnwjGF4pQxArZWJG8UMArvuz7FnxwUyaaReGms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEthRKkxb8eDg0fO0Dky+vJpFp7Ge5PHMBODMV8CycZY41bX23AQlmZcteaSHdyNmikXdjU8A+AgHaM6SUYzzNsWM088mq9koA3O1tppXFZ+TRFTru+5ezM/zLdjasoNOelTao3Ua5fdSERSlWETTXqL+wENX40v4FbPjrpadyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYWr05Vq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYWr05Vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B01CC116D0;
	Fri, 16 Jan 2026 03:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768533523;
	bh=KEsxUSnwjGF4pQxArZWJG8UMArvuz7FnxwUyaaReGms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYWr05VqUGfZCU4UNdsPkbnCkKzql6AFkxRBrIge9Nay2wl9ZhP93gID2fwWkLoxu
	 QC2yQTBVAinsMGdpwouXACSdaPKDDyTyo/HSYnjDe+3LRhj6w7mm8pkdnNEEmSwZLt
	 c9bhJgetOIuabcEBRDd5gSpuYpFrgAbY/FvPCO773e4i+Z3MFnyoryEBUR5tZX3Vn5
	 Ng8Eo0NnZDYMcxKbnMx19DM1lHhie/UtN152LcesqeQ5KVRFwF2NxdKFw881V+n9q5
	 V2wzVRiE3vcehY5Wpvs4uQmgJ40wcuBPriuKAymjVGbg4ld1QvA6ymlDXqmwPXG2xT
	 sTHXmU2/WEIMQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rgbi3307@nate.com
Subject: Re: [PATCH 1/2] mm/damon/core: modified and tunning damon_split_regions_of()
Date: Thu, 15 Jan 2026 19:18:25 -0800
Message-ID: <20260116031826.72372-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4kktZ5rvPmJKpeHkOznbmLAxB1GfowU7NgLc1EUA3-hQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 05:18:51 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 15 Jan 2026 at 00:46, SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello JaeJoon, thank you for continued interest in DAMON.
> >
> > On Tue, 13 Jan 2026 21:16:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > Before modification:
> > >                                                              sz_region
> > >     |--------|--------|--------||--------|--------|--------|--------|
> > > nr_subs:     1        2        3        4        5                  9
> > > split random:    <----------- (*] randmon        LOST -------------->
> > >
> > > When dividing sz_region at rand, the random value may be small, such as
> > > 1 or 2.  At this time, there is a problem that only the front areas
> > > corresponding to 1 and 2 are divided, and the remaining back area
> > > becomes too wide.  If the area is too wide, there will be many missed
> > > address access judgments.
> > >
> > > After modification:
> > >                                                              sz_region
> > >     |--------|--------|--------|--------|--------|--------|--------||
> > > nr_subs:     1        2        3        4        5                  9
> > > split from   <------------ (sz_region / nr_subs) ------------------>
> > >
> > > It is recommended to divide sz_region evenly in the ratio (sz_region /
> > > nr_subs) rather than using rand.  In this way, if you decide nr_subs well,
> > > you can logically match the number of divisions and their sizes.
> >
> > I was thinking about how to reply to this patch.  Since it is taking unusually
> > long time, let me add short comments for direct future of this patch.
> 
> After much thought, you ask a simple question below.
> 
> >
> > The existing code uses random() for a reason.  This change might break it.  Can
> > you further explain what was the point of the use of random(), and why this
> > change is not breaking it?
> 
> To find a needle in a haystack, is it right to keep poking around randomly?
> 
> >
> > >
> > > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> >
> > Unless you can give me a convincing answer to my above question,
> >
> > Nacked-by: SeongJae Park <sj@kernel.org>
> >
> > Same for your followup patch [1].  Btw, please send patches of same series as
> > one thread from next time.
> 
> I sent you two after much deliberation so that you can see them clearly.

Unfortunately what I asked are still not clearly answered to me.  And based on
our past conversations including the recent one that I acknowledged as a
communication failure [1] and this thread, I expect asking you more questions
will not work for me.  I don't think that's someone's fault, but obviously
that's the current situation.  I will not ask you more questions for the
reason, unless I get a reason to change my mind.

So, to make it crystal clear, for this patch and the one you posted together,

Nacked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[1] https://lore.kernel.org/20260101224420.73826-1-sj@kernel.org

[...]
