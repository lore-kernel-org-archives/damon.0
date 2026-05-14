Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E21EB5FD
	for <damon@lists.linux.dev>; Thu, 14 May 2026 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737020; cv=none; b=dyP1GDOGOUaLLrfIAWOl9z9wqUGkB3I2KG7byV3KPMwD2WmCq+LT4DQ+bwJacs1MRlgvIP/1VvqTv6hO93UrEoeCvPS0459x29gGahyM8pcZ3D+iknNzveVFITV8q4nv4nKFDoVtRxuPrm4BhPbKNdp/mibD/L9/6qwmk/Q9bY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737020; c=relaxed/simple;
	bh=fslKeSL2gSQJZn6coz/MtIxiHznMSwkqecivGcIALmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIfMwHvGbNYpLxNwlYDZAXdNszSXFAuFaa0qIKpqz/1/QtA4wZ7/qwn4avILcFlfIDqBXHxV4jlophkuB0wdgVvjdesocflVtWSmCeUTklguv2+YOs99w70lAo/xZddLfVEF1mdHm1rHA1aSq+UAHCPTC8OXkEJuLfWSn6Mtc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKlotN44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKlotN44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF6BC2BCB7;
	Thu, 14 May 2026 05:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778737019;
	bh=fslKeSL2gSQJZn6coz/MtIxiHznMSwkqecivGcIALmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKlotN44Ic0Mc1PkCsH+EZhbb6IjSYTkPE9d/OhAcrl14H5PaivlS+sKSdlCY4Hc5
	 S6qNDgUg4YcU55cBs5FUmw8uGeR65KhsNBjDvnPmf4NLwzs2JxMj3MMSl+v8iXWIcN
	 EE14NnJIerp0lCvHkQm8NQ+XXjg2mOQjvsyEvb9DHIFyQ68t/87E80ZVonhClSMLJi
	 vucu6/+V/oVvKQacwo+UercoommJ92pWYtHJlvE5g72fSrH6jKeha8RqHccZOEzWBL
	 xaQcm1xbtueZRYjJcXHLCqWzybn8hrY8JtnKlDK3Zl6kpJFiHsOr9kI89SZaccOC02
	 eALnDnwJYfiew==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:36:50 -0700
Message-ID: <20260514053651.112265-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514020506.D1DB7C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 02:05:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Calls to undeclared and undefined functions `damon_is_running()` and `damon_kdamond_pid()` will cause a build failure.

I informed this and where the dependent patches can be found, on the commentary
area of the patch.


Thanks,
SJ

[...]
