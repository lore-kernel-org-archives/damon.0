Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5603BCD21;
	Mon,  1 Jun 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324094; cv=none; b=ga1tAql6CVtvcEEXAw1Czj05Qa7kfRQKgO6A3YbjmHypy3Dx0FrcR7+nSQdqiidcemCrq5d+JHtpULW44er9sm6+FJl7WzRfi3VpdxDiqIoz0SVs6HD6cmCXgEWVqPUOZ5HXrPBPo6H8i3MGFDV1jDGs6cw0YpSKq+JqtmaBAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324094; c=relaxed/simple;
	bh=10APA1ND6c/CRRfTMXxUj+BVUJHTq7rw9W9oc99qujk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZz+JaisxRmh+PO7m498cx7LWmtGKuD/clAi+3cp0aeFnqqjwBADjYBYzEP+gE4iruulBA5rlb/3r9H3qft3PwZ72QJNF/FqD/ACoY58BFQWFEnhX3bb5ov1ycSJ8CtLBSoBD9PPx3mg4/f2uFrDgyZ15iiiDDG1qNUF1GYsP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlOKopaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlOKopaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C31F00893;
	Mon,  1 Jun 2026 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324093;
	bh=3OLRhnatnK7tdv0pe9AybKgTFqBAbVUiK1/01rd5ffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mlOKopaJwZrsEmH007+4VQ5cd0S0KeDv82LVgOMZQVobyb8WDoFT15krOPiRD0FG2
	 dbpUWcP6Hwa/kT+rY2HzXjDMC7XwDWi3vdIge2IonOiDJT3yrIs56TquV1QmqrjWYw
	 F/DaM9/UfP3f+/HVoQApbVZKHopIBhfQux6o+1qDz+rbLjh8he1iDp2QA/7ZqoXx1p
	 Msb/8/+Wwkr87ynTGDyZn71BY5aq0mhWVs/kSeSLD1d5yZS7z6rKWDljdsE54Q2Ywt
	 lEf/HuusMPdgh9Aqp5AMTU3VKLR60fPuNaumCPqx+jukcLLKcFnl1WNXHTFFD4WRck
	 japyYGDDlZUOw==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
Date: Mon,  1 Jun 2026 07:28:01 -0700
Message-ID: <20260601142802.111592-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601032314.424013-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  1 Jun 2026 11:23:11 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <chentao@kylinos.cn>
> 
> This series fixes several bugs in the DAMON selftests.  Most are
> trivial but cause tests to silently pass when they shouldn't, or
> fail prematurely on slow machines.
> 
> Patch 1 fixes mutable default arguments in DamonCtx.__init__()
> that cause state to leak between test instances.
> 
> Patch 2 fixes wrong operator precedence and join TypeError in
> damos_tried_regions.py.
> 
> Patch 3 fixes several wrong strings that produce dead elif
> branches, skipped file existence checks, and broken dict key
> lookups.
> 
> Based on next-20260529.
> base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
> ---
> Changes in v2:
> - Fix From:/Signed-off-by mismatch.
> - Add Reviewed-by tags from SeongJae Park.
> - Drop the duplicate memcg_path fix.
> - Drop the empty aggregation-cycle retry fix pending root-cause
>   investigation.
> - No code change

From the next time, please add links to previous versions [1].  For other
readers, the v1 of this series is available on the mailing list [2].

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://lore.kernel.org/20260531085633.48626-1-kunwu.chan@linux.dev


Thanks,
SJ

[....]
