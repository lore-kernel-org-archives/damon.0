Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6B4D5962;
	Mon, 21 Sep 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008578; cv=none; b=XQF4lg15TfHwcAud0GHHiJQ0JUamzm0+x74hmAZjp6NIMDZR0X1mfttpiKRljoFo1rlfJjMW4D3ube2lVuUR7q2hcTPtbfk3qlqR7kD7ht+Ws/eziZjBp5FvtF1JoMNTKHo6acHhEnvhFMPMpbLCxy/IQEajawQwg4yIPhn1UDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008578; c=relaxed/simple;
	bh=B1y/e19sBkH6jnaw1dCr8IYTp3sMCyzUTEZOeIGqP74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2/UfYVWVL5e/yDcp/XV38sp5dgjrxxI6hF3l39RBcTI3nvAZ+nwCB1ag9jQIP+B8QvbtHBauHaYCGc9W6VUvNmKxkIA0WPd5ryohFgkMqFEdw1o8B77QrZSMdbgfbfgbqmnsvKxWIVrH20Bmjy1CbGHhX2p+FQz7xu71LdYHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiZr+ppo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiZr+ppo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0A11F000FF;
	Mon, 21 Sep 2026 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008571;
	bh=4mcvkpNssIr9zsxZTvdb3UBAq6HomywEqsmTm1KMjY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EiZr+ppooIZMW0rM50EkJwB3hmEjBh+yQmM16YqF0W51wi83p9SeIEmoGsie+kVtl
	 FEO2LukxA4gzfl8XSR6zm/MTVL7oBF+Q64T24E0IsPAAlr3PiXnwPxkKcsMYAOlQ09
	 u142y4lCKVUiiPSRARmbTKo4yZ9W8WAmhkgwHcXMZhs82/gGNHh9txjAJctPGgQTe4
	 j85aTl3ncOAczAK9NcudNF6KwFUYBXzg1jcJSg9nJffijqo6eAP7XTq+5JWi+RPQ0x
	 WqX6wz9KyDa1ZjYBD+AzfP+MkVlYJk0sPjJ8TD/cl67PQqB8UM9JZqXLqnBaHe4gTs
	 JmOAwKP/zwTHg==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: keep the temporal tuner quota over an unmeasured PSI round
Date: Mon, 21 Sep 2026 09:36:06 -0700
Message-ID: <20260921163607.81366-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921020013.33105-2-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 04:00:12 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Commit b73198a47ffe ("mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total") scores a PSI quota goal without a
> previous sample as achieved. This leaves the consist tuner's input
> unchanged, but the temporal tuner sets its quota to zero for an achieved
> goal. A running scheme with a nonzero temporal quota therefore loses a
> charge window after a quota-goal commit.
> 
> Use the effective quota to preserve the temporal tuner's previous
> goal-achievement state during an unmeasured round, as SJ suggested [1].
> Score the goal as achieved when the effective quota is zero and as not
> achieved otherwise. A new scheme's initially zero quota stays zero, and
> the consist tuner's behavior is unchanged.
> 
> Move the PSI current-value calculation and last_psi_total update into a
> helper that takes the current PSI total. This lets a unit test cover the
> unmeasured and measured rounds without depending on system memory
> pressure.

Looks good to me.

> 
> Fixes: b73198a47ffe ("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total")
> Cc: <stable@vger.kernel.org> # 7.1.x

The broken commit (b73198a47ffe) is not in the mainline but mm-unstable.  We
should squash this to the broken commit before it is merged into the mainline.
Or, maybe pointing the original broken fix (2dbb60f789cb) as 'Fixes:' is
another option.

Do you have a preferrence?

> Suggested-by: SJ Park <sj@kernel.org>
> Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/ [1]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Other than the above,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
