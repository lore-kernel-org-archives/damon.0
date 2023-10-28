Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7D944B
	for <damon@lists.linux.dev>; Sat, 28 Oct 2023 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAkFHdXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB32C433C8;
	Sat, 28 Oct 2023 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698527372;
	bh=Wyr214KNSlnSWHwuMNRLzj8fmPHGsLCvoHa+yx4LD2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAkFHdXrEJ5NUZx0+7uR1BgK9gapGCmVtZlckCrNLoKRh322FrjpBp5EyQxesjxAI
	 uHpkCcfmi5pFr7LHoGu8/Q0RwEM6y622KXmLjFQ+8ZxjTFfMcz0U6NeZ6yvBOSaAOq
	 wzP7z4L/N9gjVH/FPAPz/YA4YM3PIkS4fNMkU2ORuT0pl4AhDKLrs1L7N7rd7imngt
	 smoA22ePDhKjc1CKDInPfCPMfxqoQCUBRyVM+3+HL3zs/tX27rfkS0Yjt+OhbT+nH1
	 9tevZoYzzbB8FGlY/W1Kry7tZVlbJSu/wRpJPvUpf4Ou511hW9rfPLs5iWzrkkSSN/
	 7639m0hyt65Aw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/sysfs: remove requested targets when online-commit inputs
Date: Sat, 28 Oct 2023 21:09:30 +0000
Message-Id: <20231028210930.62947-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022210735.46409-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Oct 2023 21:07:33 +0000 SeongJae Park <sj@kernel.org> wrote:

> damon_sysfs_set_targets(), which updates the targets of the context for
> online commitment, do not remove targets that removed from the
> corresponding sysfs files.  As a result, more than intended targets of
> the context can exist and hence consume memory and monitoring CPU
> resource more than expected.
> 
> Fix it by removing all targets of the context and fill up again using
> the user input.  This could cause unnecessary memory dealloc and realloc
> operations, but this is not a hot code path.  Also, note that
> damon_target is stateless, and hence no data is lost.

This is not true.  'struct damon_target' contains monitoring results
(regions_list).  Hence, this patch makes all monitoring results to be removed
whenever doing online-commit.  I was confused with init_regions at the time of
this writing, sorry.

I will send a fix for this soon.


Thanks,
SJ
