Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9BD101E6;
	Sun, 20 Apr 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178479; cv=none; b=OcvjKr07764OLlBr0B6yrnpEbD88OZUGz1uJIsJMWrLJliFsKR2ibZovT8hLr/eNJ1MNoLWXyfHHps51wZYZ4Ccz/TKhREoEGOXXsu57egXc0lADiPgQNkhV0Cc4BX5yPj6Iv2MG5WgHywHwWFQllhA5KRN6fJWjI+AYG4687sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178479; c=relaxed/simple;
	bh=TE3wplbp/HpSIX1ikJZWqicehqT4BVmSMSnUx6glWCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCa95jEUdMuRN2O7JW3WoGec4OZ9vXvRQ8NCSUK+7XU8tY/9RFTFtU/zOduKAKRaNGr0jaeN1a90WY69WdLrw43MA2lmoaiiBt+Jpm32UoBS9mrRwbp0jUVDOZ79fk5YFTx1DNydaVvDW18jdg2hYuBELgoR+DCksKjJbzU6P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkWDHalK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkWDHalK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0A5C4CEE2;
	Sun, 20 Apr 2025 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178477;
	bh=TE3wplbp/HpSIX1ikJZWqicehqT4BVmSMSnUx6glWCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkWDHalKkgkCcv/OqNI2Z0TAjZ6fZxfxYkhSCO2hG0hm3j9nokhRXjqTgTFKGezxB
	 ACdnGqy7889fNnhqDGPOSkKaeAq9H+hWe1rkaBlnM/ZLZPfcNaK5bTvnKWOUuStdtw
	 rZYVzHOeHVyekj6+ksdm9dr/h/tSopSH4goVG6yK3yv+EjWryy+2vGIkPq2hFB5sJ4
	 zUSAF8x5UGCImqY8wZ8+aqQv1fFzxL/T/HUBtKRtEG6spT763prF0PjoYxzxN/YIiD
	 Mgmp2iC6JxIyew/4w+6YC6pp9HM0sb9MN0n4wn6G2wGFlVxiCC7fpAJ9e0oZmxTwLU
	 qb52K8nLzYjcg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: auto-tune DAMOS for NUMA setups including tiered memory
Date: Sun, 20 Apr 2025 12:47:54 -0700
Message-Id: <20250420194754.76186-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Apr 2025 12:40:23 -0700 SeongJae Park <sj@kernel.org> wrote:

> Utilizing DAMON for memory tiering usually requires manual tuning and/or
> tedious controls.  Let it self-tune hotness and coldness thresholds for
> promotion and demotion aiming high utilization of high memory tiers, by
> introducing new DAMOS quota goal metrics representing the used and the
> free memory ratios of specific NUMA nodes.  And introduce a sample DAMON
> module that demonstrates how the new feature can be used for memory
> tiering use cases.
[...]
> References
> ==========
> 
> [1] https://lore.kernel.org/20231112195602.61525-1-sj@kernel.org/
> [2] https://lore.kernel.org/20250303221726.484227-1-sj@kernel.org
> [3] https://github.com/facebookresearch/DCPerf/blob/main/packages/tao_bench/README.md

Forgot adding below, sorry.

Revision History
================

Changes from RFC
(https://lore.kernel.org/20250320053937.57734-1-sj@kernel.org)
- Wordsmith commit messages
- Add documentations

[...]
