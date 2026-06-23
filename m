Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B5D531
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173964; cv=none; b=bxv02IzYZAYzUy/5lV0dNGcu+qkqivIN2vAop1NSXp2x8AglyDurqetAF9r3GTtnhzCw4ZNwWFFM6VPx1ke3Ih9NlRnGeTjf7RIhwqzo0j/Sy3skqTvUCUN2gkLMjKV5f9HYIS6K28fbFPaSwcpRoVlRD8j6na++lE3p8sHngM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173964; c=relaxed/simple;
	bh=b9EqYqFrMUPIVvpNA43TpxOeyA0UykIAEpsSnpZQRM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPwBVCdHacJz7F3fBR55ynLbKCjt+hJcWy+dPtAVP8Rc5Eyp2+XN+Dk2ZylRNpq6U9FQLpEcWKtKdoRx9zFCeIk81Xq2oDOX8IOfVSJSIVkfZLUFnouFIRlve5+pDWTMmxHJolhVd1YfeFFGByoSIS4JJSfMC0Dn04dKIlVB1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy5WQIuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy5WQIuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0041F000E9;
	Tue, 23 Jun 2026 00:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782173962;
	bh=Kn1PRK0HLIANREQQQyLOnS08V2IkYUrXeIm1ZtR6m5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fy5WQIuVaLxBFyiSCRdLMKS2CyiAbFO8skNJsRzJLQLNlblP6gNaovrZwv+j4rJTL
	 PWN0IjHrz5yHQi916YfU7CTlbvdQDEfe5CXUaeUdEcZx+B4DyeIhcU64eB4wwqrEJZ
	 yELlF/AnrioHgfEj3kWZC1MiPMgdw+Lb82XPODDbixePFADGKU8js67/8/24gGb8Op
	 AjoyWJ4ekfbVEBFy2XWxFj/zTrOhi6IjHdp6y4oOMu65kIM7Fj25Yrz/VJA5yIjfLA
	 GCr2jajMnDRHhZeMq7p1lA/u7Cjhwf2nQzhetBcVGiXbC2mtfKFjHx8WGozUjDPZSm
	 E5MywmfPXX1fQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 01/18] mm/damon: introduce damon_nr_accesses_mvsum()
Date: Mon, 22 Jun 2026 17:19:12 -0700
Message-ID: <20260623001913.35319-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622143609.1668B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:36:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Potential 32-bit integer overflow in `damon_nr_accesses_mvsum()` when calculating `left_window_bp` using `mult_frac()` for large interval ratios.

Known low priority issue.  Not a blocker.


Thanks,
SJ

[...]
