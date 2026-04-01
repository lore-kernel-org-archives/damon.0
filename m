Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91D7E0FF
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003361; cv=none; b=ZP05z+p3L9FICSQWknwD1pqF97NQnUotVsAidD9LCqrIvNP05ZHQQ1ybeMekIC55UHy+ClLVJqkI5arQ6VMISbcBmVEX/UF6oLFtIIuNEFoy/dCqjgbM9N2yoH9BqKfNcMF65rpbG2yJCwSOf/UZCi7YNYkWJnuEOH3VmYyHNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003361; c=relaxed/simple;
	bh=Dbl7wQksRMs1lnHVTfv9r7xVfjWsvbXiAANR/E27KAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiHhskgppGHoAZAI4Q1P+UboQYOScutCIiVgpD6YIDChc+AynJbf0Zeiqi3D+cJup1zrpQRkJmqsuokFI93nXBgsZq7kqNZTUQBhXG3t89fvZCF5o03Y2N5YOEezN8INmzWgg713bAlUvjJCKaQdiHio+tH7aBZI2zqrcgVnMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSmrxFj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSmrxFj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611B3C2BCB0;
	Wed,  1 Apr 2026 00:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775003360;
	bh=Dbl7wQksRMs1lnHVTfv9r7xVfjWsvbXiAANR/E27KAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSmrxFj9kje8cZZfDG0mnGqN3+wIHb96ci0loXYGpHsrvIX2V4G7QelnKNhCGPl3V
	 YpgWLzZpBvB7QPChTQlcAwxJowrfOnOnGBJDVZKHo1fidprWF8qlB5KwLs+gEPOx82
	 6++IgTG+TNrIuUJeFp66Ou3AEimYktZoOImI6rR1cgoEpWhuV5CLt7vqUrkMuKaU9E
	 ixF5AdhT8C35BE6pldk9Sg3N5YV/npWDJe+62X066yqQPjg3H3UmLKtFaEq2o/wGfN
	 NTB3+L4UBykx9cJ64M9ruIzHdZxBvA9s3AlrUrfhp6qQOmc2VWz++qqEhtxHJ4cRWI
	 3o7f+XiHU3pVQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 17:29:18 -0700
Message-ID: <20260401002918.85255-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331065836.4364-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 14:58:36 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Mon, 30 Mar 2026 22:02:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Nice catch!
> > 
> > I guess this can easily reproducible?  Sharing detailed reproduction steps
> > would be nice.
> 
> I will include the reproduction steps in the next version.

Please completely answer questions.  You didn't answer the first question.

> 
> > > Solution
> > > ========
> > > Introduce a 'thread_status' structure to link the internal kdamond
> > > state with module parameters ('enabled' and 'kdamond_pid').
> > > 
> > > Specifically:
> > > 1. Extend 'struct damon_ctx' to include pointers to the module's
> > >    parameters.
> > > 2. Initialize these pointers in damon_lru_sort_apply_parameters()
> > >    and damon_reclaim_apply_parameters() to point the respective
> > >    module variables.
> > > 3. Implement damon_update_thread_status() to reset 'enabled' to
> > >    false and 'kdamond_pid' to -1 when the kdamond thread finishes.
> > 
> > This feels too much extension of core API for a problem that can more simply be
> > fixed.  Can't we detect the unexpected termination of kdamond from the modules
> > and update the paramter values accordingly?
> > 
> > If we cannot due to a limitation of the DAMON core API, I'd like to extend the
> > API for letting the caller detects the unexpected termination.
> > 
> > Because this is an RFC and I already have question for the high level
> > direction, I will skip code level review.
> > I agree that the current approach was too heavy as it forced the DAMON
> > Core to directly manipulate module-specific parameters, leading to tight
> > coupling between layers.

Please do not add '> ' to your reply.  This confuses me.  Also, again, please
completely answer questions.  You didn't answer if we can or cannot detect the
unexpected termination.

I will reply to below in another reply, as you added a few things to that part,
while cutting the above part.  When you reply to your reply, please consider
keeping the previous reply part.  Then I can reply to your two mails at one
place.  That would help my life :)


Thanks,
SJ

[...]
