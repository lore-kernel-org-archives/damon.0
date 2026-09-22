Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57153CA72;
	Tue, 22 Sep 2026 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080094; cv=none; b=YDSc5yCEyp8cJt0ARRrzJTgzHtt8jTUWVVWhglYDznLmwYIZUVUF9zNu0RFuTCvK3r7no9JpJrvdD6hvCR/2e3E/3zsKpmEHwtuEPsOGIqukBmpcQCryZwGltHoPlXuUSkZzHoQn8Y1pAJsr09okbpRCA31FevMciTHP60tnL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080094; c=relaxed/simple;
	bh=CBNq/q7h+K9XmvP+yU714PyRtRrt2K9y1UWwfYR09Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUp2JQeQzgfxaaB2xMsiax/AnPW3iEBdTph1trl3lqPMZAzU+w7f6Mx309ziuWluO1nXjmEB7hgZG2/9/KxB3MRXRk8kTEmxlBJzmDjO+ibphtAkv0sz5wI+nVRlNgGPD3mH639quxalRsg8yLYEwXF4KEQvvjjZXR6OU36sz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOMlpXB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOMlpXB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C305D1F000FF;
	Tue, 22 Sep 2026 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080093;
	bh=uAPsKVQUv8IOqU7rxK33jeBLp/R7c5bAQs/dZ2U9RP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOMlpXB6Fp14kHIQ98lrV+zKTu+DIcI3LTzpb2qkCj2dg+VWDirc2/qEQXFWDyCKF
	 YTmhffCenEUFn9BXW3Cs9B/R4c9x4Nkocqkhi7bnJNJl5ctCz5MupkcjvATe5yOr5I
	 GwY3wlsjuGDjugyibtsAC67LYxui+8O+TZWdpWnsDhV1iicnPs+5CoAXxAciFcwyBy
	 4RB35VIsyRM47Dh4450fXYfZBR+fUx765j1i3VwJZYBUVY8pNjlqiyVLRGzFL6mp5/
	 jQ6cQ5abSxyaZX5uoOiw+ZwBuhhLLNxRn2kgSQbFWzCGQU9XjV0CeXd3Np9hgVY9HS
	 fNNqzY/gPZ6Uw==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test preservation of caller quota state
Date: Tue, 22 Sep 2026 05:28:08 -0700
Message-ID: <20260922122809.2589-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921003047.12041-3-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 02:30:47 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Check that damon_new_scheme() initializes the new scheme's quota without
> changing the caller's quota. Cover all eight fields initialized by
> damos_quota_init().
> 
> Also check that damon_commit_ctx() preserves those fields in the
> destination scheme for both accepted and rejected parameter updates.
> Use an invalid min_region_sz for the rejected update and confirm that
> returning -EINVAL leaves the running quota state unchanged.
> 
> Without the preceding fix, all eight fields are cleared in the
> constructor test and in both context update cases.

Looks good to me.

> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
