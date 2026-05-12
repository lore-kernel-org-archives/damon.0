Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CA226D18
	for <damon@lists.linux.dev>; Tue, 12 May 2026 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556998; cv=none; b=u7o5FOpY6pAm1yc5FgMNPRBNTbZ/BNfaOaqNTuOT6jbHMswg8OEHNNTUsNg0HzAGnvo5ZmyHQv9uivWfdTOv/CCs8zFfYoYwtVOBXw/5USrvxgL3pjEEchmgTh5CprgSgs/KMCMVNJhTAboIMClf1IDFGWhXt+FiA2/T6EbsftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556998; c=relaxed/simple;
	bh=nBacPl1IDyKDaFSd7EUOB0zxBS7q9hwDQXTfwXout78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahA/NSt8BZ99QuYGrrf8dQx2Ci8SfVW0IPtPSK7xNLGIP+yJgbBfhYSn0It+QISga4c9uTHJEnw7i9XQsrLF46hpSHrYlQF9LZiwEhNTzeLMMpiVW52JV7l0h5MnQto8e9ddctdSGV4uLFT3YwbDXnvtGgOTCWGtPRP2YqFisWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZDXYucW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZDXYucW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E911C2BCB0;
	Tue, 12 May 2026 03:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778556998;
	bh=nBacPl1IDyKDaFSd7EUOB0zxBS7q9hwDQXTfwXout78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZDXYucWv1jr6Rg7S8pHZ32pWuwoeCEZ2A9gv61rRHiPXEoggk4ealHA1WnH6c77o
	 bVIYPcoBognsU4yzqjKQbVA6yKgsu5Q+dozHqNViaF9Ae5YcFABykWb93FuxeDCbmP
	 LwyvSxReD3lVfDwR278P42nZbEEvmksNb/vWvPnoWN28xrHtqdSMrKhLYngqAXgMWv
	 Dri8lVeygOg2jcxvMds8oGei5E4/NWJSEt9VoMLrUiaU66baeTt/KPomea1YM5gRJA
	 unIYNwnkSrPDY7eXEjzsld1RvloOqCcBh4P4GeeJhw0G8kuXz3yseJTVjGPFbEKD1t
	 hYxoBgHzp1MHw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 0/2] mm/damon: validate min_region_size to be power of 2
Date: Mon, 11 May 2026 20:36:29 -0700
Message-ID: <20260512033630.39793-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501013750.71704-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Fri,  1 May 2026 09:37:48 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> When a user sets an invalid 'addr_unit' (e.g., 3) via DAMON_LRU_SORT or
> DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2 value. While
> damon_commit_ctx() correctly detects this and returns -EINVAL, it sets
> the 'maybe_corrupted' flag during this process.
> 
> This flag causes the running kdamond to terminate. While the termination
> is a safety measure, it is suboptimal in this case because the error is
> just a simple invalid input from the user, which shouldn't neccessitate
> stopping the kdamond.
> 
> Solution
> ========
> Add an early validation in damon_lru_sort_apply_parameters() and
> damon_reclaim_apply_parameters() to check 'min_region_sz' before any
> state change occurs. If it is non-power-of-2, return -EINVAL immediately,
> preventing 'maybe_corrupted' from being set.


I think this series is good to go in my opinion.  Could you please add this
series into mm.git?


Thanks,
SJ

[...]
