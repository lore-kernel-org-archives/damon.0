Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E51F1537;
	Tue, 15 Jul 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623001; cv=none; b=g1ozMKF2CRkncjgnBZ2zfGHL1w8gFxZ3YJ2/1FncOc7q1GcPQqE8OYIpsHBwJIoJr0W6/ZNqWsOF9IIHED6WgVTjAR5itFH0RWDCnpvOrUCZp8YM5gZ7OmkPMBHxqQgkfG1mdBLGu9MqG1qzUXxOR1GXJJIdOxJiUQmmkEY+0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623001; c=relaxed/simple;
	bh=NqbD9ygF1hlwI4boz9O4hjEYJgzHWcdtC7erVdnxiWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovhRwHZYBYGl25G84Wn0KV+4yCNOilIl71ITIjkofiF5JuTfTHVmqjrlz2UOLf2vQ1MRVEx55URm29Jv/U1fBEFSCyeRWgxM/ZV+9gopX/1sU875kRUijbRpSF1HVENTyXVhimPzwFDr7Smcr7bW4J3ZKpqoulMpHmoGOpeHvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbmlVz+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbmlVz+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224D5C4CEE3;
	Tue, 15 Jul 2025 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622999;
	bh=NqbD9ygF1hlwI4boz9O4hjEYJgzHWcdtC7erVdnxiWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbmlVz+d03qRwos3/KLI4MCbZ0dxgvy+sMbqSQfQPhj8tWYezwOTroxWIdkyoR+0V
	 BqvbHvvcvb7clyEQ60TJME4cNRBPKyFm53LfStCea9jKypX1KbDrmqwTanurdK7DoI
	 XMua84zSY1PEghjPqpaFHSYUEXqrqvv0nWOC4aYmueBQ7wWG+6N1mXdY/Fny5sQrPt
	 u6ma5+nCqewsS/bCdZ9BbtQj3cCNYYHRrM2H1tKrBI48zU+qeb9mWmpJWkB8HKkbXY
	 lK8F7H1mJE2DTUbaa0n6xq0km3zR4ejeTsnxzPaQ5JrMngk7UGqiJoA1n0EneFEEuL
	 yN7NDg1A9bcGw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: support periodic and automated stats update
Date: Tue, 15 Jul 2025 16:43:16 -0700
Message-Id: <20250715234316.91272-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <923d9fe1-b959-4fba-9da7-10d2b3126858@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 07:20:57 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On 7/13/2025 5:46 AM, SeongJae Park wrote:
> > DAMON sysfs interface provides files for reading DAMON internal status
> > including DAMOS stats.  The content of the files are not automatically
> > updated, though.  Users should manually request updates of the contents
> > by writing a special command to 'state' file of each kdamond directory.
> > This interface is good for minimizing overhead, but causes the below
> > problems.
> > 
> > First, the usage is cumbersome.  This is arguably not a big problem,
> > since the user-space tool (damo) can do this instead of the user.
> > 
> > Second, it can be too slow.  The update request is not directly handled
> > by the sysfs interface but kdamond thread.  And kdamond threads wake up
> > only once per the sampling interval.  Hence if sampling interval is not
> > short, each update request could take too long time.  The recommended
> > sampling interval setup is asking DAMON to automatically tune it, within
> > a range between 5 milliseconds and 10 seconds.  On production systems it
> > is not very rare to have a few seconds sampling interval as a result of
> > the auto-tuning, so this can disturb observing DAMON internal status.
> > 
> > Finally, parallel update requests can conflict with each other.  When
> > parallel update requests are received, DAMON sysfs interface simply
> > returns -EBUSY to one of the requests.  DAMON user-space tool is hence
> > implementing its own backoff mechanism, but this can make the operation
> > even slower.
> > 
> > Introduce a new sysfs file, namely refresh_ms, for asking DAMON sysfs
> > interface to repeat the essential contents update with a user-specified
> > time delay.
> 
> Thanks for working on this, but I have a few questions.
> 1. Could you please list up what are the "essential contents"?

Thank you for asking this.  The contents are auto-tuned monitoring intervals,
DAMOS stats, and auto-tuned effective size quota.

I will add these on the next version cover letter.

> 2. Does it mean that it is different from writing "commit" to "state"?
> 3. If not, then is there equivalent action to writing something to "state"?

"refresh_ms" works same to other DAMON parameter files.  You can set it before
starting DAMON, or "commit" new values (including 0 for turning this refresh
off) in runtime.

I'm not that confident if I understood your point very well, especially what
"it"s mean.  Let me know if I'm misunderstanding something.

> 
> If possible, then this kind of information is better to be documented because
> users might get confused if something isn't udpated when "refresh_ms" is set.

You're right!  I'll add above things on the next version of the cover letter.


Thanks,
SJ

[...]
