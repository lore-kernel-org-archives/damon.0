Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7625BEF8;
	Fri, 17 Oct 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718624; cv=none; b=FSC52ifn4QiubjDec30TFXKk5mRzID6GGrddxjAhZUzy6dkyndVwabFRGEkCILje6Ac6q0y7Iwn1CR4n5PZzx8z3GfN9JmKPjJU1X9wEjDFcxQgbsvPu5s2eoQdPSPsQqUZxrV18oLFRCm28NxnXJcRms/ImNpj0Y+frHIAcMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718624; c=relaxed/simple;
	bh=0A95aUQlDuwkcx0jSODD8EHq026+LKD+s5SAlpUXlEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foAnZ4zRIUaW0IUxLNe5b3+QmKEyNTb1z3ozF31RPMlLZ/vhAHquZ9WgN0lTg9T3u7Cjoy2xP/XOko8M/5bJVzD52JLWNh1BaJ9wFGsNY36OfxyAFc8Rp2c9Fo9v7nA4lhO91ZrCH3T1qCVN/1DPzhW9RUwrNlANDJtAIgdSbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QazJII0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QazJII0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B149C4CEE7;
	Fri, 17 Oct 2025 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718623;
	bh=0A95aUQlDuwkcx0jSODD8EHq026+LKD+s5SAlpUXlEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QazJII0s7tH8e2F7DgxwngRuHw2DH80TtOZ6Uqj3lAFc+iJ8oZN6PNVihCp48SU0q
	 gYk0Fr5azA4bIs+Yx9J41/OChxwqzXjL/9wv3vJx1uY9e6z24ihD2L3gjwXIerHp6U
	 +keBxh984t/6Y99GvpuwwACopO7NRW8C3Lq3ahLMlcFuH/bubjLEyxrudUBMZyJIH3
	 8ejTNSJrY6rHwCzOT+ZFFeI/EkXRN9JPvpGgGOEhHHg3S0DH2PBsU8nts77BysSQHx
	 SgHicqQE/P4XiaNgAsaS4Xq3gSvYz3btgM119QfJ7WKtdeK0Nh+BXam/MLiNEm2134
	 f6QZXMDLSZU/A==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/5] mm/damon/core: add damon_target->obsolete for pin-point removal
Date: Fri, 17 Oct 2025 09:30:19 -0700
Message-ID: <20251017163021.116255-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMvvPS5gjn6J1dF1O+Hj3CmVcPTQG__zRwqqdBMoRNtptQeOyg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Oct 2025 09:52:16 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> Thanks for working on this SJ!

My pleasure!

> 
> On Thu, Oct 16, 2025 at 4:47 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > DAMON's monitoring targets parameters update function,
> > damon_commit_targets(), is not providing a way to remove a target in the
> > middle of existing targets list.  Extend the API by adding a field to
> > struct damon_target.  If the field of a damon_commit_targets() source
> > target is set, it indicates the matcing target on the existing targets
> > list is obsolete.  damon_commit_targets() understands that and remove
> > those from the list, while respecting the index based matching for other
> > non-obsolete targets.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/linux/damon.h |  6 ++++++
> >  mm/damon/core.c       | 10 +++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 524dea87cac7..8a7b45b9e40d 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -92,17 +92,23 @@ struct damon_region {
> >   * @nr_regions:                Number of monitoring target regions of this target.
> >   * @regions_list:      Head of the monitoring target regions of this target.
> >   * @list:              List head for siblings.
> > + * @obsolete:          Whether the commit destination target is obsolete.
> >   *
> >   * Each monitoring context could have multiple targets.  For example, a context
> >   * for virtual memory address spaces could have multiple target processes.  The
> >   * @pid should be set for appropriate &struct damon_operations including the
> >   * virtual address spaces monitoring operations.
> > + *
> > + * @obsolte is used only for damon_commit_targets() source targets, to specify
> > + * the matching destination targets are obsolte.  Read damon_commit_targets()
> > + * to see how it is handled.
> >   */
> Nit: Twice in the above comment you've written "obsolte" instead of "obsolete."

Thank you for catching this, I will definitely fix those on the next spin.

> 
> With that fixed
> Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
> for the entire series.

Thank you!


Thanks,
SJ

[...]
