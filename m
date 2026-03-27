Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C31A9FAA;
	Fri, 27 Mar 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583572; cv=none; b=fz1rjKrTOBfJ0bfC3PFcCM3ZU/l86fImlJFHAhFHbm3+9eTykmhkbvZUuKys7FcUQgDFu8TgmXf8v9vLsGBYDpYwMA+AV5/L8AUjEkEw1zmJNKaxHZ4t4v62rctFnEZpZJecniuyaaWZXns92ySAtRktuRTTfZ2/j3FoViB6GMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583572; c=relaxed/simple;
	bh=wVs7w3jdxXfOD1RlM9zy+o9MlvWJ3DIZG90l7SC8t+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp5Wk7HDKF4rqR9ebQ8Gqd3zlNefEUiGC/5ggjp+hFvWesWhEFtLveVEqLqrryW4/PVLKm/lrq1p7r70B3JIWid22O9WUjNRJXdNxMfkTIMjdRmtTwlKit3XNl0AgWmZD/xLMafrYVTMf7LaWxSkvrQPESZsencoL8STfETCwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJsUPkFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJsUPkFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFB9C19423;
	Fri, 27 Mar 2026 03:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774583572;
	bh=wVs7w3jdxXfOD1RlM9zy+o9MlvWJ3DIZG90l7SC8t+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJsUPkFXIjMKbMuUhuV0IJjXQQROMInRb+ewrGDGpmI+hCI2hHd9rGhhamPJARZ27
	 94NDDsc5EuO3P0vx9qChUGsmOYFYV+nKIjmS1HE0PE9ftLmzytBftW7Y0bT1GoNs9I
	 mhK/p7RNI07MVnXf1uqOfYI+crZvyN+A+r96K0dkWYoV2yoyW4egCEnVe/3LkVOBbz
	 UpZ1JmKQnTTf4EQH59hjTneOYBch3xEtE3d6LNWvADJy/xjRxxu1ikFi2K6sEeCix3
	 icyeF2lGJ1eSei4l6FLZEH+eKNVvdQyxSyFRZLBgL6pdOY1wSn56B9Bbr8fMYLVGG5
	 VysA9nC3aF7Rg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 20:52:49 -0700
Message-ID: <20260327035250.67961-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327004952.58266-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 17:49:51 -0700 SeongJae Park <sj@kernel.org> wrote:

> When kdamond_fn() main loop is finished, the function cancels all
> remaining damon_call() requests and unset the damon_ctx->kdamond so that
> API callers can show the context is terminated.  damon_call() adds the
> caller's request to the queue first.  After that, it shows if the
> kdamond of the damon_ctx is still running (damon_ctx->kdamond is set).
> Only if the kdamond is running, damon_call() starts waiting for the
> kdamond's handling of the newly added request.
> 
> The damon_call() requests registration and damon_ctx->kdamond unset are
> protected by different mutexes, though.  Hence, damon_call() could race
> with damon_ctx->kdamond unset, and result in deadlocks.
> 
> For example, let's suppose kdamond successfully finished the
> damon_call() requests cancelling.  Right after that, damon_call() is
> called for the context.  It registers the new request, and shows the
> context is still running, because damon_ctx->kdamond unset is not yet
> done.  Hence the damon_call() caller starts waiting for the handling of
> the request.  However, the kdamond is already on the termination steps,
> so it never handles the new request.  As a result, the damon_call()
> caller threads infinitely waits.
> 
> Fix this by introducing another damon_ctx field, namely
> call_controls_obsolete.  It is protected by the
> damon_ctx->call_controls_lock, which protects damon_call() registration.
> Initialize (unset) it in kdamond_init_ctx()

In this veersion, I updated the initialization to be done in kdamond_fn()
before the damon_started completion.  But I forgot updating the above sentence.
I will make the update in the next version.


Thanks,
SJ

[...]
