Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965520B7F4;
	Wed,  6 Aug 2025 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516561; cv=none; b=bxlIgOMcZbVv9tKBjA2vKsR423JseecAXoDjLMX8td4/dQ13Gku4FcaMDooovHjzh7QsrKH+JSAdgyyrCIFPi1VoS/sCpBFKKyzyzM4DXXcoB3WmaQZfLtAYP9K6zjQuyG9yVU9kXJJFmxrKMkazwBBGcEjL58JSQ757lqKI3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516561; c=relaxed/simple;
	bh=IP16fbf+G7a/uqZxnRnGz9p5iDyRqDGWV+tCxJaT6wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8t0S3/GlfISMFPj9lnDVhZdiQNZHlVslVH+oIWLcamgZ9q5yNLvLH6hID4LauH093js5SCtaSHTH7bPODTdLfcOzJ0Zghvb4SB5O5no/sTP2EGGz7cYBGIdOwpiFjVX8tagqiUdmF29UE6LwPTzsXrxEiCIab8xTkxa2CsqqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoZBgTYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoZBgTYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6E9C4CEE7;
	Wed,  6 Aug 2025 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754516560;
	bh=IP16fbf+G7a/uqZxnRnGz9p5iDyRqDGWV+tCxJaT6wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoZBgTYLM6S0Wb3uTTK/zr1aZiRs8bMg4/aU2jXIiSNqOVtcvYlphmsB980gRLlKb
	 0dOIDeqTC5dF1SJULftMQYAC33Rc4+0KcPKvKu9P6N+3IInpvK2tB5WWK7eht0FU/j
	 8qye/pqfqzyh/Dgb9uAmVqrpWK68lUQ2M3fEUpBTlAwQsZ1vAH3Oj0lCBZzjBMOOnO
	 0XiwATuqShtv5PzcxWFMx3ZpJLbUYKEmpKT9a70esnRdbCouu46kSrOpGBLao1xMVU
	 /C52wzKoBdtarOgFPIEXtg23YhK/GbI9wOalubYH2qUdZUFPJEwhCYNjmdyo5KfVet
	 dahrD9AGky5kA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/core: skip needless update of next_{aggregation,ops_update}_sis
Date: Wed,  6 Aug 2025 14:42:37 -0700
Message-Id: <20250806214237.51484-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS7Anh4qZu-VewZ61_QqfU9PDCaUpGjxZWeCdioTWkr5vA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Aug 2025 14:49:21 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Wed, Aug 6, 2025 at 2:09 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Bijan,
> >
> > On Wed,  6 Aug 2025 11:43:16 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > From: Bijan Tabatabai <bijantabatab@micron.com>
> > >
> > > In damon_set_attrs(), ctx->next_{aggregation,ops_update}_sis would be
> > > reset, even if the sample interval, aggregation interval, or ops update
> > > interval were not changed. If damon_set_attrs() is called relatively
> > > frequently, such as by frequent "commit" operations, aggregation and ops
> > > update operations could be needlessly delayed.
> > >
> > > This patch avoids this by only updating next_{aggregation,ops_update}_sis
> > > if the relevant intervals were changed.
[...]
> > What about modifying damon_commit_ctx() to check if new and old
> > damon_ctx->attrs are entirely same, and skip calling damon_set_attrs() in the
> > case?  Doing the entire damon_attrs comparison might be suboptimum, but would
> > make the change simpler.  I assume the suboptimum comparison is not a real
> > problem for your use case, so I think that could be a good tradeoff?
> 
> I can definitely do this. Checking a few extra fields is no big deal.
> 
> Silly question, but think it's best to get it out of the way before
> sending another patch: do you think there's a more elegant way of just
> having a dumb comparison function like
> 
> bool damon_attrs_equal(struct damon_attrs *a, struct damon_attrs *b)
> {
>         return a->sample_interval == b->sample_interval &&
>             a->aggr_interval == b->aggr_interval &&
>             ...
> }
> 
> And I assume I shouldn't compare the aggr_samples field because it's
> private, is that right?

Ah, you're right, thank you for asking this!

Maybe we can copy src->attrs to a local damon_attrs variable, overwrite
aggr_samples of the copy and dst, and memcmp() the copy and dst?

I wouldn't mind the dumb comparison function, though, if you prefer.  I'll
defer the decision to you!


Thanks,
SJ

[...]
