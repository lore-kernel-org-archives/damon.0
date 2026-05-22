Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A8379C5F;
	Fri, 22 May 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480837; cv=none; b=UE1MFfGtXkrqsSLCpgD3qWTLwaCGFAQVBgnw8QmmgmROwdTZNn7Z58zVCwFS7h79RCkk6jBZ/HDokUDf56CuruyLCRMQ0vciNaq1j5yzhy/y30GpscLUqGOQI1f0RVIS+rpN0xObdgAZd3FupxJlxGhyDo1wpywqGcgcWIsNJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480837; c=relaxed/simple;
	bh=GMQRIh20ztI5ejR36leemEkYN/PFLZVCWBH5I2RghJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDR/I89Sf/uf09a4zUtAm4fG1n18GNbwy2XUQJ+zeLinCg8Uni4AHmjo9bNwEC7s0/tYk77Mqd6MMM+RkVfuJJUGfvtTBuQFN/9nJTiqFsYl8oakPPG1+Cog53iIix828uwsKLcwJq5LAHVf4ukTcVEw/Y1J94X5ptXiM/Hrz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCqRj6Yv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCqRj6Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584F11F000E9;
	Fri, 22 May 2026 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779480835;
	bh=JQKwPiPe4zmYUnLVrkzlo3mFd7QXmw6jVxLpTkZDOnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCqRj6YvqI77oOWeDSCmRZqilj5oTId+3kmG36DcwD1Vad8YEhR5VTVjmABTG+gJA
	 YUjHONtNSprnm+0V7z00kDrjWrMq9s1DxBQsytlnxRj+qCCDvkKAu8k8Vu7FyoysGm
	 H7zFZAsqHBAossdYN64qrZNzePMt/PVbsrfqJrCSckXpiyZtaTBXz66TXwWBj4xReU
	 m7vO6U4nkSpNtGgZB8izIfbSrxdLSCRy/EmovUhP++lJj+0I2vfLtZwei2BFD+y0WM
	 QpyuIM0YxG7xmtleAerJCezxOOfvGICJ+bTCHlBBeHKi/IiVcqoZiSIthE9GKIt+cd
	 4LGtRHRINqSHA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/14] mm/damon: minor improvements for code readability and tests
Date: Fri, 22 May 2026 13:13:52 -0700
Message-ID: <20260522201352.3459-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropped individual recipients except Andrew.

On Fri, 22 May 2026 08:40:11 -0700 SeongJae Park <sj@kernel.org> wrote:

> Implement minor improvements on code readability and tests for DAMON.

Sashiko failed reviewing this completely, but found no blockers.  Also it
didn't find a blocker from the previous version of this series, which is same
to this version except the baseline commit.

[1] https://sashiko.dev/#/patchset/20260522154026.80546-1-sj%40kernel.org


Thanks,
SJ

[...]
