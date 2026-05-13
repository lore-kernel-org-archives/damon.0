Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C601E2D94BA
	for <damon@lists.linux.dev>; Wed, 13 May 2026 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649199; cv=none; b=HZyHu0HHlMMX5fq22ZQCa6crb5FScapfcEgBt5Tpa+UIH1+AbcLoLPVr6sgQkqqyuYoP2dW0UvDZ0A6nl8GPkZCM7bYNTGcOk5/cID6ehqXYMqAKdkVcrPR0lJMganFsUpU3JjpwDSr3EHR+ZexbjkHUtlFCpAlpbCwj8lL7jAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649199; c=relaxed/simple;
	bh=Sy5MeDdfBjAPRYiwprhwBQvqfdhmVOXGrQtRL5Zd1y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaJ0ZrbQ6f21lU+VD0xWkSNQ6/qm3V+es7pEySEcoeuaqhJ8QHdeqfnT3MswUK0+xTfzBCRc17G+8WBzqtV8Cl/wZJ4K5iwpsaLm+TA9847Apzdrj+7ncrD1CAJcsAKGAp3zPdsZn0HLfHkh0NaPYFMfyzRzX97nubG5uTt3Wvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX5yiw+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX5yiw+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D95C2BCB7;
	Wed, 13 May 2026 05:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778649199;
	bh=Sy5MeDdfBjAPRYiwprhwBQvqfdhmVOXGrQtRL5Zd1y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SX5yiw+TAi8YJCG8DOdnGj+isIZ5FgSqNWeUOVyRSaQOfDzB3+ff6Zhd7EhliI0YP
	 SJRwBNf+QtemoUJjjqO7hYocBA7ZLULZAuXGTOcDRTi3+y8SooyuCIFJePtYh9QG7r
	 EPOOxsiaHe5aaVw4eq0Tbmofa43P/TewK4sqlf1GzL7XPxQHGTDwWaqmZa59qU7yXW
	 8zOuNVFTpnnSEWPRofmwOFteR+9wJRtTMxRT6FSSp7EbAwaadxANEXxHZotqiZutST
	 EUt2hnvYXb+MyxRDQjbda0vKwz92xGOjzO6CfrhiaORj5hPKPqSJDbzg9FDKYbf6ba
	 1jGDShYEICgIQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Vineet Agarwal" <agarwal.vineet2006@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix double increment of nr_regions
Date: Tue, 12 May 2026 22:12:59 -0700
Message-ID: <20260513051300.216917-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513042154.73E09C2BCB7@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 04:21:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Incomplete fix leaves nr_regions counter permanently leaking on the error path.
> - [High] List corruption and Double Free due to lockless list manipulation in kobject release.
> - [Medium] Region directory naming preserves an unintended 1-based indexing regression.

Findings are same to those raised for the previous revision of this patch.  My
opinion is also same.  None of these are the fault of this patch.  Only the
list corruption issue seems valid and I will work on it.

Read my previous reply [1] for details.

[1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org


Thanks,
SJ

[...]
